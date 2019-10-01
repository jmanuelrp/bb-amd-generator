/*
 * grunt-bbamd_generate
 * https://github.com/jmanuelrp/bb-amd-generator
 *
 * Copyright (c) 2013 JManuel Ruiz
 * Licensed under the MIT license.
 */

'use strict';

var path      = require('path');
var swig      = require('swig');
var inflected = require('inflected');

swig.setFilter('classify', function (input) {
  return inflected.classify(input);
});

swig.setFilter('singularize', function (input) {
  return inflected.singularize(input);
});

swig.setFilter('pluralize', function (input) {
  return inflected.pluralize(input);
});

swig.setFilter('titleize', function (input) {
  return inflected.titleize(input);
});

module.exports = function (grunt) {

  grunt.registerMultiTask('bbamd_generate', 'Backbone AMD generator.', function ( gname ) {

    var options = this.options({
      appname: null,
      source: 'js/backbone',
      mixins: false,
      setAMDName: false,
      tplExtension: '.html'
    });

    var elements = (function() {
      var elements = [
        { tplname: 'selector.swig'   ,extension: '.js'   ,name: 'selector'   ,type: 'selector'   },
        { tplname: 'sltmodal.swig'   ,extension: '.js'   ,name: 'sltmodal'   ,type: 'selector'   },
        { tplname: 'view.swig'       ,extension: '.js'   ,name: 'view'       ,type: 'view'       },
        { tplname: 'model.swig'      ,extension: '.js'   ,name: 'model'      ,type: 'model'      },
        { tplname: 'collection.swig' ,extension: '.js'   ,name: 'collection' ,type: 'collection' },
        { tplname: 'router.swig'     ,extension: '.js'   ,name: 'router'     ,type: 'router'     },
        { tplname: 'controller.swig' ,extension: '.js'   ,name: 'controller' ,type: 'controller' },
        { tplname: 'module.swig'     ,extension: '.js'   ,name: 'module'     ,type: 'module'     },
        { tplname: 'template.swig'   ,extension: '.html' ,name: 'template'   ,type: 'template'   },
        { tplname: 'item.swig'       ,extension: '.html' ,name: 'item'       ,type: 'template'   },
        { tplname: 'itemForm.swig'   ,extension: '.html' ,name: 'itemForm'   ,type: 'template'   },
        { tplname: 'layout.swig'     ,extension: '.html' ,name: 'layout'     ,type: 'template'   },
        { tplname: 'sltItem.swig'    ,extension: '.html' ,name: 'sltItem'    ,type: 'template'   }
      ];

      var _get = function(name) {
        if (typeof name === 'undefined' || !name)
        {
          return null;
        }

        for (var i = 0; i < elements.length; i++) {
          if( elements[i].name === name )
          {
            return elements[i];
          }
        }

        return null;
      };

      return {
        has: function(name) {
          return _get(name) !== null;
        },
        get: function(name) {
          return _get(name);
        }
      };
    })();

    function splitNames(fullname) {
      var names, _pfolder, pfolder, depname, folders, name;

      names = fullname.split('@');
      folders = names[0].split('.');
      name = folders.pop();
      _pfolder = names.length > 1 ? names[1].split(',') : null;
      pfolder = _pfolder ? _pfolder.shift() : null;
      depname = _pfolder ? _pfolder.pop() : null;

      return {
        name: name,
        folders: folders,
        section: pfolder,
        depname: depname
      };
    }

    var ElementCreator = function (el, options) {
      var template, tplpath;

      tplpath = path.join(__dirname, '..', 'templates', 'javascript', el.tplname);
      template = grunt.file.read( tplpath );

      return {
        make: function (names) {
          var filepath, content, message, data, filename, extension,  _path;

          if( typeof names.name === 'undefined' )
          {
            grunt.fail.warn('The name has not been specified.');
            names.name = 'name';
          }
          grunt.log.writeln(JSON.stringify(el));

          filename = el.type === 'collection' ? inflected.pluralize(names.name) : names.name;
          grunt.log.writeln(filename);

          filename = el.tplname === 'sltmodal.swig' ? names.name+'Modal' : filename;
          grunt.log.writeln(filename);

          extension = el.type === 'template' ? options.tplExtension : el.extension;

          _path = [options.source, inflected.pluralize(el.type)];

          if (names.section)
          {
            _path.splice(_path.length - 1, 0, names.section);
          }

          if (names.omit_group_folder) {
            _path.pop();
          }

          _path = _path.concat(names.folders, [filename + extension]);

          filepath = path.join.apply(path, _path);

          if( grunt.file.exists(filepath) )
          {
            grunt.fail.warn('File already exists ('+ filepath +').');
          }

          if (el.type !== 'template') {
            content = swig.render(template, { locals: {
              app: options.appname,
              mix: options.mixins,
              amd: options.setAMDName,
              pathfile: names.folders.concat([filename]).join(path.sep),
              name: names.name,
              depname: names.depname,
              section: names.section,
              classname: inflected.classify(names.name),
              pluralname: inflected.pluralize(names.name),
              pluralclassname: inflected.classify(inflected.pluralize(names.name))
            }});
          }
          else {
            content = template;
          }

          grunt.file.write(filepath, content);

          message = 'Great! '+ names.name +' '+ el.type +' has been created ('+ filepath +').';
          grunt.log.writeln(message);
        }
      };
    };

    var f = new ElementCreator(elements.get(this.target), options),
    split_names = splitNames(gname);

    if (split_names.section && !grunt.file.isDir(options.source, split_names.section)) {
      ['router', 'controller'].forEach(function (item) {
        (new ElementCreator(elements.get(item), options)).make({
          name: item,
          folders: [],
          section: split_names.section,
          depname: split_names.depname,
          omit_group_folder: true
        });
      });
    }

    f.make(split_names);

    if (this.target === 'module') {
      var base_name = split_names.name;

      ['item', 'itemForm', 'layout'].forEach(function (item) {
        split_names.name = base_name + inflected.classify(item);

        (new ElementCreator(elements.get(item), options)).make(split_names);
      });
    }

    if (this.target === 'selector') {
      var base_name = split_names.name;

      (new ElementCreator(elements.get('sltmodal'), options)).make(split_names);

      split_names.name = base_name + inflected.classify('sltItem');
      split_names.folders.push('selectors');
      (new ElementCreator(elements.get('sltItem'), options)).make(split_names);
    }


  }); // END TASK

}; // END EXPORT
