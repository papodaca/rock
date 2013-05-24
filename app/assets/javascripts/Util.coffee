define ["jquery", "jquery.bootstrap"], ($, BS)->
  contains: (s, subS) ->
    s.indexOf(subS) isnt -1
  presentModal: (modal) ->
  	$("#modalSocket").empty().append modal.el
  	modal.$el.modal "show"
