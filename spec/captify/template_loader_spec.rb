require 'helper'

describe Captify::TemplateLoader do

  before do
    @file_dir = 'spec/data/files'
    @load_path_dir = "#{@file_dir}/load_path"
    @rubygems_dir = "#{@file_dir}/rubygems"

    @load_path = [
      "#{@load_path_dir}/template1/lib",
      "#{@load_path_dir}/template2/lib",
      "#{@load_path_dir}/not-template/lib"
    ]
    @gem_spec = MiniTest::Mock.new
    @gem_spec.expect :latest_specs, [
      Gem::Specification.load("#{@rubygems_dir}/specifications/template1-1.0.0.gemspec"),
      Gem::Specification.load("#{@rubygems_dir}/specifications/template2-1.0.0.gemspec"),
      Gem::Specification.load("#{@rubygems_dir}/specifications/not-template-1.0.0.gemspec")
    ]
    @kernel = MiniTest::Mock.new

    @loader = Captify::TemplateLoader.new(
      :load_path => @load_path,
      :gem_spec  => @gem_spec,
      :kernel    => @kernel)
  end

  it "can load captify_template.rb from load paths, then from latest gems." do
    [
      "#{@load_path_dir}/template1",
      "#{@load_path_dir}/template2",
      "#{@rubygems_dir}/gems/template1-1.0.0",
      "#{@rubygems_dir}/gems/template2-1.0.0"
    ].each do |path|
      @kernel.expect :load, nil, [File.expand_path("#{path}/lib/template_bundle.rb")]
    end

    @loader.reload!

    @kernel.verify
  end

  it "can load captify_template.rb from load paths only." do
    load_path_only = true
    [
      "#{@load_path_dir}/template1",
      "#{@load_path_dir}/template2"
    ].each do |path|
      @kernel.expect :load, nil, [File.expand_path("#{path}/lib/template_bundle.rb")]
    end

    @loader.reload! load_path_only

    @kernel.verify
  end
end
