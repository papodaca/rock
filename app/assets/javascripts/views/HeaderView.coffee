define ["backbone", "jquery", "views/RegisterModal", "Util", "hbs!template/HeaderView"], (Backbone, $, RegisterModal, Util, Template) ->
  Backbone.View.extend
    template: Template
    className: "navbar navbar-fixed-top"
    events:
        "click #registerButton": "showRegisterModal"
        "click a.link": "showScreen"

    initialize: ->
      @render()

    render: ->
      @$el.append @template()

    showRegisterModal: ->
      modal = new RegisterModal()
      Util.presentModal(modal)

    showScreen: (event) ->
      window.Router.nav $(event.target).data("target")
