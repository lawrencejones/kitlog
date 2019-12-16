# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "kitlog"
  spec.version       = "1.0.0"
  spec.summary       = "Logger for Ruby that imitates go-kit logger"
  spec.authors       = %w[me@lawrencejones.dev]
  spec.homepage      = "https://github.com/lawrencejones/kitlog"
  spec.email         = %w[me@lawrencejones.dev]
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.4"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency "values", "~> 1.8"

  spec.add_development_dependency "gc_ruboconfig", "= 2.8.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rspec", "~> 3.8"
end
