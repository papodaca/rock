define([
    'backbone',
    'handlebars',
    'jquery',
    'views/RegisterModal',
    'text!views/templates/HeaderView.hbs'],
    function(Backbone, Handlebars, $, RegisterModal, Template) {
    
    return Backbone.View.extend({
        template: Handlebars.compile(Template),
        registerModal: new RegisterModal(),
        events: {
            "click #registerButton": "showRegisterModal"
        },
        initialize: function() {
            this.render();
        },
        render: function() {
            this.$el.append(this.template({}));
            this.$el.append(this.registerModal.el);
        },
        showRegisterModal: function() {
            this.registerModal.$el.modal('show');
        }
    });
});