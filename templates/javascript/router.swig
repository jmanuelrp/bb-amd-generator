define({% if amd %}'routers/{{ pathfile }}', {% endif %}[{% if app %}
	'{{ app }}',{% endif %}
	'underscore',
	'backbone'
],

function ({% if app %}{{ app }}, {% endif %}_, Backbone) {

	var {{ classname }}Router = Backbone.Router.extend({

		routes: {
			"" :  "index"
		},

		initialize : function() {},

		index: function() {}
	});

	return {{ classname }}Router;
});
