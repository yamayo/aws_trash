# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aws_trash/version'

Gem::Specification.new do |spec|
  spec.name          = "aws_trash"
  spec.version       = AwsTrash::VERSION
  spec.authors       = ["yamayo"]
  spec.email         = ["yamayo@gmail.com"]
  spec.description   = %q{Trash for AWS Resources}
  spec.summary       = %q{aws_trash is a trash cleaner for AWS resources}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.18.1"
  spec.add_runtime_dependency "terminal-table"
  spec.add_runtime_dependency 'highline'
  spec.add_runtime_dependency 'aws-sdk'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
