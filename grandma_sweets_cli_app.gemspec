# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grandma_sweets_cli_app/version'

Gem::Specification.new do |spec|
  spec.name          = "grandma_sweets_cli_app"
  spec.version       = GrandmaSweetsCliApp::VERSION
  spec.authors       = ["gnappo1"]
  spec.email         = ["gnappo.1@live.it"]

  spec.summary       = %q{Rubygem that provides the user Italian dessert recipes to experiment with}
  spec.description   = %q{Grandma_sweets_cli_app is a gem that will allow you to explore some of the most famous Italian tradition dessert recipes, giving details and procedures to help you impress your guests, and yourself! }
  spec.homepage      = "https://github.com/gnappo1/grandma_sweets_cli_app"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://mygemserver.com'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "colorize", "~> 0.8.1"
  spec.add_dependency "nokogiri"
end
