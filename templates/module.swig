{% set _mix_ = options.mixins %}
define({% if options.setAMDName %}'modules/{{ name }}',{% endif %}[
	'{{ options.appname }}',{% if _mix_ %}
	'underscore',{% endif %}
	'backbone'{% if _mix_ %},
	'mixins'{% endif %}
],

function({{ options.appname }}{% if _mix_ %}, _{% endif %}, Backbone{% if _mix_ %}, Mixins{% endif %}){

	var {{ name|capitalize }} = {{ options.appname }}.module();

	{{ name|capitalize }}.Model = Backbone.Model.extend({% if _mix_ %}_.extend({},
		// mixins
		/* Mixins.Name, */ {

		// model properties {% else %}{{'{'}}{% endif %}
		urlRoot: '',
		defaults: {}
	}{% if _mix_ %}){% endif %});

	{{ name|capitalize }}.Collection = Backbone.Collection.extend({% if _mix_ %}_.extend({},
		// mixins
		/* Mixins.Name, */ {

		// collection properties {% else %}{{'{'}}{% endif %}
		url: '',
		model: {{ name|capitalize }}.Model
	}{% if _mix_ %}){% endif %});

	{{ name|capitalize }}.Views.ModelView = Backbone.View.extend({% if _mix_ %}_.extend({},
		// mixins
		/* Mixins.Name, */ {

		// view properties {% else %}{{'{'}}{% endif %}
		events: {},
		initialize: function() {},
		render: function() {
			return this;
		}
	}{% if _mix_ %}){% endif %});

	{{ name|capitalize }}.Views.CollectionView = Backbone.View.extend({% if _mix_ %}_.extend({},
		// mixins
		/* Mixins.Name, */ {

		// view properties {% else %}{{'{'}}{% endif %}
		initialize: function(options) {
			this. .on('reset',this.render,this);
			this.collection.on('add',this.add,this);
		},
		render: function() {
			return this;
		},
		add: function(model) {}
	}{% if _mix_ %}){% endif %});

	return {{ name|capitalize }};
});