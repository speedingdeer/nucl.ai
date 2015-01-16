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
      //less: {
      //  files: '<%= dir.app %>/css/**/*.less',
      //  tasks: ['less:server', 'autoprefixer:server'],
      //  options: {
      //  livereload: true,
      //    spawn: false
      //}
      //},
      //coffee: {
      //  files: ['<%= yeoman.app %>/_src/**/*.coffee'],
      //  tasks: ['coffee:dist']
      //}
      //,
      jekyll: {
        files: [
          '**/*.{html,yml,md,mkd,markdown}',
        ],
        tasks: ['jekyll:server']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          '.jekyll/**/*.html',
          'css/**/*.css',
          'js/**/*.js',
          'img/**/*.{gif,jpg,jpeg,png,svg,webp}'
        ]
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
        //'less:server',
        //'coffee:dist',
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