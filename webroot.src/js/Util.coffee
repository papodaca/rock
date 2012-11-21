define [], ->
  contains: (s, subS) ->
    if s.indexOf(subS) isnt -1
      true
    else
      false
