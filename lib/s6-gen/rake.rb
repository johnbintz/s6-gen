require 'rubygems'
require 's6-gen/generator'

Dir[File.join(File.dirname(__FILE__), 'rake/*.rb')].each { |file| require file }
