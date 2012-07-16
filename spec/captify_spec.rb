require 'helper'
require 'tmpdir'

describe Captify do
  it "can run captify" do
    Dir.mktmpdir do |tmp_dir|
      ENV['CAPTIFY_TEMPLATE'] = 'rails-base'
      ENV['BUNDLE_GEMFILE'] = 'spec/data/files/Gemfile.test_captify'

      `bundle exec ./bin/captify #{tmp_dir}`

      File.exist?(File.join(tmp_dir, 'Capfile')).must_equal true
      File.exist?(File.join(tmp_dir, 'config/deploy.rb')).must_equal true
      File.exist?(File.join(tmp_dir, 'config/deploy/staging.rb')).must_equal true
      File.exist?(File.join(tmp_dir, 'config/deploy/production.rb')).must_equal true
    end
  end
end
