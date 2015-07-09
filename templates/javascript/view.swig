define({% if amd %}'views/{{ pathfile }}', {% endif %}[{% if app %}
	'{{ app }}',{% endif %}
	'underscore',
	'backbone'{% if mix %},
	'mixins'{% endif %}
],

function ({% if app %}{{ app }}, {% endif %}_, Backbone{% if mix %}, Mixins{% endif %}) {

	var {{ classname }}View = Backbone.View.extend({% if mix %}_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// view properties{% else %}{{'{'}}{% endif %}
		events: {
		},

		initialize: function (options) {
			// this.listenTo(this.model, 'destroy', this.remove);
			// this.listenTo(this.model, 'change', this.render);
		},

		render: function () {
			return this;
		}
	}{% if mix %}){% endif %});

	return {{ classname }}View;
});
