fs    = require 'fs'
quasi = "#{__dirname}/../lib/quasi"

exports.index = ->
  total = 0
  
  for file in fs.readdirSync(quasi)
    content = fs.readFileSync "#{quasi}/#{file}", 'utf-8'
    
    for line in content.split("\n")
      total += 1 if line.length isnt 0
  
  console.log "Total lines of code: #{total}"