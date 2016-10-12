{% set _plural_name = name|pluralize %}define({% if amd %}'modules/{{ pathfile }}', {% endif %}[
	'msgBus',
	'underscore',
	'core/app'
],

function (bus, _, App) {

	var {{ classname }} = { Views: {} };

	{{ classname }}.Model = App.Model.extend({
		{% if depname %}urlRoot: function () {
			return this.{{ depname }}.url() + '/{{ _plural_name }}';
		},{% else %}urlRoot: '/api/{{ _plural_name }}',{% endif %}

		resolver: {
			name: '{{ name }}'{% if depname %},
			dependency: '{{ section }}/modules/{{ depname }}@Model',
			dependency_name: '{{ depname }}'
		},

		initialize: function (attrs, options) {
			this.{{ depname }} = options.{{ depname }};{% endif %}
		}
	});

	{{ classname }}.Collection = App.Collection.extend({
		{% if depname %}url: function () {
			return this.{{ depname }}.url() + '/{{ _plural_name }}';
		},

		model: function (attrs, options) {
			return new {{ classname }}.Model(attrs, {
				{{ depname }}: options.collection.{{ depname }}
			});
		},

		initialize: function (models, options) {
			this.{{ depname }} = options.{{ depname }};
		}{% else %}url: '/api/{{ _plural_name }}',

		model: {{ classname }}.Model{% endif %}
	});

	{{ classname }}.Views.ModelView = App.ItemView.extend({
		behaviors: {
			Editable: {
				template: {
					show: '{{ section }}::{{ name }}Item',
					edit: '{{ section }}::{{ name }}ItemForm'
				}
			},
			Deletable: {
				content: function (model) {
					return '¿Desea eliminar <b>' + model.get('nombre') + '</b>?';
				}
			},
			Row: {}
		}
	});

	{{ classname }}.Views.FormView = App.ItemView.extend({
		template: '{{ section }}::{{ name }}ItemForm',

		behaviors: {
			Form: {
				model: {{ classname }}.Model{% if depname %},
				options: function () {
					return {
						{{ depname }}: this.{{ depname }}
					};
				}{% endif %}
			}
		}{% if depname %},

		initialize: function (options) {
			this.{{ depname }} = options.{{ depname }};
		}{% endif %}
	});

	{{ classname }}.Views.CollectionView = App.CollectionView.extend({
		childView: {{ classname }}.Views.ModelView
	});

	{{ classname }}.Views.CollectionLayout = App.CollectionLayoutView.extend({
		template: '{{ section }}::{{ name }}Layout',

		behaviors: {
			Creationable: {
				collection: '{{ _plural_name }}'
			},
			Reloadable: {
				collection: '{{ _plural_name }}'
			},
			Filterable: {
				source: '{{ _plural_name }}',
				output: '_{{ _plural_name }}',
				filters: []
			},
			Pagination: {
				source: '_{{ _plural_name }}'
			}
		},

		initialize: function (options) {
			this.{{ _plural_name }} = options.{{ _plural_name }};{% if depname %}
			this.{{ depname }} = options.{{ depname }};{% endif %}

			this.collectionView = new {{ classname }}.Views.CollectionView({
				collection: this._{{ _plural_name }}{% if depname %},
				{{ depname }}: this.{{ depname }}{% endif %}
			});

			this.formView = new {{ classname }}.Views.FormView({% if depname %}{
				{{ depname }}: this.{{ depname }}
			}{% endif %});
		}
	});

	return {{ classname }};
});
