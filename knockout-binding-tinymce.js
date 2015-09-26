(function() {
  (function($, ko, tinymce) {
    var getEditor, getWriteableObservable, nullEditor;
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
        var editor, value;
        value = valueAccessor()();
        editor = getEditor(element);
        if (editor.getContent() !== value) {
          return editor.setContent(value);
        }
      }
    };
    getWriteableObservable = function(valueAccessor) {
      if (!ko.isWriteableObservable(valueAccessor())) {
        throw '[knockout-binding-tinymce] The value bound to tinymce must be a writeable observable';
      }
      return valueAccessor();
    };
    getEditor = function(element) {
      return $(element).tinymce() || nullEditor;
    };
    return nullEditor = {
      remove: (function() {}),
      getContent: (function() {}),
      setContent: (function() {})
    };
  })(jQuery, ko, tinymce);

}).call(this);
