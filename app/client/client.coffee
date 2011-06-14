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
    
  trigger 'hello', { str: 'there' }
  trigger 'dunno'
  
  bind 'bye', (data) ->
    console.log 'bye bye', data.str