class Quasi
  constructor: ->
    @sessionId = null
    @binds     = []
    @socket    = new io.Socket 'localhost'
    
    @socket.connect()
    @handleSocketMessages()
  
  handleSocketMessages: ->
    @socket.on 'message', (message) =>
      if message.name is 'quasi.hello'
        @sessionId = message.data.sessionId
      else
        for bind in @binds
          if bind.name is message.name
            bind.func.call @, message.data
            break
  
  trigger: (name, data, private = false) ->
    #session id erst fertig wenn server sie sendet
    #callback -> on message quasi.hello have a init callback (class extends)
    @socket.send
      name: name
      data: data
      sessionId: if private then @sessionId else false
  
  bind: (name, func) ->
    @binds.push { name: name, func: func }
    

quasi = new Quasi