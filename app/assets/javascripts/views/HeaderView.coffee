define ["backbone", "jquery", "notifier", "json2", "views/RegisterModal", "Util", "hbs!template/HeaderView"], (Backbone, $, Notifier, JSON, RegisterModal, Util, Template) ->
  Backbone.View.extend
    template: Template
    className: "navbar navbar-fixed-top"
    events:
        "click #registerButton": "showRegisterModal"
        "click #loginButton": "doLogin"
        "click a.link": "showScreen"

    initialize: ->
      @render()

    render: ->
      @$el.append @template()

    showRegisterModal: ->
      modal = new RegisterModal()
      Util.presentModal(modal)

    doLogin: ->
      $.ajax
        url: "api/sessions"
        contentType: "application/json"
        data: JSON.stringify
          email: @$("#loginEmailTextBox").val()
          password: @$("#loginPasswordTextBox").val()
        type: "POST"
        success: (msg) ->
          Util.setSession msg.session_key
        error: (msg) ->
          Notifier.error("Authentication failed.")


    showScreen: (event) ->
      window.Router.nav $(event.target).data("target")
