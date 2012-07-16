require 'helper'

describe Captify::TemplateBundle do

  describe "Subclass Captify::Template" do
    it "finds templates/ dir in root path" do
      caller_file_path = File.expand_path('spec/data/files/rubygems/gems/template1-1.0.0/lib/template_bundle.rb')
      path = Captify::TemplateBundle.find_templates_path(caller_file_path, File.expand_path('.'))
      path.must_equal File.expand_path('spec/data/files/rubygems/gems/template1-1.0.0/templates')
    end

    it "treats template_bundle.rb parent dir as root path if cannot find lib/ dir" do
      caller_file_path = File.expand_path 'spec/data/files/load_path/template-without-lib/template_bundle.rb'
      path = Captify::TemplateBundle.find_templates_path(caller_file_path, File.expand_path('.'))
      path.must_equal File.expand_path('spec/data/files/load_path/template-without-lib/templates')
    end

    it "passes dirname correctly into Template Registrar." do
      received_path = ""
      Captify::TemplateRegistrar.instance.stub :register_templates_in_dir,
                            lambda{|path| received_path = path} do

        load 'spec/data/files/load_path/template1/lib/template_bundle.rb'

      end
      received_path.must_equal File.expand_path('spec/data/files/load_path/template1/templates')

    end
  end
end
