(function() {
  (function($, ko, tinymce) {
    var getWriteableObservable;
    ko.bindingHandlers['tinymce'] = {
      init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
        var observable, settings;
        observable = getWriteableObservable(valueAccessor);
        $(element).text(observable());
        settings = {
          setup: function(editor) {
            return editor.on('change', function(e) {
              return observable(editor.getContent());
            });
          }
        };
        return window.setTimeout((function() {
          return $(element).tinymce(settings);
        }), 0);
      }
    };
    return getWriteableObservable = function(valueAccessor) {
      if (!ko.isWriteableObservable(valueAccessor())) {
        throw '[knockout-binding-tinymce] The value bound to tinymce must be a writeable observable';
      }
      return valueAccessor();
    };
  })(jQuery, ko, tinymce);

}).call(this);
