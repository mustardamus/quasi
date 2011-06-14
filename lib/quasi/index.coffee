config = require "#{__dirname}/../../config"
io     = require "#{config.root}/lib/socket.io"

funcs  = []
socket = io.listen global.httpServer

socket.on 'connection', (client) ->
  client.on 'message', (message) ->
    if message.name
      for func in funcs
        if func.name is message.name
          func.func.call this, message.data
          break

exports.bind = (name, func) ->
  funcs.push { name: name, func: func }

exports.client =
  trigger: (name, data) ->
    socket.broadcast { name: name, data: data }