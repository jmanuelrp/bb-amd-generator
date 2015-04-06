define({% if amd %}'models/{{ name }}', {% endif %}[{% if app %}
	'{{ app }}',{% endif %}
	'underscore',
	'backbone'{% if mix %},
	'mixins'{% endif %}
],

function ({% if app %}{{ app }}, {% endif %}_, Backbone{% if mix %}, Mixins{% endif %}) {

	var {{ classname }}Model = Backbone.Model.extend({% if mix %}_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// model properties{% else %}{{'{'}}{% endif %}
		urlRoot: '',

		defaults: {}
	}{% if mix %}){% endif %});

	return {{ classname }}Model;
});
