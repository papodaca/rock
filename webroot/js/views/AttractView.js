define(['backbone', 'handlebars', 'jquery', 'router', 'text!views/templates/AttractView.hbs'], 
    function(Backbone, Handlebars, $, Router, Template) {
    
    return Backbone.View.extend({
        template: Handlebars.compile(Template),
        className: "container-fluid",
        events: {
            "click button": "buttonClick"
        },
        initialize: function() {
            this.render();
        },
        render: function() {
            this.$el.append(this.template({}));
        },
        buttonClick: function() {
            Router.navigate("test", {trigger: true});
        }
    });
});