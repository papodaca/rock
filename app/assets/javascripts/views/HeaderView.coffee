define [
  "backbone",
  "jquery",
  "notifier",
  "views/RegisterModal",
  "lib/Util",
  "hbs!template/HeaderView"
], (
  Backbone,
  $,
  Notifier,
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
        "click #navBarSearch a": "doLogout"
        "keypress input#loginPasswordTextBox": "dologinKey"

    initialize: ->
      @render()

    render: ->
      @$el.append @template
        basePath: @basePath

    showRegisterModal: ->
      modal = new RegisterModal()
      Util.presentModal(modal)

    dologinKey: (event) ->
      if event.keyCode == 13
        @doLogin()
    doLogin: ->
      Util.login @$("#loginEmailTextBox").val(), @$("#loginPasswordTextBox").val(), (state) ->
        if state
          Notifier.success "Login Successful."
          @$("#loginEmailTextBox").val("")
          @$("#loginPasswordTextBox").val("")
        else
          Notifier.error "Authentication failed."
          @$("#loginPasswordTextBox").val("")
        window.Router.loginState state

    doLogout: (event) ->
      event.preventDefault()
      Util.destroySession()
      window.Router.loginState false
      window.Router.nav "/"

    showScreen: (event) ->
      unless $(event.target).hasClass "active"
        event.preventDefault()
        window.Router.nav $(event.target).data "target"

    navigate: (name) ->
      @$("#nav-list .active").removeClass "active"
      @$("#nav-list [data-target=#{name}]").parent().addClass "active"

    loginState: (state) ->
      if state
        @$("#navBarLeft").removeClass "hidden"
        @$("#navBarLogin").addClass "hidden"
        @$("#navBarSearch").removeClass "hidden"
      else
        @$("#navBarLeft").addClass "hidden"
        @$("#navBarLogin").removeClass "hidden"
        @$("#navBarSearch").addClass "hidden"
