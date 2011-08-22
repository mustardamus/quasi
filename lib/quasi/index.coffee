config     = require "#{__dirname}/../../config"
socket     = require 'socket.io'
io         = socket.listen global.httpServer
funcs      = []
clients    = []
retClients = -> clients

executeFunc = (name, data) =>
  for func in funcs
    if func.name is name
      func.func.call @, data
      break

io.sockets.on 'connection', (client) ->
  clients.push client
  
  client.emit 'message'
    name: 'quasi.hello'
    data: { sessionId: client.id }

  client.on 'message', (message) ->
    executeFunc message.name, message.data if message.name


exports.clients = retClients()

exports.bind = (name, func) ->
  funcs.push { name: name, func: func }

exports.trigger = (name, data, sessionId) ->
  io.sockets.emit 'message'
    name: name
    data: data