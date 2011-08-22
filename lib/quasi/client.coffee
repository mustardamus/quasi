class Quasi
  constructor: ->
    @sessionId     = null
    @binds         = []
    @readyCallback = ->
    @quasiSock     = io.connect 'http://localhost/quasi'
    @messagesSock  = io.connect 'http://localhost/messages'

    @handleQuasiSock()
    @handleMessagesSock()
  
  handleQuasiSock: ->
    @quasiSock.on 'hello', (sessionId) =>
      @sessionId = sessionId
      jQuery => @readyCallback()

  handleMessagesSock: ->
    @messagesSock.on 'message', (message) =>
      console.log 'message', message
      for bind in @binds
        if bind.name is message.name
          bind.func.call @, message.data
          break
  
  ready: (func) ->
    @readyCallback = func
  
  trigger: (name, data) ->
    @messagesSock.emit 'message'
      name     : name
      data     : data
      sessionId: @sessionId
  
  bind: (name, func) ->
    @binds.push
      name: name
      func: func
    
    
quasi = new Quasi