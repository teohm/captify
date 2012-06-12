module Captify
  class Template

    def self.find_files_in_load_path(glob)
      $LOAD_PATH.map { |load_path|
        Dir["#{File.expand_path glob, load_path}#{Gem.suffix_pattern}"]
      }.flatten.select { |file| File.file? file.untaint }
    end

    def self.find_files_in_latest_gems(glob, prelease=false)
      Gem::Specification.latest_specs(:prelease => prelease).map { |spec|
        spec.matches_for_glob("#{glob}#{Gem.suffix_pattern}")
      }.flatten
    end

    def self.find_latest_files(glob, check_load_path=true)
      files = []
      files = find_files_in_load_path(glob) if check_load_path
      files.concat find_files_in_latest_gems(glob)
      return files
    end

    def self.load_all
     find_latest_files('captify_template').each do |path|
       load path if File.exist? path
     end
    end

    def self.template_files(template_name)
      @@templates ||= {}
      @@templates.fetch(template_name, [])
    end

    protected

    def self.inherited(subclass)
      file_path = extract_file_path caller
      templates_path = get_templates_path file_path
      dirs = find_all_template_dir templates_path

      @@templates ||= {}
      dirs.each do |dir|
        name, files = extract_template_name_and_files dir
        if @@templates[name].nil?
          @@templates[name] = files
        else
          puts "[captify] warn: template `#{name}' already loaded, ignore `#{file_path}'"
        end
      end
    end

    def self.extract_template_name_and_files(dir)
      name  = File.basename dir
      files = Dir[ File.join(dir, '**', '*') ]
      files = files.select{|path| File.file? path}

      [name, files]
    end

    def self.extract_file_path(caller_value)
      caller_value.first[/^[^:]+/]
    end

    def self.get_templates_path(file_path)
      File.realdirpath File.join(File.dirname(file_path), '..', 'templates')
    end

    def self.find_all_template_dir(templates_path)
      Dir[ File.join(templates_path, '*') ]
    end
  end
end

