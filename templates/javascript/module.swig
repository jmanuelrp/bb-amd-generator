define({% if amd %}'modules/{{ name }}', {% endif %}[{% if app %}
	'{{ app }}',{% endif %}
	'underscore',
	'backbone'{% if mix %},
	'mixins'{% endif %}
],

function ({% if app %}{{ app }}, {% endif %}_, Backbone{% if mix %}, Mixins{% endif %}) {

	var {{ classname }} = { Views: {} };

	{{ classname }}.Model = Backbone.Model.extend({% if mix %}_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// model properties{% else %}{{'{'}}{% endif %}
		defaults: {}
	}{% if mix %}){% endif %});

	{{ classname }}.Collection = Backbone.Collection.extend({% if mix %}_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// collection properties{% else %}{{'{'}}{% endif %}
		url: '',

		model: {{ classname }}.Model
	}{% if mix %}){% endif %}));

	{{ classname }}.Views.ModelView = Backbone.View.extend({% if mix %}_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// view properties{% else %}{{'{'}}{% endif %}
		events: {
		},

		initialize: function(options) {
			this.listenTo(this.model, 'destroy', this.remove);
			this.listenTo(this.model, 'change', this.render);
		},

		render: function() {
			return this;
		}
	}{% if mix %}){% endif %});

	{{ classname }}.Views.CollectionView = Backbone.View.extend({% if mix %}_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// view properties{% else %}{{'{'}}{% endif %}
		events: {
		},

		initialize: function(options) {
			this.listenTo(this.collection, 'add', this.add);
			this.listenTo(this.collection, 'reset', this.render);
		},

		render: function() {
			this.$el.empty();

			this.collection.each(this.add, this);

			return this;
		},

		add: function(model) {
			var child = new {{ classname }}.Views.ModelView({
				model: model
			});

			child.render().$el.appendTo(this.$el);
		}
	}{% if mix %}){% endif %});

	return {{ classname }};
});