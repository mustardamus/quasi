jQuery ->
  socket = new io.Socket 'localhost'
  funcs = []
  
  socket.connect()
  
  socket.on 'message', (message) ->
    for func in funcs
      if func.name == message.name
        func.func.call this, message.data
        break
  
  trigger = (name, data) ->
    socket.send { name: name, data: data }
  
  bind = (name, func) ->
    funcs.push { name: name, func: func }

  
  send = $ '#send'  
  username = $ '#username'
  messages = $ '#messages'
  
  bind 'update_chat', (data) ->
    messages.append "<li><span>#{data.username}:</span> #{data.message}</li>"
  
  send.keyup (event) ->
    if event.keyCode is 13
      trigger 'new_message', { username: username.val(), message: send.val() }
      send.val ''