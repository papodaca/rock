define(function(require) {
	var Backbone = require('backbone'),
		Handlebars = require('handlebars'),
		$ = require('jquery'),
		RegisterModal = require('views/RegisterModal'),
		Template = require('text!views/templates/HeaderView.template');
	
	return Backbone.View.extend({
		template: Handlebars.compile(Template),
		registerModal: new RegisterModal(),
		initialize: function() {
			this.render();
		},
		render: function() {
			this.$el.append(this.template({}));
			this.$el.append(this.registerModal.el);
		}
	});
});