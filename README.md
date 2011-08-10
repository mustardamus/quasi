## Files

    app/
      client/
        *.coffee
      server/
        *.coffee
      style/
        *.styl
      public/
        index.html
        js/
        css/
        images/

All files in server/ will be included on runtime. Files in client/ will be merged and delivered as jsMerge (config).
Same with style/ and cssMerge.

  - http://jashkenas.github.com/coffee-script/
  - http://learnboost.github.com/stylus/

Make sure jsMerge and cssMerge are requested in index.html


## Start app
    coffee quasi.coffee


## Methods
    quasi.ready -> # execute the callback if socket and DOM is ready

## Tasks

    coffee quasi.coffee [module] [task]
    -> ./tasks/[module].coffee (exports.[task] = ...)

[task] will default to 'index' (exports.index = -> ...)

    coffee quasi.coffee tasks # for the task list

## Todo
  - baked in tests (minitest.js for backend, qunit for frontend) [init and pass in quasi object to test]