define(['backbone', 'handlebars', 'notifier', 'text!views/templates/RegisterModal.template', 'jquery', 'jquery.bootstrap'], 
    function(Backbone, HandleBars, Notifier, Template, $, BS) {
    return Backbone.View.extend({
        template: Handlebars.compile(Template),
        className: "modal hide fade",
        id: "registerModal",
        attributes: {
            'data-backdrop': "static",
            'tabindex': "-1",
            'role': "dialog"
        },
        events: {
            'click #registerSubmitButton': 'register'
        },
        reset: function() {
            $("#registerName").val("");
            $("#registerEmail").val("");
            $("#registerPassword").val("");
            $("#registerPassword2").val("");
            $("#registerSubmitButton").removeClass("disabled loading");
            $("#registerPassword").parent().parent().removeClass("error");
            $("#registerPassword2").parent().parent().removeClass("error");
            $("#registerPasswordLabel").addClass("hidden");
            $("#registerEmailLabel").addClass("hidden");
        },
        register: function() {
            $("#registerPassword").parent().parent().removeClass("error");
            $("#registerPassword2").parent().parent().removeClass("error");
            $("#registerPasswordLabel").addClass("hidden");
            $("#registerEmailLabel").addClass("hidden");
            if ($("#registerPassword").val() === $("#registerPassword2").val()) {
                $(this).addClass("disabled loading");
                data = {
                    "name": $("#registerName").val(),
                    "email": $("#registerEmail").val(),
                    "password": $("#registerPassword").val()
                };

                $.ajax({
                    type: "POST",
                    url: "users.json",
                    data: data,
                    success: function (msg) {
                        $("#registerModal").modal("hide");
                        Notifier.success("Registration successful.");
                    },
                    error: function (msg) {
                        if (msg.status === 400) {
                            if (msg.responseText.indexOf("Email in use.") != -1) {
                                $("#registerEmailLabel").html("Email in use.").toggleClass("hidden");
                                $("#registerSubmitButton").removeClass("disabled loading");
                            }
                        } else {
                            console.log(msg);
                            document.write(msg.responseText);
                        }
                    }
                });
            } else {
                $("#registerPasswordLabel").html("Passwords do not match").toggleClass("hidden");
                $("#registerPassword").parent().parent().addClass("error");
                $("#registerPassword2").parent().parent().addClass("error");
            }
        },
        initialize: function() {
            this.render();
            this.$el.on("hidden", this.reset);
        },
        render: function() {
            this.$el.append(this.template({}));
        }
    });
});