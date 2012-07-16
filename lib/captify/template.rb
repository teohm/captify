require 'fileutils'

module Captify
  class Template
    attr_accessor :name, :base_dir, :files

    def apply_to(target_dir)
      msg = []
      files.each do |file|
        target_file = File.join(target_dir, file)
        prefix = File.exist?(target_file) ? "[overwrite]" : '[add]'

        FileUtils.mkdir_p File.dirname(target_file)
        FileUtils.cp File.join(base_dir, file), target_file

        msg << "#{prefix} writing '#{target_file}'"
      end
      return msg
    end

    def self.load_from_path(path)
      return nil unless File.exists? path

      self.new.tap do |t|
        t.name = File.basename path
        t.base_dir = path
        t.files = Dir[ File.join(path, '**', '*') ].
          select{|item| File.file? item}.
          map{|file| file.sub(path+"/", '')}
      end
    end
  end
end
