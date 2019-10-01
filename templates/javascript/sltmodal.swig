define({% if amd %}'modules/{{ pathfile }}', {% endif %}[
	'underscore',
	'{{ section }}/selectors/{{ name }}',
	'core/modalSelector'
],

function (_, {{ classname }}Slt, ModalSelector) {

	var {{ classname }}MS = function (options) {
		options = options || {};

		var selector = new {{ classname }}Slt(_.omit(options,
			'event_name', 'show_clean', 'autoselect', 'title', 'hide_footer'
		));

		ModalSelector.call(this, selector, _.defaults(options, {
			title: 'Seleccionar',
			event_name: 'select:{{ name }}',
			autoselect: true,
			show_clean: true,
			hide_footer: true
		}));
	};

	{{ classname }}MS.prototype = Object.create(ModalSelector.prototype);

	return {{ classname }}MS;

});
