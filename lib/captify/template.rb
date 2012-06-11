module Captify
  class Template
    def self.load_all
     # find_in_load_path
     $LOAD_PATH.each do |path|
       template_path = File.join(path, 'captify_template.rb')
       load template_path if File.exist? template_path
     end

     # find_in_latest_gem_require_paths 
     Gem.latest_load_paths.each do |path|
       template_path = File.join(path, 'captify_template.rb')
       load template_path if File.exist? template_path
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
        @@templates[name] = files unless @@templates[name].nil?
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

