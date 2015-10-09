(($, ko, tinymce) ->
  ko.bindingHandlers['tinymce']  =
    defaults: {}
    init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
      observable = getWriteableObservable(valueAccessor)
      initCallback = ->
      initCallback = allBindings.get('tinymceInitCallback') if allBindings.has('tinymceInitCallback')

      $(element).text(observable())

      settings = $.extend(true, {}, ko.bindingHandlers['tinymce'].defaults, {
        entity_encoding: 'raw',
        oninit: (editor) -> initCallback()
        setup: (editor) ->
          editor.on 'change keyup nodechange', (e) ->
            observable(editor.getContent())
      })
      window.setTimeout (-> $(element).tinymce(settings)), 0

      ko.utils['domNodeDisposal'].addDisposeCallback element, ->
        getEditor(element).remove()

    update: (element, valueAccessor) ->
      value = valueAccessor()()
      editor = getEditor(element)
      editor.setContent(value) unless editor.getContent() is value

  getWriteableObservable = (valueAccessor) ->
    unless ko.isWriteableObservable(valueAccessor())
      throw '[knockout-binding-tinymce] The value bound to tinymce must be a writeable observable'
    valueAccessor()

  getEditor = (element) -> $(element).tinymce() || nullEditor

  nullEditor = {remove: (->), getContent: (->), setContent: (->)}
)(jQuery, ko, tinymce)
