define({% if amd %}'modules/{{ pathfile }}', {% endif %}[
	'msgBus',
	'underscore',
	'core/app',
	'selector'
],

function (bus, _, App, Selector) {

	var {{ classname }}Collection = App.Collection.extend({
		url: '/api/{{ pluralname }}',

		comparator: 'name',
	});

	var {{ classname }}Slt = function (options) {
		options = options || {};

		Selector.call(this, _.defaults(options, {
			mode: 'single',
			filters: ['name'],
			itemTemplate: '{{ section }}::selectors/{{ name }}SltItem',
			collection: new {{ classname }}Collection(),
			refreshBtn: true
		}));
	};

	{{ classname }}Slt.prototype = Object.create(Selector.prototype);

	return {{ classname }}Slt;

});
