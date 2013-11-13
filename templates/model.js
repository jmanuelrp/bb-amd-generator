define('models/<%= grunt.util._.classify(name) %>',[
	'<%= options.appname %>',
	'backbone'
],

function(<%= options.appname %>, Backbone){

	var <%= grunt.util._.classify(name) %>Model = Backbone.Model.extend({
		urlRoot: '',
		defaults: {}
	});

	return <%= grunt.util._.classify(name) %>Model;
});