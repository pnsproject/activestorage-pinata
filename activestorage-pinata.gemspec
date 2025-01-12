require_relative 'lib/active_storage/service/version'

Gem::Specification.new do |spec|
  spec.name = 'activestorage-pinata'
  spec.version = ActiveStorage::PinataService::VERSION
  spec.authors = ["John Callahan", "Carl Tanner"]
  spec.email = ["jcallahan@acm.org", "carl@wdwhub.net"]

  spec.summary = ""
  spec.description = "An ActiveStorage Service"
  spec.homepage = "http://github.com/captproton/activestorage-pinata"
  spec.license = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/captproton/activestorage-pinata"
  spec.metadata["changelog_uri"] = "http://github.com/captproton/activestorage-pinata"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'http', '~> 4.3'
  spec.add_dependency 'rest-client', '~> 2.1.0'
end
