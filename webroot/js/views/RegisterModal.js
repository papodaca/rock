define(['backbone', 'underscore', 'handlebars', 'notifier', 'text!views/templates/RegisterModal.template', 'models/UserModel', 'jquery', 'jquery.bootstrap'], 
    function(Backbone, _, HandleBars, Notifier, Template, UserModel, $, BS) {

    return Backbone.View.extend({
        template: Handlebars.compile(Template),
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

            this.user.on('error', this.onError, this)
        },
        onError: function(model, error) {
            if(error.indexOf("passwordMismatch") !== -1) {
                this.$(".password .label").html("Password mismatch").removeClass("hidden");
                this.$(".password").addClass("error");
                this.$(".password2").addClass("error");
            }
            else if(error.indexOf("passwordNull") !== -1) {
                this.$(".password .label").html("Password required").removeClass("hidden");
                this.$(".password").addClass("error");
                this.$(".password2").addClass("error");
            }
            if(error.indexOf("nameNull") !== -1) {
                this.$(".name .label").html("Name required").removeClass("hidden");
                this.$(".name").addClass("error");
            }
            if(error.indexOf("emailNull") !== -1) {
                this.$(".email .label").html("Email required").removeClass("hidden");
                this.$(".email").addClass("error");
            }
            else if(error.indexOf("emailInvalid") !== -1) {
                this.$(".email .label").html("Email invalid").removeClass("hidden");
                this.$(".email").addClass("error");
            }

            this.$(".modal-footer button").removeClass("disabled loading");
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
            this.$el.append(this.template({}));
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
                data = {
                    "name": this.$(".name input").val(),
                    "email": this.$(".email input").val(),
                    "password": this.$(".password input").val(),
                    "password2": this.$(".password2 input").val()
                };

                this.user.set(data);

                if(this.user.isValid()) {
                    this.user.save({}, {
                        success: _.bind(function (model, msg) {
                            this.hide();
                            Notifier.success("Registration successful.");
                        }, this),
                        error: _.bind(function (model, msg) {
                            if (msg.status === 400 && msg.responseText.indexOf("Email in use.") != -1) {
                                this.$(".email .label").html("Email in use.").toggleClass("hidden");
                                this.$("modal-footer .button").removeClass("disabled loading");
                            }
                        }, this)
                    });
                }
            }
        }
    });
});