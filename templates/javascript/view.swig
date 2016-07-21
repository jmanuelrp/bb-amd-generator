define({% if amd %}'modules/{{ pathfile }}', {% endif %}[
	'msgBus',
	'underscore',
	'core/app'
],

function (bus, _, App) {

	var {{ classname }}View = App.LayoutView.extend({
		template: '{{ section }}::{{ name }}View',

		initialize: function (options) {{'{'}}{% if depname %}
			this.{{ depname }} = options.{{ depname }};{% endif %}
			// code...
		}
	});

	return {{ classname }}View;
});
