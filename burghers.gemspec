lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'burghers/version'

Gem::Specification.new do |gem|
  gem.name          = "burghers"
  gem.version       = Burghers::VERSION
  gem.authors       = ["Brian Muller"]
  gem.email         = ["bamuller@gmail.com"]
  gem.description   = %q{Use Open Calais. Easily.}
  gem.summary       = %q{Use Open Calais. Easily.}
  gem.homepage      = "https://github.com/bmuller/burghers"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.require_paths = ["lib"]
  gem.add_dependency("httparty", ">= 0.9.0")
  gem.add_development_dependency("rake")
  gem.add_development_dependency("rdoc")
  gem.add_development_dependency("minitest", ">= 5.3.3")
end
