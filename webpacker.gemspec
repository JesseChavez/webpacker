$:.push File.expand_path("../lib", __FILE__)
require "webpacker/version"

Gem::Specification.new do |s|
  s.name     = "webpacker-legacy"
  s.version  = Webpacker::VERSION
  s.authors  = [ "David Heinemeier Hansson", "Gaurav Tiwari", "Jesse Chavez" ]
  s.email    = [ "david@basecamp.com", "gaurav@gauravtiwari.co.uk", "jesse.chavez.r@gmail.com" ]
  s.summary  = "Use Webpack to manage app-like JavaScript modules in Rails"
  s.homepage = "https://github.com/JesseChavez/webpacker-legacy"
  s.license  = "MIT"

  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency "activesupport", "< 4.2", ">= 3.2"
  s.add_dependency "multi_json",    "~> 1.2"
  s.add_dependency "railties",      "< 4.2", ">= 3.2"

  s.add_development_dependency "bundler", "~> 1.12"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
end
