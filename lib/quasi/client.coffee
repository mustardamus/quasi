class Quasi
  constructor: ->
    @sessionId     = null
    @binds         = []
    @readyCallback = ->
    @socket        = new io.Socket 'localhost'
    
    @socket.connect()
    @handleSocketMessages()
  
  handleSocketMessages: ->
    @socket.on 'message', (message) =>
      if message.name is 'quasi.hello'
        @sessionId = message.data.sessionId
        jQuery => @readyCallback()
      else
        for bind in @binds
          if bind.name is message.name
            bind.func.call @, message.data
            break
  
  ready: (func) ->
    @readyCallback = func
  
  trigger: (name, data) ->
    @socket.send
      name     : name
      data     : data
      sessionId: @sessionId
  
  bind: (name, func) ->
    @binds.push
      name: name
      func: func
    
    
quasi = new Quasi