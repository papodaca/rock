define([
    'backbone',
    'jquery',
    'text!views/templates/AttractView.hbs'],
    function(Backbone, $, Template) {
    
    return Backbone.View.extend({
        template:Template,
        className: "container-fluid",
        initialize: function() {
            this.render();
        },
        render: function() {
            this.$el.append(this.template);
        }
    });
});