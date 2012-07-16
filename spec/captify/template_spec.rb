require 'helper'
require 'tmpdir'

describe Captify::Template do
  it "can create new template by parsing a dir path." do
    template_path = 'spec/data/files/rubygems/gems/template1-1.0.0/templates/rails-base'

    template = Captify::Template.load_from_path template_path

    template.name.must_equal "rails-base"
    template.base_dir.must_equal template_path
    template.files.sort.must_equal [
      'config/deploy.rb',
      'config/deploy/staging.rb',
      'config/deploy/production.rb'
    ].sort
  end

  it "can handle when template dir path empty." do
    template_path = 'spec/data/files/rubygems/gems/template1-1.0.0/templates/no-file'

    template = Captify::Template.load_from_path template_path

    template.name.must_equal "no-file"
    template.base_dir.must_equal template_path
    template.files.must_equal []
  end

  it "can apply template to target dir" do
    template_path = 'spec/data/files/rubygems/gems/template1-1.0.0/templates/rails-base'
    template = Captify::Template.load_from_path template_path

    Dir.mktmpdir do |temp_dir|
      template.apply_to temp_dir

      File.file?(File.join(temp_dir, 'config/deploy.rb')).must_equal true
      File.file?(File.join(temp_dir, 'config/deploy/staging.rb')).must_equal true
      File.file?(File.join(temp_dir, 'config/deploy/production.rb')).must_equal true
    end
  end

  it "always overwrites existing files in target dir" do
    template_path = 'spec/data/files/rubygems/gems/template1-1.0.0/templates/rails-base'
    template = Captify::Template.load_from_path template_path

    Dir.mktmpdir do |temp_dir|

      deploy_rb = File.join(temp_dir, 'config/deploy.rb')
      FileUtils.mkdir_p File.dirname(deploy_rb)
      File.open(deploy_rb, 'w') {|f| f.write("test") }

      template.apply_to temp_dir

      File.open(deploy_rb) {|f| f.read }.wont_equal "test"
      File.file?(File.join(temp_dir, 'config/deploy.rb')).must_equal true
      File.file?(File.join(temp_dir, 'config/deploy/staging.rb')).must_equal true
      File.file?(File.join(temp_dir, 'config/deploy/production.rb')).must_equal true
    end
  end
end
