define [
], (
) ->
  class Queue
    head: null
    tail: null
    current: null
    length: 0
    class Node
      value: null
      next: null
      previous: null
      constructor: (@value, @next, @previous) ->

    enqueue: (value) ->
      unless @head?
        @head = new Node value, null, null
        @tail = @head
        @current = @head
      else
        oldTail = @tail
        @tail = new Node value, null, oldTail
        oldTail.next = @tail
      @length += 1
      null

    next: () ->
      if @current.next?
        @current = @current.next
        @current.value

    previous: () ->
      if @current.previous?
        @current = @current.previous
        @current.value

    middle: () ->
      @current isnt @head

    empty: () ->
      @length = 0
      @head = null
      @tail = null
      @current = null

    toArray: () ->
      if @head?
        result = new Array()
        ptr = @head
        while ptr?
          result.push ptr.value
          ptr = ptr.next
        result
      else
        null
