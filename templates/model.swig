{% set _mix_ = options.mixins %}
define({% if options.setAMDName %}'models/{{ name }}',{% endif %}[
	'{{ options.appname }}',{% if _mix_ %}
	'underscore',{% endif %}
	'backbone'{% if _mix_ %},
	'mixins'{% endif %}
],

function({{ options.appname }}{% if _mix_ %}, _{% endif %}, Backbone{% if _mix_ %}, Mixins{% endif %}){

	var {{ name|upperCamel }}Model = Backbone.Model.extend({% if _mix_ %}_.extend({},
		// mixins
		/* Mixins.Name, */ {

		// model properties {% else %}{{'{'}}{% endif %}
		urlRoot: '',
		defaults: {}
	}{% if _mix_ %}){% endif %});

	return {{ name|upperCamel }}Model;
});