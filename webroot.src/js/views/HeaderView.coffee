define ["backbone", "jquery", "views/RegisterModal", "hbs!template/HeaderView"], (Backbone, $, RegisterModal, Template) ->
  Backbone.View.extend
    template: Template
    registerModal: new RegisterModal()
    events:
      "click #registerButton": "showRegisterModal"

    initialize: ->
      @render()

    render: ->
      @$el.append @template()
      @$el.append @registerModal.el

    showRegisterModal: ->
      @registerModal.$el.modal "show"


