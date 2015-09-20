(function() {
  (function($, ko) {
    return ko.bindingHandlers['tinymce'] = {
      init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
        var valueObservable;
        valueObservable = valueAccessor();
        return $(element).text(valueObservable());
      }
    };
  })(jQuery, ko);

}).call(this);
