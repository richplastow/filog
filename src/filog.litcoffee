
Define the `Filog` class
-----------------------

    class Filog
      toString: -> '[object Filog]'

      $el: null


### `new Filog()`
Xx.

      constructor: (opt={}) ->
        switch type opt
          when 'string'
            @selector = opt
          when 'object'
            @selector = opt.selector
          else
            throw new Error "'opt' is type '#{type opt}', not 'string|object'"


### `log()`
Xx.

      log: =>
        console.log.apply console, arguments
        @$el ?= document.querySelector @selector #@todo test ?=
        if @$el
          @$el.innerHTML += ( (pretty arg for arg in [].slice.call arguments).join ' ' ) + '\n'
          @$el.scrollTop = @$el.scrollHeight


### `pretty()`
Xx.

      pretty = (value) ->
        if null == value then return '<em class="filog-null">[null]</em>'
        type = ({}).toString.call(value).match(/\s([a-z|A-Z]+)/)[1].toLowerCase() # http://tinyurl.com/croll-totype
        switch type
          when 'string'
            value.replace /</g, '&lt;'
          when 'undefined'
            '<em class="filog-undefined">[undefined]</em>'
          when 'error'
            "<em class=\"filog-location\">#{location value}</em> 
             <em class=\"filog-error\">#{value.message}</em>"
          when 'array'
            "<em class=\"filog-array\">[..#{value.length}..]</em>"
          else
            "<em class=\"filog-#{type}\">#{value}</em>"


### `location()`
Get a summary of the location of an error.

      location = (error) ->
        stack = error.stack.split '\n'
        if 'Error: ' + error.message == stack[0] then stack.shift() # Chrome
        stack[0].match(/\/([^.\/]+\.(js|html?):\d+(:\d+)?)/)?[1]


### `type()`
To detect the difference between 'null', 'array', 'regexp' and 'object' types, 
we use [Angus Croll’s one-liner](http://tinyurl.com/croll-totype) instead of 
JavaScript’s familiar `typeof` operator.

      type = (x) ->
        ({}).toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()




Export `Filog`
--------------

Allow Filog to be accessed from anywhere, eg using `log = new Filog().log;`.  
@todo export for RequireJS etc


    window.Filog = Filog
