config = require "#{__dirname}/../../config"
io     = require "#{config.root}/lib/socket.io"
socket = io.listen global.httpServer
funcs  = []

executeFunc = (name, data) ->
  for func in funcs
    if func.name is name
      func.func.call this, data
      break

socket.on 'connection', (client) ->
  client.on 'message', (message) ->
    executeFunc message.name, message.data if message.name

exports.bind = (name, func) ->
  funcs.push { name: name, func: func }

exports.trigger = (name, data) ->
  executeFunc name, data

exports.client =
  trigger: (name, data) ->
    socket.broadcast { name: name, data: data }