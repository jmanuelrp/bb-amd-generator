define('routers/<%= grunt.util._.classify(name) %>',[
	'<%= options.appname %>',
	'backbone'
],

function(<%= options.appname %>, Backbone){

	var <%= grunt.util._.classify(name) %>Router = Backbone.Router.extend({
		routes: {
			"" :  "index"
		},
		initialize : function() {},
		index: function() {}
	});

	return <%= grunt.util._.classify(name) %>Router;
});