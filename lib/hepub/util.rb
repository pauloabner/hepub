module Hepub
  class Util
    def self.tags_from_file(filepath)
      raise IOError if filepath.nil? || !File.exist?(filepath)
      str = file_to_str filepath
      tags_from_string str
    end

    def self.tags_from_string(string)
      return [] if string.nil?
      regexp = /\{\{\s(.*?)\s\}\}/
      string.scan(regexp).map(&:join)
    end

    def self.file_to_str(file_path)
      file = File.open(file_path, 'r')
      data = ''
      file.each_line do |line|
        data += line unless line.empty?
      end
      data
    end
  end
end
