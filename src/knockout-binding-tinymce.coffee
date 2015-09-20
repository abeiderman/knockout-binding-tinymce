(($, ko) ->
  getWriteableObservable = (valueAccessor) ->
    unless ko.isWriteableObservable(valueAccessor())
      throw '[knockout-binding-tinymce] The value bound to tinymce must be a writeable observable'
    valueAccessor()

  ko.bindingHandlers['tinymce']  =
    init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
      observable = getWriteableObservable(valueAccessor)

      $(element).text observable()

)(jQuery, ko)
