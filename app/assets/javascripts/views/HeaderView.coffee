define [
  "backbone",
  "jquery",
  "notifier",
  "json2",
  "views/RegisterModal",
  "Util",
  "hbs!template/HeaderView"
], (
  Backbone,
  $,
  Notifier,
  JSON,
  RegisterModal,
  Util,
  Template
) ->
  Backbone.View.extend
    template: Template
    className: "navbar navbar-fixed-top"
    basePath: Util.basePath
    events:
        "click #registerButton": "showRegisterModal"
        "click #loginButton": "doLogin"
        "click a.link": "showScreen"

    initialize: ->
      @render()

    render: ->
      @$el.append @template
        basePath: @basePath

    showRegisterModal: ->
      modal = new RegisterModal()
      Util.presentModal(modal)

    doLogin: ->
      $.ajax
        url: "#{@basePath}api/sessions"
        contentType: "application/json"
        data: JSON.stringify
          email: @$("#loginEmailTextBox").val()
          password: @$("#loginPasswordTextBox").val()
        type: "POST"
        success: (msg) =>
          window.Router.loginState()
          Util.setSession msg.session_key
          Notifier.success "Login Successful."
        error: (msg) ->
          Notifier.error "Authentication failed."

    showScreen: (event) ->
      unless $(event.target).hasClass "active"
        event.preventDefault()
        window.Router.nav $(event.target).data "target"

    navigate: (name) ->
      @$("#nav-list .active").removeClass "active"
      @$("#nav-list [data-target=#{name}]").parent().addClass "active"

    loginState: ->
      @$("#navBarLeft").removeClass "hidden"
      @$("#navBarLogin").addClass "hidden"
      @$("#navBarSearch").removeClass "hidden"
