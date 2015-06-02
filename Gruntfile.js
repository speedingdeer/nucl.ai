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

    concat: {
      bowerJs: {
        dest: 'js/lib.js',
          src: [
            'lib/modernizr/modernizr.js',
            'lib/jquery/jquery.js',
            'lib/raphael/raphael.js',
            'lib/jquery.easy-pie-chart/dist/easypiechart.min.js',
            'lib/jquery.easy-pie-chart/dist/jquery.easypiechart.min.js',
            'lib/jquery.countdown/dist/jquery.countdown.min.js',
            'lib/FileSaver/FileSaver.min.js',
            'lib/ics.js/ics.min.js'
          ]
      },
      bowerCss: {
        dest: 'css/lib.css',
          src: [
            'lib/animate.css/animate.css'
          ]
      },
    },

    "bower-install-simple": {
      options: {
        color: true,
          directory: "lib"
        },
        prod: {
          options: {
            production: true
          }
        },
        dev: {
          options: {
            production: false
          }
        }
    },

    sync: {
      less: {
        files: [
          { src: [
              'css/app.css',
            ],
            dest: ".jekyll"
          }
        ],
        verbose: true,
      },
      coffee: {
        files: [
          { src: [
              'js/app.js',
            ],
            dest: ".jekyll"
          }
        ],
        verbose: true,
      }
    },

    clean: {
      all: [
        //clean all generated files
        "css/app.css",
        "css/lib.css",
        "js/lib.js",
        "js/app.js",
        "lib"
      ],
    },

    watch: {
      less: {
        files: [
          'css/**/*.less'
        ],
        tasks: [
          'less:compile',
          'sync:less'
        ]
      },
      coffee: {
        files: [
          'coffee/**/*.coffee'
        ],
        tasks: [
          'coffee:compile',
          'sync:coffee'
        ]
      },
      jekyll: {
        files: [
          //'**/*.{html,csv,yml,md,mkd,markdown,js,css,png,jpg,jpeg,ico}', //consumes to many resources
          '*.{html,ico}',
          '_data/**/*',
          'img/**/*',
          '_layouts/**/*',
          '_includes/**/*',
          'js/assets.coffee',
          '!**/app.js',
          '!**/app.css',
          '!.jekyll/**',
          '!_site/**',
          '!lib/**'

        ],
        tasks: ['jekyll:server']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          '.jekyll/**/*.html',
          '.jekyll/css/*.css',
          '.jekyll/js/*.js'
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

    coffee: {
      compile: {
        files: {
          'js/app.js': 'coffee/**/*.coffee' // concat then compile into single file
        }
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
        'coffee:compile',
        'jekyll:server',
      ],
    },

    /** e2e tests config */

    nightwatch: {
      options: {
          custom_commands_path : "nightwatch/commands",
          globals_path: 'nightwatch/globals.js',
          src_folders : ["nightwatch/tests"],
        },
      phantom: {
          desiredCapabilities : {
          "browserName" : "phantomjs",
          "phantomjs.binary.path" : "node_modules/phantomjs2/lib/phantom/bin/phantomjs"
        }
      },
      browser: {
      }
    },

    'start-selenium-server': {
      dev: {
        options: {
          downloadUrl: 'https://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar',
          downloadLocation: '/tmp',
          serverOptions: {},
          systemProperties: {}
        }
      }
    },

    'stop-selenium-server': {
      dev: { }
    }

  });



  /**
  * Define tasks
  */
  grunt.registerTask('serve', function () {
    grunt.task.run([
      'bower-install-simple:prod',
      'concat:bowerJs',
      'concat:bowerCss',
      'concurrent:server',
      'connect:livereload',
      'watch'
    ]);
  });

  grunt.registerTask('build', function () {
    grunt.task.run([
      'bower-install-simple:prod',
      'concat:bowerJs',
      'concat:bowerCss',
      'less:compile',
      'coffee:compile'
    ]);
  });

  grunt.registerTask('test', function () {
    var browser = "phantom";
    grunt.option("force", true); //to always close selenium properly
    if (grunt.option("headless") == false) {
      //the only way to run default browser
      browser = "browser";
    }
    grunt.task.run([
      'start-selenium-server',
      'nightwatch:' + browser,
      'stop-selenium-server'
    ]);
  
  });

}