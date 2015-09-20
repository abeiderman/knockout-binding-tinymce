module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'knockout-binding-tinymce.js': 'src/knockout-binding-tinymce.coffee'
          'spec/js/knockout-binding-tinymce.spec.js': 'spec/**/*.coffee'
          'spec/js/knockout-binding-tinymce.helper.js': 'spec/**/*Helper.coffee'

    uglify:
      binding:
        files:
          'knockout-binding-tinymce.min.js' : ['knockout-binding-tinymce.js']

    jasmine:
      binding:
        src: 'knockout-binding-tinymce.js'
        options:
          specs: 'spec/js/**/*.spec.js'
          helper: 'spec/js/**/*.helper.js'
          vendor: [
            'node_modules/jquery/dist/jquery.js',
            'node_modules/underscore/underscore.js',
            'node_modules/jasmine-set/jasmine-set.js',
            'node_modules/jasmine-jquery/lib/jasmine-jquery.js',
            'node_modules/knockout/build/output/knockout-latest.js',
            'node_modules/tinymce/tinymce.jquery.js'
          ]

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'

  grunt.registerTask('build', ['coffee', 'uglify'])
  grunt.registerTask('test', ['jasmine'])

  grunt.registerTask('default', ['build', 'test'])
