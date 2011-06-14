quasi = require global.quasi

quasi.bind 'hello', (data) ->
  #data.str
  quasi.client.trigger 'bye', data

quasi.bind 'dunno', ->
  console.log 'the dunno bind'