$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'rspec'
require 'pathname'
require 'extensions/pathname'
require 'fileutils'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}