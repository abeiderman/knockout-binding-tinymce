(($, ko) ->
  ko.bindingHandlers['tinymce']  =
    init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
      valueObservable = valueAccessor()

      $(element).text valueObservable()

)(jQuery, ko)
