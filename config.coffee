config =
  root     : __dirname
  port     : 1337
  jsMerge  : '/js/client.js'
  cssMerge : '/css/style.css'
  fileTypes:
    html: 'text/html'
    css : 'text/css'
    js  : 'text/javascript'


exports[k] = config[k] for k, v of config # do not remove this line