require 'aws_trash/s3'
require 'aws_trash/ec2'
require 'aws_trash/dotfile'

module AwsTrash
  class CLI < Thor
    register(S3, 's3', 's3 [COMMAND]', 'Amazon S3 Commands.') 
    register(EC2, 'ec2', 'ec2 [COMMAND]', 'Amazon EC2 Commands.') 

    desc 'save_aws_keys', 'Save AWS Keys'
    method_option :access_key_id, aliases: '-O', desc: 'AWS Access Key ID.'
    method_option :secret_access_key, aliases: '-W', desc: 'AWS Secret Key ID.'  
    method_option :region, desc: 'AWS Region Name.'
    method_option :path, banner: "$HOME/.aws_trash/config.yml", default: "#{ENV['HOME']}/.aws_trash/config.yml"
    def save_aws_keys
      config = {
        access_key_id:     options[:access_key_id],
        secret_access_key: options[:secret_access_key],
        region:            options[:region]
      }
      Dotfile.save(options[:path], config)
      puts "Saved AWS keys in #{options.path}"
    end

  end
end
