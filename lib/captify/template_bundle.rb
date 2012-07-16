require 'captify/template_registrar'

module Captify
  class TemplateBundle
    def self.register
      templates_path = find_templates_path(file_path(Kernel.caller.first))
      TemplateRegistrar.instance.register_templates_in_dir templates_path
    end

    def self.find_templates_path(caller_file_path, root="/")
      base_path = find_base_path(caller_file_path, root)
      File.join(base_path, 'templates')
    end

    def self.find_base_path(caller_file_path, root="/")
      base_path = File.dirname(File.expand_path(caller_file_path))
      default_base_path = base_path

      while base_path && File.directory?(base_path) && !File.exist?(File.join(base_path,'lib'))
        parent = File.dirname base_path
        if parent == root
          base_path = default_base_path
          break
        end
        base_path = parent
      end

      return base_path
    end

    private

    def self.file_path(call_stack_item)
      extract_file = /^[^:]+/
      File.expand_path call_stack_item[extract_file]
    end
  end
end
