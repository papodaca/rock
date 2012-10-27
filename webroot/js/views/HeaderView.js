define(['backbone', 'handlebars', 'jquery', 'views/RegisterModal', 'text!views/templates/HeaderView.template'], 
	function(Backbone, Handlebars, $, RegisterModal, Template) {
	
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