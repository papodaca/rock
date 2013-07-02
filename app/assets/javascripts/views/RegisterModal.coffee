define [
  "backbone",
  "underscore",
  "notifier",
  "hbs!template/RegisterModal",
  "models/UserModel",
  "Util",
  "jquery",
  "jquery.bootstrap"
], (
  Backbone,
  _,
  Notifier,
  Template,
  UserModel,
  Util,
  $,
  BS
) ->
  Backbone.View.extend
    template: Template
    className: "modal hide fade"
    id: "registerModal"
    user: new UserModel()
    attributes:
      "data-backdrop": "static"
      tabindex: "-1"
      role: "dialog"

    events:
      "click .modal-footer button": "register"
      "click .modal-header button": "hide"

    initialize: ->
      @render()
      @user.on "invalid", @onError, this

    onError: (model, error) ->
      if Util.contains(error, "passwordMismatch")
        @$(".password .label").html("Password mismatch").removeClass "hidden"
        @$(".password").addClass "error"
        @$(".password2").addClass "error"
      else if Util.contains(error, "passwordNull")
        @$(".password .label").html("Required").removeClass "hidden"
        @$(".password").addClass "error"
        @$(".password2").addClass "error"
      if Util.contains(error, "nameNull")
        @$(".name .label").html("Required").removeClass "hidden"
        @$(".name").addClass "error"
      if Util.contains(error, "emailNull")
        @$(".email .label").html("Required").removeClass "hidden"
        @$(".email").addClass "error"
      else if Util.contains(error, "emailInvalid")
        @$(".email .label").html("Email invalid").removeClass "hidden"
        @$(".email").addClass "error"
      @$(".modal-footer button").removeClass "disabled"

    saveSuccess: (model, msg) ->
      @hide()
      Notifier.success "Registration successful."

    saveError: (model, msg) ->
      if msg.status is 400 and Util.contains msg.responseText, "Email in use."
        @$(".email").addClass "error"
        @$(".email .label").html("Email in use").toggleClass "hidden"
      else if msg.status is 401 and Util.contains msg.responseText, "unauthorized"
        @$(".registrationPassword").addClass "error"
        @$(".registrationPassword .label").html("Invalid").toggleClass "hidden"
      @$(".modal-footer button").removeClass "disabled"

    hide: ->
      @reset()
      @$el.modal "hide"

    resetError: ->
      @$(".label").addClass "hidden"
      @$(".control-group").removeClass "error"

    render: ->
      @$el.append @template()

    reset: ->
      @$("input").val ""
      @$(".modal-footer button").removeClass "disabled"
      @user = new UserModel()
      @resetError()

    register: ->
      unless @$(".modal-footer button").hasClass("disabled")
        @resetError()
        @$("button").addClass "disabled"
        registrationPassword = @$(".registrationPassword input").val()
        data =
          name: @$(".name input").val()
          email: @$(".email input").val()
          password: @$(".password input").val()
          password2: @$(".password2 input").val()

        @user.set data,
          validate: true
        if @user.isValid()
          @user.save
            registration_password: registrationPassword
          ,
            success: _.bind(@saveSuccess, this)
            error: _.bind(@saveError, this)
