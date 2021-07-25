#!/usr/bin/env ruby 

APP_ROOT = File.expand_path(File.dirname(__FILE__))

require_relative "lib/controller"

controller = ListMaker::Controller.new
controller.launch!
