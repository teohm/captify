require 'captify/cli'
require 'captify/template_loader'
require 'captify/template_registrar'
require 'captify/template'
require 'captify/template_bundle'
require 'captify/runner'

module Captify
  def self.run(argv=ARGV, env=ENV)
    opts = Cli.new.parse_argv argv

    puts `capify #{opts[:target_dir]}`

    begin
      Runner.new.run(
        opts.delete(:template_name) || ENV['CAPTIFY_TEMPLATE'],
        opts.delete(:target_dir),
        opts
      )
    rescue ArgumentError => ex
      puts ex.message
    end
  end
end

