(($, ko, tinymce) ->
  ko.bindingHandlers['tinymce']  =
    init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
      observable = getWriteableObservable(valueAccessor)

      $(element).text(observable())

      settings = {
        setup: (editor) ->
          editor.on 'change keyup nodechange', (e) ->
            observable(editor.getContent())
      }
      window.setTimeout (-> $(element).tinymce(settings)), 0

      ko.utils['domNodeDisposal'].addDisposeCallback element, ->
        getEditor(element).remove()

    update: (element, valueAccessor) ->
      getEditor(element).setContent(valueAccessor()())

  getWriteableObservable = (valueAccessor) ->
    unless ko.isWriteableObservable(valueAccessor())
      throw '[knockout-binding-tinymce] The value bound to tinymce must be a writeable observable'
    valueAccessor()

  getEditor = (element) ->
    nullEditor = {remove: (->), getContent: (->), setContent: (->)}
    $(element).tinymce() || nullEditor

)(jQuery, ko, tinymce)
