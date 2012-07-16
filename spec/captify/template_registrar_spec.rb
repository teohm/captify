require 'helper'

describe "Register template" do

  it "can register all templates under templates/" do

    templates_path = 'spec/data/files/rubygems/gems/template1-1.0.0/templates'
    template_builder = MiniTest::Mock.new
    registrar = Captify::TemplateRegistrar.new(template_builder)

    fake_template1 = Captify::Template.new.tap do |t|
      t.name = 'rails-base'
    end
    fake_template2 = Captify::Template.new.tap do |t|
      t.name = 'sinatra-base'
    end
    fake_template3 = Captify::Template.new.tap do |t|
      t.name = 'no-file'
    end
    template_builder.expect :load_from_path, fake_template3,
      [File.expand_path(File.join(templates_path, 'no-file'))]
    template_builder.expect :load_from_path, fake_template1,
      [File.expand_path(File.join(templates_path, 'rails-base'))]
    template_builder.expect :load_from_path, fake_template2,
      [File.expand_path(File.join(templates_path, 'sinatra-base'))]

    registrar.register_templates_in_dir templates_path 

    template_builder.verify
    registrar.template_count.must_equal 3
    registrar.find('rails-base').must_be_same_as fake_template1
    registrar.find('sinatra-base').must_be_same_as fake_template2
    registrar.find('no-file').must_be_same_as fake_template3
  end

  it "can handle when templates/ does not exist." do

    templates_path = 'spec/data/files/rubygems/gems/template2-1.0.0/templates'
    registrar = Captify::TemplateRegistrar.new

    registrar.register_templates_in_dir templates_path

    registrar.template_count.must_equal 0
  end

end
