define({% if options.setAMDName %}'routers/{{ name }}',{% endif %}[
	'{{ options.appname }}',
	'backbone'
],

function({{ options.appname }}, Backbone){

	var {{ name|capitalize }} = Backbone.Router.extend({
		routes: {
			"" :  "index"
		},
		initialize : function() {},
		index: function() {}
	});

	return {{ name|capitalize }};
});