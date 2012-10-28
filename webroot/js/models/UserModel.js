define(['backbone'], function(Backbone) {
    return Backbone.Model.extend({
        url: 'users.json',
        defaults: {
            id: null,
            email: null,
            name: null,
            password: null
        },
        validate: function(attr) {
            var valid = true;
            var result = "";
            
            if(attr.name === null || attr.name.length === 0) {
                valid = false;
                result += " nameNull "
            }
            if(attr.email === null || attr.email.length === 0) {
                valid = false;
                result += " emailNull "
            } else if(!this.validateEmail(attr.email)) {
                valid = false;
                result += " emailInvalid "
            }
            if(attr.password !== attr.password2) {
                valid = false;
                result += " passwordMismatch "
            }
            else if(attr.password === null || attr.password.length === 0) {
                valid = false;
                result += " passwordNull "
            }

            if(!valid) {
                return result;
            }
        },
        validateEmail: function(email) { 
            var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(email);
        } 
    });
});