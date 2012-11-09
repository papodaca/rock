define([
    'backbone',
    'underscore',
    'notifier',
    'text!views/templates/RegisterModal.hbs',
    'models/UserModel',
    'Util',
    'jquery',
    'jquery.bootstrap'],
    function(Backbone, _, Notifier, Template, UserModel, Util, $, BS) {

    return Backbone.View.extend({
        template: Template,
        className: "modal hide fade",
        id: "registerModal",
        user: new UserModel(),
        attributes: {
            'data-backdrop': "static",
            'tabindex': "-1",
            'role': "dialog"
        },
        events: {
            'click .modal-footer button': 'register',
            'click .modal-header button': 'hide'
        },
        initialize: function() {
            this.render();

            this.user.on('error', this.onError, this);
        },
        onError: function(model, error) {
            if(Util.contains(error, "passwordMismatch")) {
                this.$(".password .label").html("Password mismatch").removeClass("hidden");
                this.$(".password").addClass("error");
                this.$(".password2").addClass("error");
            }
            else if(Util.contains(error, "passwordNull")) {
                this.$(".password .label").html("Password required").removeClass("hidden");
                this.$(".password").addClass("error");
                this.$(".password2").addClass("error");
            }
            if(Util.contains(error, "nameNull")) {
                this.$(".name .label").html("Name required").removeClass("hidden");
                this.$(".name").addClass("error");
            }
            if(Util.contains(error, "emailNull")) {
                this.$(".email .label").html("Email required").removeClass("hidden");
                this.$(".email").addClass("error");
            }
            else if(Util.contains(error, "emailInvalid")) {
                this.$(".email .label").html("Email invalid").removeClass("hidden");
                this.$(".email").addClass("error");
            }

            this.$(".modal-footer button").removeClass("disabled loading");
        },
        saveSuccess: function(model, msg) {
            this.hide();
            Notifier.success("Registration successful.");
        },
        saveError: function(model, msg) {
            if (msg.status === 400 && msg.responseText.indexOf("Email in use.") != -1) {
                this.$(".email .label").html("Email in use.").toggleClass("hidden");
                this.$("modal-footer .button").removeClass("disabled loading");
            }
        },
        hide: function() {
            this.reset();
            this.$el.modal("hide");
        },
        resetError: function() {
            this.$(".label").addClass("hidden");
            this.$(".control-group").removeClass("error");
        },
        render: function() {
            this.$el.append(this.template);
        },
        reset: function() {
            this.$("input").val("");
            this.$(".modal-footer button").removeClass("disabled loading");
            this.resetError();
        },
        register: function() {
            if(!this.$(".modal-footer button").hasClass("disabled")) {
                this.resetError();

                this.$("button").addClass("disabled loading");
                var data = {
                    "name": this.$(".name input").val(),
                    "email": this.$(".email input").val(),
                    "password": this.$(".password input").val(),
                    "password2": this.$(".password2 input").val()
                };

                this.user.set(data);

                if(this.user.isValid()) {
                    this.user.save({}, {
                        success: _.bind(this.saveSuccess, this),
                        error: _.bind(this.saveError, this)
                    });
                }
            }
        }
    });
});