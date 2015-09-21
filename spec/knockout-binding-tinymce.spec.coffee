describe 'tinymce binding', ->
  afterEach -> $('body #target').remove()

  $element = -> $('#target')
  editor = -> $element().tinymce()

  applyBindings = (options) ->
    params = $.extend({
      fixture: '<textarea id="target" data-bind="tinymce: richText"></textarea>'
      viewModel: { richText: ko.observable('Initial <b>data</b>.') }
    }, {}, options)
    $('body').append(params.fixture)
    ko.applyBindings(params.viewModel, $element().get(0))

  waitForEditorToInitialize = (done) ->
    _waitForEditor = (done) ->
      if editor()
        done()
      else
        setTimeout (-> _waitForEditor(done)), 0
    _waitForEditor(done)

  describe 'when initialized', ->
    it 'sets the element text to the observable value', ->
      applyBindings()
      expect($element()).toHaveText('Initial <b>data</b>.')

    describe 'when the bound value is not a writable observable', ->
      it 'throws an exception', ->
        expect(-> applyBindings(viewModel: { richText: ko.computed -> 'nothing' })).toThrow()

    describe 'when defaults are provided', ->
      beforeEach (done) ->
        ko.bindingHandlers['tinymce'].defaults = {plugins: 'table'}
        spyOn($.fn, 'tinymce')
        applyBindings()
        window.setTimeout done, 10

      it 'includes the defaults in the tinymce initialization', ->
        expect($.fn.tinymce).toHaveBeenCalledWith(jasmine.objectContaining({plugins: 'table'}))

  describe 'when content is updated in the editor', ->
    beforeEach (done) ->
      @viewModel = { richText: ko.observable('Initial data') }
      applyBindings(viewModel: @viewModel)
      waitForEditorToInitialize(done)

    it 'updates the observable when content is inserted', ->
      editor().execCommand('mceInsertContent', {}, 'More data')

      expect(@viewModel.richText()).toContain('More data')

    it 'updates the observable when content is formatted', ->
      editor().execCommand('SelectAll')
      editor().execCommand('Bold')

      expect(@viewModel.richText()).toContain('<strong>Initial data</strong>')

  describe 'when the observable is updated', ->
    beforeEach (done) ->
      @viewModel = { richText: ko.observable('Initial data') }
      applyBindings(viewModel: @viewModel)
      waitForEditorToInitialize(done)

    it "updates the editor's content", ->
      @viewModel.richText('New data')

      expect(editor().getContent()).toContain('New data')
