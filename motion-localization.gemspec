# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'motion/localization/version'

Gem::Specification.new do |spec|
  spec.name          = "motion-localization"
  spec.version       = Motion::Localization::VERSION
  spec.authors       = ["akahigeg"]
  spec.email         = ["akahigeg@gmail.com"]
  spec.description   = %q{Localization rake task for RubyMotion}
  spec.summary       = %q{Localization rake task for RubyMotion}
  spec.homepage      = "https://github.com/akahigeg/motion-localization"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.3"
  spec.add_dependency "rake"
  spec.add_development_dependency "rspec"
end
