fs   = require 'fs'

exports.index = ->
  for file in fs.readdirSync(__dirname)
    fpath = "#{__dirname}/#{file}"
    req   = require fpath
    
    console.log '-', file.split('.')[0], "(#{fpath})"
    console.log '  -', name for name, func of req