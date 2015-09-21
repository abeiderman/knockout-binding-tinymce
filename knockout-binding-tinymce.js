(function() {
  (function($, ko, tinymce) {
    var getEditor, getWriteableObservable;
    ko.bindingHandlers['tinymce'] = {
      defaults: {},
      init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
        var observable, settings;
        observable = getWriteableObservable(valueAccessor);
        $(element).text(observable());
        settings = $.extend(true, {}, ko.bindingHandlers['tinymce'].defaults, {
          setup: function(editor) {
            return editor.on('change keyup nodechange', function(e) {
              return observable(editor.getContent());
            });
          }
        });
        window.setTimeout((function() {
          return $(element).tinymce(settings);
        }), 0);
        return ko.utils['domNodeDisposal'].addDisposeCallback(element, function() {
          return getEditor(element).remove();
        });
      },
      update: function(element, valueAccessor) {
        return getEditor(element).setContent(valueAccessor()());
      }
    };
    getWriteableObservable = function(valueAccessor) {
      if (!ko.isWriteableObservable(valueAccessor())) {
        throw '[knockout-binding-tinymce] The value bound to tinymce must be a writeable observable';
      }
      return valueAccessor();
    };
    return getEditor = function(element) {
      var nullEditor;
      nullEditor = {
        remove: (function() {}),
        getContent: (function() {}),
        setContent: (function() {})
      };
      return $(element).tinymce() || nullEditor;
    };
  })(jQuery, ko, tinymce);

}).call(this);
