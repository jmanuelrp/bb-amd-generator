/*
 * grunt-bb_pep_generate
 * https://github.com/jmanuelrp/bb_pep_amdtemplates
 *
 * Copyright (c) 2013 JManuel Ruiz
 * Licensed under the MIT license.
 */

'use strict';


module.exports = function(grunt) {

  grunt.registerMultiTask('bb_pep_generate', 'The best Grunt plugin ever.', function( name ) {

    var options = this.options({ source: 'app/js/backbone' });

    var elements = (function() {
      var elements = [
        { tplname: 'view.js'       ,extension: '.js'   ,name: 'view'       },
        { tplname: 'model.js'      ,extension: '.js'   ,name: 'model'      },
        { tplname: 'collection.js' ,extension: '.js'   ,name: 'collection' },
        { tplname: 'router.js'     ,extension: '.js'   ,name: 'router'     },
        { tplname: 'module.js'     ,extension: '.js'   ,name: 'module'     },
        { tplname: 'template.html' ,extension: '.html' ,name: 'template'   }
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
          return (_get(name)!==null)? true : false;
        },
        get: function(name) {
          return _get(name);
        }
      };
    })();

    var ElementCreator = function (el, options) {
      var template, tplpath;

      tplpath  = __dirname + '/../templates/' + el.tplname;
      template = grunt.file.read( tplpath );

      return {
        make: function( name ) {
          if( typeof name === 'undefined' ){
            grunt.fail.warn('the name has not been specified.');
            // return grunt.log.error('Missing name.');
            name = 'name';
          }
          // BUG: Incluir pluralizacion
          var filepath = options.source +'/'+ el.name +'s/'+ name + el.extension;

          if( grunt.file.exists(filepath) ){
            grunt.fail.warn('File already exists ('+ filepath +').');
          }

          var content, message, data;

          data = {
            name: name,
            options: options
          };
 
          content = grunt.template.process(template, { data:data });
          grunt.file.write(filepath, content);

          message = 'Great! '+ name +' '+ el.name +' has been created ('+ filepath +').';
          grunt.log.writeln(message);

        }
      };
    };

    if (!elements.has(this.target)) {
      grunt.fail.fatal('Missing arguments');
    }

    var f = new ElementCreator(elements.get(this.target), options);
    f.make( name );
  });

};
