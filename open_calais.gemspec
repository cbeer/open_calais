# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_calais/version'

Gem::Specification.new do |gem|
  gem.name          = "open_calais"
  gem.version       = OpenCalais::VERSION
  gem.authors       = ["Andrew Kuklewicz"]
  gem.email         = ["andrew@prx.org"]
  gem.summary       = %q{This is a gem to call the OpenCalais improved REST API.}
  gem.description   = %q{This is a gem to call the OpenCalais improved REST API. http://www.opencalais.com/ http://www.opencalais.com/documentation/calais-web-service-api/api-invocation/rest}
  gem.homepage      = "https://github.com/PRX/open_calais"


  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('faraday', ['>= 0.7.4', '< 0.9'])
  gem.add_runtime_dependency('faraday_middleware', '~> 0.9')
  gem.add_runtime_dependency('multi_json', '>= 1.0.3', '~> 1.0')
  gem.add_runtime_dependency('multi_xml')
  gem.add_runtime_dependency('excon')
  gem.add_runtime_dependency('hashie',  '>= 0.4.0')

  gem.add_development_dependency('rake')
  gem.add_development_dependency('minitest')
end
