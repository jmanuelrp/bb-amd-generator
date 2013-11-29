{% set _mix_ = options.mixins %}
define({% if options.setAMDName %}'views/{{ name }}',{% endif %}[
	'{{ options.appname }}',{% if _mix_ %}
	'underscore',{% endif %}
	'backbone'{% if _mix_ %},
	'mixins'{% endif %}
],

function({{ options.appname }}{% if _mix_ %}, _{% endif %}, Backbone{% if _mix_ %}, Mixins{% endif %}){

	var {{ name|capitalize }} = Backbone.View.extend({% if _mix_ %}_.extend({},
		// mixins
		/* Mixins.Name, */ {

		// view properties {% else %}{{'{'}}{% endif %}
		events: {},
		initialize: function() {},
		render: function() {
			return this;
		}
	}{% if _mix_ %}){% endif %});

	return {{ name|capitalize }};
});