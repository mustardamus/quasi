http   = require 'http'
url    = require 'url'
fs     = require 'fs'
config = require "#{__dirname}/../../config"
coffee = require "#{config.root}/lib/coffee-script/lib"
stylus = require "#{config.root}/lib/stylus"

exports.listen = (port) ->
  server = http.createServer (request, response) ->
    path    = url.parse(request.url).pathname
    file    = "#{config.root}/app/public#{path}"
    file    += 'index.html' if path is '/'
    ext     = file.split '.'
    ext     = ext[ext.length - 1]
    type    = config.fileTypes[ext] ? 'text/plain'
    content = ''
  
    try
      if path is config.jsMerge
        path = "#{config.root}/app/client/"
      
        for file in fs.readdirSync(path)
          content += coffee.compile fs.readFileSync(path+file, 'utf-8')
      else if path is config.cssMerge
        path = "#{config.root}/app/style/"
      
        for file in fs.readdirSync(path)
          stylus.render fs.readFileSync(path+file, 'utf-8'), { filename: file }, (err, css) ->
            content += css
      else
        fs.realpathSync file
        content = fs.readFileSync file

      response.writeHead 200, { 'Content-Type': type }
      response.end content
    catch error
      response.writeHead 404, { 'Content-Type': type }
      response.end 'Not Found'

  server.listen port
  console.log "Started Quasi on port #{port}..."
  server