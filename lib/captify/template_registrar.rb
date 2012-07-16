require 'captify/template'

module Captify
  class TemplateRegistrar

    def initialize(template_builder=Captify::Template)
      @template_builder = template_builder
      @templates = {}
    end

    @@instance = TemplateRegistrar.new

    def self.instance
      @@instance
    end

    def register_templates_in_dir(root_dir)
      template_dirs(root_dir).each do |dir|
        if template = @template_builder.load_from_path(dir)
          register template
        end
      end
    end

    def template_count
      @templates.count
    end

    def register(template)
      @templates[template.name] = template unless @templates.key? template.name
    end

    def find(template_name)
      @templates[template_name]
    end

    private

    def template_dirs(root_path)
      Dir[ File.join(File.expand_path(root_path), '*') ]
    end

  end
end
