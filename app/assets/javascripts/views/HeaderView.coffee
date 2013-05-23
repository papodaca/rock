define ["backbone", "jquery", "views/RegisterModal", "hbs!template/HeaderView"], (Backbone, $, RegisterModal, Template) ->
  Backbone.View.extend
    template: Template
    registerModal: null
    events:
        "click #registerButton": "showRegisterModal"
        "click a.link": "showScreen"

    initialize: ->
      @registerModal =  new RegisterModal()
      @render()

    render: ->
      @$el.append @template()
      @$el.append @registerModal.el

    showRegisterModal: ->
      @registerModal.$el.modal "show"

    showScreen: (event) ->
      window.Router.nav $(event.target).data("target")
