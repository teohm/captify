require 'helper'

describe Captify::Cli do
  before do
    @kernel = MiniTest::Mock.new
    @cli = Captify::Cli.new(@kernel)
  end
  describe "Parse options" do
    it "parses all options" do
      opts = @cli.parse_argv %w(-t rails-base .)
      opts.must_equal(
        :target_dir => '.',
        :template_name => 'rails-base'
      )
    end
    it "without template_name" do
      opts = @cli.parse_argv %w(.)
      opts.must_equal(
        :target_dir => '.'
      )
    end
  end

  describe "Exit exceptions" do
    it "exits when display help" do
      @kernel.expect :puts, nil, [String]
      @kernel.expect :exit, nil, []
      @cli.parse_argv %w(-h)
      @kernel.verify
    end
  end

  describe "Abort exceptions" do
    it "aborts when missing target dir" do
      @kernel.expect :abort, nil, ["Please specify a target dir."]
      @cli.parse_argv %w(-t rails-base)
      @kernel.verify
    end
    it "aborts when more than one target dir" do
      @kernel.expect :abort, nil, ["Too many target dirs; please specify only the dir to captify."]
      @cli.parse_argv %w(-t rails-base dir1 dir2)
      @kernel.verify
    end
  end
end
