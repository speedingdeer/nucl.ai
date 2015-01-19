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

    watch: {
      less: {
        files: [
          'css/**/*.less'
        ],
        tasks: ['less:server']
      },
      jekyll: {
        files: [
          '**/*.{html,yml,md,mkd,markdown,coffee,css}'
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
      options: {
        paths:[""]
      },
      server: {
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
        'less:server',
        'jekyll:server'
      ],
      dist: [

      ]
    }

  });

  /**
  * Define tasks
  */
  // Define Tasks
  grunt.registerTask('serve', function () {
    grunt.task.run([
      //'clean:server',
      'concurrent:server',
      'connect:livereload',
      'watch'
    ]);
  });



}