define ["backbone", "views/MainView", "views/AttractView"], (Backbone, MainView, AttractView) ->
  getRouter = _.once(->
    new (Backbone.Router.extend(
      view: new MainView()
      routes:
        "": "base"
      initialize: ->
        $("body").append @view.el
        @base()
      base: ->
        @view.setSocket new AttractView()
    ))()
  )
  
  #this is supposed to be a singleton but it does not work.
  getRouter()
