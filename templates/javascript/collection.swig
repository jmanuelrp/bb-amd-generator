define({% if amd %}'collections/{{ pathfile }}', {% endif %}[{% if app %}
	'{{ app }}',{% endif %}
	'underscore',
	'backbone',{% if mix %}
	'mixins',{% endif %}
	'models/{{ name|singularize }}'
],

function ({% if _app_ %}{{ _app_ }}, {% endif %}_, Backbone{% if mix %}, Mixins{% endif %}, {{ classname }}Model) {

	var {{ classname }}Collection = Backbone.Collection.extend({% if mix %}_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// collection properties{% else %}{{'{'}}{% endif %}
		url: '',

		model: {{ classname }}Model
	}{% if mix %}){% endif %});

	return {{ classname }}Collection;
});
