define ["backbone", "jquery", "views/RegisterModal", "hbs!template/HeaderView"], (Backbone, $, RegisterModal, Template) ->
  Backbone.View.extend
    template: Template
    registerModal: new RegisterModal()
    events:
      "click #registerButton": "showRegisterModal"
      "click #brandLink": "showHero"
      "click #configureHeaderLink": "showSettings"

    initialize: ->
      @render()

    render: ->
      @$el.append @template()
      @$el.append @registerModal.el

    showRegisterModal: ->
      @registerModal.$el.modal "show"

    showSettings: ->
      window.Router.nav "settings"

    showHero: ->
      window.Router.nav "/"