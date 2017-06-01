module Webpacker
  extend self

  def bootstrap
    Webpacker::Env.load
    Webpacker::Configuration.load
    Webpacker::Manifest.load
  end

  def compile
    Webpacker::Compiler.compile
    Webpacker::Manifest.load
  end

  def env
    Webpacker::Env.current.inquiry
  end

  def self.rails32?
    Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR == 2
  end

  def self.rails40?
    Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR == 0
  end

  def self.rails41?
    Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR == 1
  end

  def self.rails_less_than_42?
    rails32? || rails40? || rails41?
  end
end

require "webpacker/env"
require "webpacker/configuration"
require "webpacker/manifest"
require "webpacker/compiler"
require "webpacker/railtie" if defined?(Rails)
