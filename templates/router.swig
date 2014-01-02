define({% if options.setAMDName %}'routers/{{ name }}',{% endif %}[
	'{{ options.appname }}',
	'underscore',
	'backbone'
],

function({{ options.appname }}, _, Backbone){

	var {{ name|upperCamel }}Router = Backbone.Router.extend({
		routes: {
			"" :  "index"
		},
		initialize : function() {},
		index: function() {}
	});

	return {{ name|upperCamel }}Router;
});