{% set _mix_ = options.mixins %}
define({% if options.setAMDName %}'collections/{{ name }}',{% endif %}[
	'{{ options.appname }}',{% if _mix_ %}
	'underscore',{% endif %}
	'backbone',
	'models/{{ name }}'{% if _mix_ %},
	'mixins'{% endif %}
],

function({{ options.appname }}{% if _mix_ %}, _{% endif %}, Backbone, {{ name|upperCamel }}Model{% if _mix_ %}, Mixins{% endif %}){

	var {{ name|upperCamel }}Collection = Backbone.Collection.extend({% if _mix_ %}_.extend({},
		// mixins
		/* Mixins.Name, */ {

		// collection properties {% else %}{{'{'}}{% endif %}
		url: '',
		model: {{ name|upperCamel }}Model
	}{% if _mix_ %}){% endif %});

	return {{ name|upperCamel }}Collection;
});