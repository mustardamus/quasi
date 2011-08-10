quasi.ready ->
  send = $ '#send'  
  username = $ '#username'
  messages = $ '#messages'
  
  @bind 'update_chat', (data) ->
    messages.append "<li><span>#{data.username}:</span> #{data.message}</li>"
  
  send.keyup (event) =>
    if event.keyCode is 13
      @trigger 'new_message', { username: username.val(), message: send.val() }
      send.val ''