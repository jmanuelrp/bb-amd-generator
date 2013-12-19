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

#### options.app
Type: `String`
Default value: `'app'`

A string value that is used to...

#### options.source
Type: `String`
Default value: `'js/backbone'`

A string value that is used to...

#### options.mixins
Type: `Boolean`
Default value: `false`

A boolean value that is used to...

#### options.setAMDName
Type: `Boolean`
Default value: `false`

A boolean value that is used to...

### Usage Examples

```js
grunt.initConfig({
  bbamd_generate: {
    options: {
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

```shell
grunt bbamd_generate:module:post
```

```js

define('modules/post',[
  'app',
  'underscore',
  'backbone',
  'mixins'
],

function(app, _, Backbone, Mixins){

  var Post = app.module();

  Post.Model = Backbone.Model.extend(_.extend({},
    // mixins
    /* Mixins.Name, */ {

    // model properties 
    urlRoot: '',
    defaults: {}
  }));

  Post.Collection = Backbone.Collection.extend(_.extend({},
    // mixins
    /* Mixins.Name, */ {

    // collection properties 
    url: '',
    model: Post.Model
  }));

  Post.Views.ModelView = Backbone.View.extend(_.extend({},
    // mixins
    /* Mixins.Name, */ {

    // view properties 
    events: {},
    initialize: function() {},
    render: function() {
      return this;
    }
  }));

  Post.Views.CollectionView = Backbone.View.extend(_.extend({},
    // mixins
    /* Mixins.Name, */ {

    // view properties 
    initialize: function(options) {
      this.collection.on('reset',this.render,this);
      this.collection.on('add',this.add,this);
    },
    render: function() {
      return this;
    },
    add: function(model) {}
  }));

  return Post;
});

```


## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).

## Release History
_(Nothing yet)_
