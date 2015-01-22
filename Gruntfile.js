'use strict';

module.exports = function (grunt) {
  // Show elapsed time after tasks run
  require('time-grunt')(grunt);
  // Load all Grunt tasks
  require('load-grunt-tasks')(grunt);


  /**
  * Set up configuration
  */
  grunt.initConfig({

    connect: {
      options: {
        port: 9000,
        livereload: 35729,
        // change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'
      },
      livereload: {
        options: {
          open: true,
          base: [
            '.jekyll',
            '.'
          ]
        }
      }
    },

    sync: {
      lib: {
        files: [
          { src: [
            'lib/**/*.min.js',
            'lib/**/*.min.map', 
             'lib/**/modernizr.js', //thx modernizr for not calling file min :) 
             '!**/test/**', //don't include test files
             '!**/*migrate*', //don't include migration files
             '!**/less-*.min.js', //don't need less
             ], 
             dest: 'js' 
          },
          { src: [
            'lib/**/*.min.css', 
             ], 
             dest: 'css' 
          }, // picking up grid.less from semantic.gs
          { src: [
            'lib/semantic.gs/stylesheets/less/grid.less', 
             ], 
             dest: 'css/' 
          }, // includes files in path and its subdirs
        ],
        verbose: true,
      }
    },

    clean: {
      all: [ //clean all generated files
       "js/lib", 
        "css/lib",
        "css/app.css"
      ],
    },

    watch: {
      less: {
        files: [
          'css/**/*.less'
        ],
        tasks: ['less:compile']
      },
      jekyll: {
        files: [
          '**/*.{html,yml,md,mkd,markdown,coffee,css,png,jpg,ico}'
        ],
        tasks: ['jekyll:server']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          '.jekyll/**/*.html',
        ]
      }
    },

    less: {
      compile: {
        files: [{
          'css/app.css': 'css/app.less',
        }]
      }
    },

    jekyll: {
      options: {
        bundleExec: true,
        config: '_config.yml',
        src: '.'
      },
      server: {
        options: {
          config: '_config.yml',
          dest: '.jekyll'
        }
      }
    },

    concurrent: {
      server: [
        'less:compile',
        'sync:lib',
        'jekyll:server'
      ],
    }

  });

  /**
  * Define tasks
  */
  grunt.registerTask('serve', function () {
    grunt.task.run([
      'concurrent:server',
      'connect:livereload',
      'watch'
    ]);
  });

  grunt.registerTask('build', function () {
    grunt.task.run([
      'sync:lib',
      'less:compile',
    ]);
  });


}