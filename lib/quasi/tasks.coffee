fs = require 'fs'

exports.execute = (args) ->
  [module, task] = [args[0], args[1]]
  path = "#{__dirname}/../../tasks"
  file = "#{path}/#{module}.coffee"
  args = args.splice 2
  
  try
    fs.realpathSync file
    
    req = require file

    if req[task] then req[task].call this, args
    else
      if req['index'] then req.index.call this, args
      else console.log "Unknown task in module '#{module}' - #{task}"
  catch error
    console.log "Unknown module '#{module}' - ./tasks/#{module}.coffee missing"