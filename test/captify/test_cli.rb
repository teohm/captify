require 'helper'

describe Captify::Cli do

  before do
    @cli = Captify::Cli.new
  end

  it "should parse expected options" do
    argv = %w(-t rails-base .)
    options = @cli.parse(argv)

    expected_options = {
      :template_name => 'rails-base',
      :target_dir => '.'
    }
    argv.length.must_equal 3
    options.must_equal expected_options
  end

  describe "Abort with help message" do 
    HELP_MSG = /Usage:/

    def assert_system_exit
      ex = nil
      out, err = capture_io do
        ex = proc { yield }.must_raise SystemExit
      end
      [ex, out, err]
    end


    it "given help flag" do
      argv = %w(-h)
      ex, out, err = assert_system_exit do
        @cli.parse(argv)
      end
      ex.message.must_equal 'exit'
      out.must_match HELP_MSG
    end

    it "given invalid option" do
      argv = %w(--notexist .)
      ex, out, err = assert_system_exit do
        @cli.parse(argv)
      end
      ex.message.must_match HELP_MSG
    end

    it "given no target dir" do
      argv = %w(-t rails-base )
      ex, out, err = assert_system_exit do
        @cli.parse(argv)
      end
      ex.message.must_match HELP_MSG
      ex.message.must_match /target dir/
    end

    it "given non-exist target dir" do
      argv = %w(nonexist_dir)
      ex, out, err = assert_system_exit do
        @cli.parse(argv)
      end
      ex.message.must_match HELP_MSG
      ex.message.must_match /not exist/
    end

    it "given target dir is not a directory" do
      require 'tempfile'
      file = Tempfile.new('foo')

      argv = [file.path]
      ex, out, err = assert_system_exit do
        @cli.parse(argv)
      end
      ex.message.must_match HELP_MSG
      ex.message.must_match /not a directory/

      file.close
      file.unlink
    end

    it "given more than 1 target dir" do
      argv = %w(. .)
      ex, out, err = assert_system_exit do
        @cli.parse(argv)
      end
      ex.message.must_match HELP_MSG
      ex.message.must_match /many target dirs/
    end

  end
end
