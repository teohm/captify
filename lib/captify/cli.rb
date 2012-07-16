require 'optparse'

module Captify

  # Capture inputs from command line interface.
  #
  class Cli

    def initialize(kernel=Kernel)
      @kernel = kernel
    end

    def parse_argv(argv)
      options = {}
      argv = argv.clone
      parse_options! argv, options
      parse_target_dir! argv, options
      return options
    rescue AbortException => ex
      @kernel.abort "#{ex.message}"
    rescue ExitException => ex
      @kernel.puts "#{ex.message}"
      @kernel.exit
    end

    private

    class AbortException < StandardError; end
    class ExitException < StandardError; end

    def parse_target_dir!(argv, options)
      if argv.empty?
        raise AbortException, "Please specify a target dir."
      elsif argv.length > 1
        raise AbortException, "Too many target dirs; please specify only the dir to captify."
      end

      options[:target_dir] = argv.delete_at(0)
    end

    def parse_options!(argv, options)
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: captify [options] directory"
        opts.separator ""
        opts.separator "Options:"
        opts.on("-t", "--template TEMPLATE_NAME", 
                "Specify the template to be used") do |template|
          options[:template_name] = template
        end
        opts.on_tail("-h", "--help", "Show this message") do 
          raise ExitException, opts.help
        end
      end
      opts.parse! argv
      return opts.help
    rescue OptionParser::InvalidOption => ex
      raise AbortException, "#{ex.message}\n\n#{opts.help}"
    end

  end
end
