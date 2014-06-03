module AwsTrash
  class Dotfile
    class << self
      def save(path, config)
        dirname = File.dirname(path)
        Dir.mkdir(dirname) unless File.exist?(dirname)
        open(path, 'w') {|f| f.write config.to_yaml }
      end

      def load(path)
        File.exist?(path) ? YAML.load(File.read(path)) : {}
      end
    end
  end
end
