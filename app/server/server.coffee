quasi = require global.quasi

clientCount = 0

quasi.bind 'new_client', ->
  clientCount++
  console.log '###################### new client count', clientCount
  @trigger 'new_client_count', clientCount

###
quasi.bind 'new_message', (data) ->
  @trigger 'update_chat', { username: data.username, message: data.message }
###