module Captify

  # Capture inputs from command line interface.
  #
  class Cli

    # Parse ARGV and return captify option hash.
    #
    # The returned hash should contain:
    # [:template_name] the template to use when captify.
    # [:target_dir]    the target directory to run captify.
    #
    def parse(argv)
      options  = {}
      parse_options! argv.clone, options
      return options
    end

    private

    def abort(msg)
      Kernel.abort msg 
    end

    def parse_options!(argv, options)
      parser = new_parser(options)
      begin 
        parser.parse!(argv)
      rescue OptionParser::InvalidOption => ex
        abort ex.message + "\n\n#{parser.help}"
      end
      parse_target_dir!(argv, options, parser.help)
    end


    def new_parser(options)
      OptionParser.new do |opts|
        opts.banner = "Usage: captify [options] directory"
        opts.separator ""
        opts.separator "Options:"

        opts.on("-t", "--template TEMPLATE_NAME", 
                "Specify the template to be used") do |template|
          options[:template_name] = template
        end

        opts.on_tail("-h", "--help", "Show this message") do 
          puts opts.help
          exit
        end
      end
    end

    def parse_target_dir!(argv, options, help_msg)
      if argv.empty?
        abort "Please specify a target dir, e.g. `#{File.basename($0)} .'\n\n#{help_msg}"
      elsif !File.exists?(argv.first)
        abort "`#{argv.first}' does not exist.\n\n#{help_msg}"
      elsif !File.directory?(argv.first)
        abort "`#{argv.first}' is not a directory.\n\n#{help_msg}"
      elsif argv.length > 1
        abort "Too many target dirs; please specify only the directory to captify.\n\n#{help_msg}"
      end

      options[:target_dir] = argv.delete_at(0)
    end

  end
end
