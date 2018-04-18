{% set _plural_name = name|pluralize %}define({% if amd %}'modules/{{ pathfile }}', {% endif %}[
	'msgBus',
	'underscore',
	'marionette',
	'core/resolver'
],

function(bus, _, Marionette, Resolver) {

	var resolver = new Resolver();

	var Controller = Marionette.Controller.extend({
		// code...
	});

	return Controller;
});
