require 'aws-sdk'
require 'aws_trash/aws_cli'

module AwsTrash
  class EC2 < AwsCLI
    namespace :ec2

    desc 'describe_not_associate_addresses', 'Returns elastic IP addresses for not associate.'
    def describe_not_associate_addresses
      addresss = ec2.describe_addresses
      rows = []
      addresss.addresses_set.each do |address|
        if address[:instance_id] == nil
          rows << ["#{address[:public_ip]}"]
        end
      end
      table = Terminal::Table.new headings: ['Elastic address'], rows: rows
      puts table
    rescue => e
      red e.message
    end

    desc 'release_not_associate_addresses', 'Release elastic IP addresses for not associate.'
    def release_not_associate_addresses
      addresss = ec2.describe_addresses
      rows = []
      addresss.addresses_set.each do |address|
        if address[:instance_id] == nil
          eip = AWS::EC2::ElasticIp.new(address[:public_ip])
          puts eip
          eip.delete
        end
      end
    rescue => e
      red e.message
    end 

    no_tasks do

      def initialize(args, opts, config) 
        super

        AWS.config(@config)
      end

      def ec2
        @ec2 ||= AWS::EC2::Client.new
      end
    end
  end
end 
