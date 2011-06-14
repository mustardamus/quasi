http   = require 'http'
fs     = require 'fs'
config = require "#{__dirname}/../../config"
server = require "#{config.root}/lib/quasi/server"

global.httpServer = server.listen config.port
serverPath        = "#{config.root}/app/server/"

require serverPath + file for file in fs.readdirSync(serverPath)