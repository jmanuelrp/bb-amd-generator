define('collections/<%= _.camelize(name) %>',[
	'<%= options.appname %>',
	'models/<%= grunt.util._.classify(name) %>'
	'backbone'
],

function(<%= options.appname %>, <%= grunt.util._.classify(name) %>Model, Backbone){


	var <%= grunt.util._.classify(name) %> = Backbone.Collection.extend({
		urlRoot: '',
		model: <%= grunt.util._.classify(name) %>Model
	};

	return <%= grunt.util._.classify(name) %>;
});