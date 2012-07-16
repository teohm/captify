module Captify
  class Runner

    def initialize(template_loader=TemplateLoader.new, kernel=Kernel)
      @template_loader = template_loader
      @kernel = kernel
      @default_options = {:load_path_only => false}
    end

    def run(template_name, target_dir, options={})
      raise ArgumentError, "'#{target_dir}' does not exist." unless File.exist? target_dir
      raise ArgumentError, "'#{target_dir}' is not a directory." unless File.directory? target_dir

      options = @default_options.merge(options)

      @template_loader.reload! options[:load_path_only]

      template = @template_loader.find(template_name)
      unless template
        raise ArgumentError, "template not found: '#{template_name}'"
      end

      @kernel.puts "[apply] template '#{template_name}'"

      logs = template.apply_to(target_dir)
      logs.each{|msg| @kernel.puts msg}

      @kernel.puts "[done] captified!"
    end
  end
end
