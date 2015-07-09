# grunt-bbamd_generate

> Backbone AMD generator.

## Getting Started
This plugin requires Grunt `~0.4.1`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-bbamd_generate --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-bbamd_generate');
```

## The "bbamd_generate" task

### Overview
In your project's Gruntfile, add a section named `bbamd_generate` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  bbamd_generate: {
    options: {
      appname    : "myAppName",
      source     : "myJsDirectory",
      mixins     : true,
      setAMDName : true
    },
    module:{},
    router:{},
    view:{},
    collection:{},
    model:{},
    template:{}
  },
})
```

### Options

#### options.appname
Type: `String`
Default value: `null`

Application name.

#### options.source
Type: `String`
Default value: `'js/backbone'`

Directory that will contain the generated files.

#### options.mixins
Type: `Boolean`
Default value: `false`

[Learn about Mixins](http://ricostacruz.com/backbone-patterns/#mixins)

#### options.setAMDName
Type: `Boolean`
Default value: `false`

Specifies the module name to Require.js

#### `new` options.tplExtension
Type: `String`
Default value: `.html`

The template extension

### Command structure

Two parameters are needed, the element to create and the name of that element

`grunt bbamd_generate:`**ElementType**`:`**ElementName**

You can create the fallowing items:
  * Models: `model`
  * Collections: `collection`
  * Views: `view`
  * Routers: `router`
  * Modules: `module`
  * Templates: `template`

The name can contain `.` to specify the parent folder

### Usage Examples

Generate AMD modules with Mixins and a explicit name

```js
  // ...
  options: {
    mixins: true,
    setAMDName: true
  }
  // ...
})
```

```shell
grunt bbamd_generate:module:user.post
```

Output:

```js
define('modules/user/post', [
	'underscore',
	'backbone',
	'mixins'
],

function (_, Backbone, Mixins) {

	var Post = { Views: {} };

	Post.Model = Backbone.Model.extend(_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// model properties
		defaults: {}
	}));

	Post.Collection = Backbone.Collection.extend(_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// collection properties
		url: '',

		model: Post.Model
	}));

	Post.Views.ModelView = Backbone.View.extend(_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// view properties
		events: {
		},

		initialize: function(options) {
			this.listenTo(this.model, 'destroy', this.remove);
			this.listenTo(this.model, 'change', this.render);
		},

		render: function() {
			return this;
		}
	}));

	Post.Views.CollectionView = Backbone.View.extend(_.extend({},
		// mixins
		/*Mixins.Name,*/ {

		// view properties
		events: {
		},

		initialize: function(options) {
			this.listenTo(this.collection, 'add', this.add);
			this.listenTo(this.collection, 'reset', this.render);
		},

		render: function() {
			this.$el.empty();

			this.collection.each(this.add, this);

			return this;
		},

		add: function(model) {
			var child = new Post.Views.ModelView({
				model: model
			});

			child.render().$el.appendTo(this.$el);
		}
	}));

	return Post;
});
```

## Bash alias

```shell
alias gen='noglob gruntGenerate'
gruntGenerate() {
  grunt bbamd_generate:$1:$2 $3
}
```

`gen model post` is equals to `grunt bbamd_generate:model:post`

## Release History

`0.1.4`
  * Modular folders
  * Bug fix

`0.1.3`
  * Customizable file extension for templates
  * Namespaces on file name to define folder hierarchy
  * Bug fix

`0.1.2`
  * Classify names
  * Use of `this.listenTo` instead of `this.on`
  * Pre-build `add` method on collection view
  * Explicit statement module, `app.module()` => `{ Views: {} }`
  * `setAMDName` option preset to `false`

`0.1.1`
  * Upper CamelCase names
  * Suffixes for each element

`0.1.0` First release
