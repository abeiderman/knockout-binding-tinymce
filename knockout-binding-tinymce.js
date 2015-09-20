(function() {
  (function($, ko) {
    var getWriteableObservable;
    getWriteableObservable = function(valueAccessor) {
      if (!ko.isWriteableObservable(valueAccessor())) {
        throw '[knockout-binding-tinymce] The value bound to tinymce must be a writeable observable';
      }
      return valueAccessor();
    };
    return ko.bindingHandlers['tinymce'] = {
      init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
        var observable;
        observable = getWriteableObservable(valueAccessor);
        return $(element).text(observable());
      }
    };
  })(jQuery, ko);

}).call(this);
