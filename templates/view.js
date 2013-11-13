define('views/<%= grunt.util._.classify(name) %>',[
	'<%= options.appname %>',
	'backbone'
],

function(<%= options.appname %>, Backbone){

	var <%= grunt.util._.classify(name) %>View = Backbone.View.extend({
		events: {},
		initialize: function() {},
		render: function() {
			return this;
		}
	});

	return <%= grunt.util._.classify(name) %>View;
});