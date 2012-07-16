require 'helper'
require 'tmpdir'

describe Captify::Runner do
  FILES_DIR = 'spec/data/files'
  LOAD_PATH_DIR = "#{FILES_DIR}/load_path"
  RUBYGEMS_DIR = "#{FILES_DIR}/rubygems"

  before do
    load_path = [ ]
    gem_spec = Object.new
    def gem_spec.latest_specs
      [ Gem::Specification.load("#{RUBYGEMS_DIR}/specifications/template1-1.0.0.gemspec") ]
    end

    kernel = Object.new
    def kernel.puts(msg)
    end

    @runner = Captify::Runner.new(
      Captify::TemplateLoader.new(
        :load_path => load_path,
        :gem_spec => gem_spec
      ),
      kernel
    )
  end

  it "can captify the target dir" do
    Dir.mktmpdir do |temp_dir|
      @runner.run('rails-base', temp_dir,
        :load_path_only => false,
        :force => false
      )
      File.exist?(File.join(temp_dir, 'config/deploy.rb')).must_equal true
      File.exist?(File.join(temp_dir, 'config/deploy/staging.rb')).must_equal true
      File.exist?(File.join(temp_dir, 'config/deploy/production.rb')).must_equal true
    end
  end

  it "can handle when template not found" do
    lambda { @runner.run('not-exist', 'not-exist') }.must_raise ArgumentError
  end

  it "throws error when target dir not exists" do
    lambda { @runner.run('rails-base', 'not-exist') }.must_raise ArgumentError
  end

  it "throws error when target dir is not a directory" do
    lambda { @runner.run('rails-base', __FILE__) }.must_raise ArgumentError
  end
end
