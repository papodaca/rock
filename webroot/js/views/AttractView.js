define(['backbone', 'handlebars', 'jquery', 'text!views/templates/AttractView.hbs'], 
    function(Backbone, Handlebars, $, Template) {
    
    return Backbone.View.extend({
        template: Handlebars.compile(Template),
        className: "container-fluid",
        initialize: function() {
            this.render();
        },
        render: function() {
            this.$el.append(this.template({}));
        }
    });
});