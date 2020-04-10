require_relative 'lib/mongo/falsehoods/version'

Gem::Specification.new do |spec|
  spec.name          = "mongo-falsehoods"
  spec.version       = Mongo::Falsehoods::VERSION
  spec.authors       = ["Jon Evans"]
  spec.email         = ["jon@bonus.ly"]

  spec.summary       = %q{Modify Mongoid to allow storing `DateTime` fields as `false` instead of `null`.}
  spec.description   = %q{Mongo indexes do not handle querying by null values well. If we store them as false instead, we get improved index usage and faster queries.}
  spec.homepage      = "https://github.com/bonusly/mongo-falsehoods"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
