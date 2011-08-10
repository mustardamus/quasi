quasi = require global.quasi

quasi.bind 'new_message', (data) ->
  quasi.trigger 'update_chat', { username: data.username, message: data.message }