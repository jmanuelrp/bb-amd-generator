define('modules/<%= grunt.util._.classify(name) %>',[
	'<%= options.appname %>',
	'backbone'
],

function(<%= options.appname %>, Backbone){

	var <%= grunt.util._.classify(name) %> = <%= options.appname %>.module();

	<%= grunt.util._.classify(name) %>.Model = Backbone.Model.extend({
		urlRoot: '',
		defaults: {}
	});

	<%= grunt.util._.classify(name) %>.Collection = Backbone.Collection.extend({
		url: '',
		model: <%= grunt.util._.classify(name) %>.Model
	});

	<%= grunt.util._.classify(name) %>.Views.ModelView = Backbone.View.extend({
		events: {},
		initialize: function() {},
		render: function() {
			return this;
		}
	});

	<%= grunt.util._.classify(name) %>.Views.CollectionView = Backbone.View.extend({
		initialize: function(options) {
			this.collection.on('reset',this.render,this);
			this.collection.on('add',this.add,this);
		},
		render: function() {
			return this;
		},
		add: function(model) {}
	});

	return <%= grunt.util._.classify(name) %>;
});