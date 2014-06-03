require 'aws-sdk'
require 'aws_trash/aws_cli'

module AwsTrash
  class S3 < AwsCLI
    namespace :s3
    
    desc 'list_buckets', 'Returns a list of all buckets.'
    def list_buckets
      buckets = s3.list_buckets
      rows = []
      buckets.buckets.each do |bucket|
        rows << ["#{bucket[:name]}", "#{bucket[:creation_date]}"]
      end
      table = Terminal::Table.new headings: ['BucketName', 'CreationDate'], rows: rows
      puts table                       
    rescue => e
      red e.message
    end
     
    desc 'list_buckets_for_no_objects', 'Returns a list of all buckets for no objects.'
    def list_buckets_for_no_objects
      buckets = s3.list_buckets
      rows = []
      buckets.buckets.each do |bucket|
        objects = s3.list_objects(bucket_name: bucket[:name])
        if objects.contents.size == 0
          rows << ["#{bucket[:name]}", "#{objects.contents.size}", "#{bucket[:creation_date]}"]
        end
      end
      table = Terminal::Table.new headings: ['BucketName', 'ContentsSize', 'CreationDate'], rows: rows
      puts table
    rescue => e
      red e.message
    end 

    desc 'delete_buckets_for_no_objects', 'Delete buckets for no objects.'
    def delete_buckets_for_no_objects
      buckets = s3.list_buckets
      rows = []
      buckets.buckets.each do |bucket|
        objects = s3.list_objects(bucket_name: bucket[:name])
        if objects.contents.size == 0
          # TODO
        end
      end
    rescue => e
      red e.message 
    end
     
    no_tasks do 
      def s3
        @s3 ||= AWS::S3::Client.new(@config)
      end
    end
     
  end
end
