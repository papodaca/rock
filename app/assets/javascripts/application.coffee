require ['Router', 'backbone'], (Router, Backbone) ->
  window.Router = Router
  Backbone.history.start({pushState: true})
