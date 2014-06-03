require 'highline'
require 'terminal-table'
require 'thor'
require 'aws_trash/dotfile'
require 'aws-sdk'

module AwsTrash
  class AwsCLI < Thor

    class_option :access_key_id, aliases: '-O', desc: 'AWS Access Key ID.'
    class_option :secret_access_key, aliases: '-W', desc: 'AWS Secret Key ID.'  
    class_option :region, desc: 'AWS Region Name.'
    class_option :path, banner: "$HOME/.aws_trash/config.yml"

    no_tasks do

      def initialize(args, opts, config)
        super

        @config = Dotfile.load(config_path).merge!(option_config) {|key, old, new|
          new.nil? ? old : new
        }
      rescue => e
        red e.message
        exit
      end
    
      def config_path               
        options[:path] || "#{ENV['HOME']}/.aws_trash/config.yml"
      end

      def option_config
        {
          access_key_id:     options[:access_key_id],
          secret_access_key: options[:secret_access_key],
          region:            region
        }        
      end
     
      def region
        @region ||= options[:region]
      end

      def hl
        @hl ||= HighLine.new
      end

      [:red, :green, :yellow].each do |col|
        define_method(col) do |obj|
          puts hl.color(obj.to_s, col)
        end
      end

    end
  end
end
