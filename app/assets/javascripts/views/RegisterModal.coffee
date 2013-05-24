define ["backbone", "underscore", "notifier", "hbs!template/RegisterModal", "models/UserModel", "Util", "jquery", "jquery.bootstrap"], (Backbone, _, Notifier, Template, UserModel, Util, $, BS) ->
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
      @user.on "error", @onError, this

    onError: (model, error) ->
      if Util.contains(error, "passwordMismatch")
        @$(".password .label").html("Password mismatch").removeClass "hidden"
        @$(".password").addClass "error"
        @$(".password2").addClass "error"
      else if Util.contains(error, "passwordNull")
        @$(".password .label").html("Password required").removeClass "hidden"
        @$(".password").addClass "error"
        @$(".password2").addClass "error"
      if Util.contains(error, "nameNull")
        @$(".name .label").html("Name required").removeClass "hidden"
        @$(".name").addClass "error"
      if Util.contains(error, "emailNull")
        @$(".email .label").html("Email required").removeClass "hidden"
        @$(".email").addClass "error"
      else if Util.contains(error, "emailInvalid")
        @$(".email .label").html("Email invalid").removeClass "hidden"
        @$(".email").addClass "error"
      @$(".modal-footer button").removeClass "disabled"

    saveSuccess: (model, msg) ->
      @hide()
      Notifier.success "Registration successful."

    saveError: (model, msg) ->
      if msg.status is 400 and Util.contains("Email in use.")
        @$(".email .label").html("Email in use.").toggleClass "hidden"
        @$("modal-footer .button").removeClass "disabled"

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
      @resetError()

    register: ->
      unless @$(".modal-footer button").hasClass("disabled")
        @resetError()
        @$("button").addClass "disabled"
        data =
          name: @$(".name input").val()
          email: @$(".email input").val()
          password: @$(".password input").val()
          password2: @$(".password2 input").val()

        @user.set data
        if @user.isValid()
          @user.save {},
            success: _.bind(@saveSuccess, this)
            error: _.bind(@saveError, this)
