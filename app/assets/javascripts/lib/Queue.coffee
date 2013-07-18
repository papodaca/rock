define [
], (
) ->
  class Queue
    head: null
    tail: null
    length: 0
    class Node
      value: null
      next: null
      constructor: (@value, @next) ->

    enqueue: (value) ->
      unless @head?
        @head = new Node value, null
        @tail = @head
      else
        oldTail = @tail
        @tail = new Node value, null
        oldTail.next = @tail
      @length += 1
      null

    dequeue: () ->
      if @head?
        @length -= 1
        result = @head.value
        @head = @head.next
        result
      else
        null

    empty: () ->
      length = 0
      @head = null
      @tail = null

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
