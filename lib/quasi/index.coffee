config    = require "#{__dirname}/../../config"
io        = require "#{config.root}/lib/socket.io"
socket    = io.listen global.httpServer
funcs     = []
clients   = []

executeFunc = (name, data) =>
  for func in funcs
    if func.name is name
      func.func.call @, data
      break

socket.on 'connection', (client) ->
  clients.push client
  
  client.send 
    name: 'quasi.hello'
    data: { sessionId: client.sessionId }

  client.on 'message', (message) ->
    executeFunc message.name, message.data if message.name

retClients      = -> clients
exports.clients = retClients()

exports.bind = (name, func) ->
  funcs.push { name: name, func: func }

exports.trigger = (name, data) ->
  socket.broadcast { name: name, data: data }