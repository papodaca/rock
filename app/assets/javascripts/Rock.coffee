require [
  'Router',
  'backbone'
], (
  Router,
  Backbone
) ->
  window.Router = new Router()
  Backbone.history.start
    pushState: true
