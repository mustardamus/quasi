quasi.ready ->
  console.log 'i am ready', @sessionId
  
  @trigger 'new_client' #tell the server i am here
  
  @bind 'new_client_count', (clientCount) ->
    console.log 'received new client count', clientCount
    
  ###
  @bind 'new_client', (data) ->
    messages.append "<li><span>#{data.username}:</span> #{data.message}</li>"
  ###