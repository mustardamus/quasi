require 'coffee-script'

args   = process.argv.splice 2
config = require './config'
quasi  = "#{config.root}/lib/quasi"

if args.length then require("#{quasi}/tasks").execute args
else
  global.quasi = quasi
  require "#{quasi}/init"