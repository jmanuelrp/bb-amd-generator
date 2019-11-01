define({% if amd %}'modules/{{ pathfile }}', {% endif %}[
	'underscore',
	'{{ section }}/selectors/{{ name }}',
	'core/modalSelector',
	'{{ section }}/modules/{{ name }}',
],

function (_, {{ classname }}Slt, ModalSelector, {{ classname }}) {

	var {{ classname }}MS = function (options) {
		options = options || {};

		var selector = new {{ classname }}Slt(_.omit(options,
			'event_name', 'show_clean', 'autoselect', 'title', 'hide_footer'
		));

		ModalSelector.call(this, selector, _.defaults(options, {
			title: 'Seleccionar',
			event_name: 'select:{{ name }}',
			autoselect: true,
			show_clean: !options.creationable,
			hide_footer: !options.creationable,
		}));

		if (options.creationable) {
			this.on('create:modal', this.onCreateModal);
		}
	};

	{{ classname }}MS.prototype = Object.create(ModalSelector.prototype);

	{{ classname }}MS.prototype.onCreateModal = function (_modal) {
		_modal.addButton({
			label: 'Crear nuevo',
			type: 'info',
			action: this.onClickNew{{ classname }}.bind(this)
		});
	};

	{{ classname }}MS.prototype.onClickNew{{ classname }} = function (e, _m) {
		var form_view = new {{ classname }}.Views.FormView();

		var m = _m.newInstance({
			data: {
				title: 'Crear nuevo',
				hide_footer: true
			}
		})
		.setContent(form_view)
		.show();

		m.listenTo(form_view, 'form:cancel form:model:save', m.close);

		this.listenTo(form_view, 'form:model:save', this.triggerItem);
	};


	return {{ classname }}MS;

});
