module Captify
  class TemplateLoader

    def initialize(opts={})
      @file_name_pattern   = opts.fetch(:file_name_pattern,   'template_bundle')
      @file_suffix_pattern = opts.fetch(:file_suffix_pattern, Gem.suffix_pattern)

      @load_path = opts.fetch(:load_path, $LOAD_PATH)
      @gem_spec  = opts.fetch(:gem_spec,  Gem::Specification)
      @kernel    = opts.fetch(:kernel,    Kernel)
      @file      = opts.fetch(:file,      File)
    end

    def reload!(load_path_only=false)
      latest_files(@file_name_pattern, load_path_only).each do |path|
        @kernel.load path if @file.exist? path
      end
    end

    def find(template_name)
      Captify::TemplateRegistrar.instance.find template_name
    end

    private

    def latest_files(glob, load_path_only)
      files = []
      files.concat find_load_path_files(glob)
      files.concat find_latest_gem_files(glob) unless load_path_only
      return files
    end

    def find_load_path_files(glob)
      @load_path.map { |load_path|
        Dir["#{@file.expand_path glob, load_path}#{@file_suffix_pattern}"]
      }.flatten.select { |file| @file.file? file.untaint }
    end

    def find_latest_gem_files(glob)
      @gem_spec.latest_specs.map { |spec|
        spec.matches_for_glob("#{glob}#{@file_suffix_pattern}")
      }.flatten
    end
  end
end

