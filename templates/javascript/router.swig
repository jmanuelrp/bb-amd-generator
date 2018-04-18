{% set _plural_name = name|pluralize %}define({% if amd %}'modules/{{ pathfile }}', {% endif %}[
	'msgBus',
	'underscore',
	'marionette',
	'{{ section }}/controller'
],

function (bus, _, Marionette, Controller) {

	var Router = Marionette.AppRouter.extend({

		appRoutes: {
		}

	});

	bus.commands.setHandler('router:start:{{ section }}', function () {
		new Router({
			controller: new Controller()
		});
	});

	return Router;
});
