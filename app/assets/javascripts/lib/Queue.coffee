define ->
  class Queue
    constructor: ->
      @array = new Array()
      @ptr = 0
      @length = 0

    enqueue: (value) ->
      @array.push value
      @length = @array.length
      null

    next: ->
      if @array.length > @ptr+1
        @ptr += 1
      @array[@ptr]

    previous: ->
      if @ptr > 0
        @ptr -= 1
      @array[@ptr]

    peek: ->
      if @array.length > @ptr+1
        @array[@ptr+1]
      else
        @current()

    peekBack: ->
      if @ptr > 0
        @array[@ptr-1]
      else
        @current()

    current: ->
      @array[@ptr]

    middle: ->
      @ptr > 0

    empty: ->
      @length = 0
      @array = new Array()
      @ptr = 0

    toArray: ->
      @array
