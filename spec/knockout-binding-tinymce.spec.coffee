describe 'tinymce binding', ->
  $element = -> $('#target')

  applyBindings = (options) ->
    params = $.extend({
      fixture: '<textarea id="target" data-bind="tinymce: richText"></textarea>'
      viewModel: { richText: ko.observable('Initial <b>data</b>.') }
    }, {}, options)
    setFixtures(params.fixture)
    ko.applyBindings(params.viewModel, $element().get(0))

  describe 'initialization', ->
    it 'sets the element text to the observable value', ->
      applyBindings()
      expect($element()).toHaveText('Initial <b>data</b>.')

    describe 'when the bound value is not a writable observable', ->
      it 'throws an exception', ->
        expect(-> applyBindings(viewModel: { richText: ko.computed -> 'nothing' })).toThrow()

  describe 'editor updates', ->
    beforeEach (done) ->
      @viewModel = { richText: ko.observable() }
      applyBindings(viewModel: @viewModel)
      waitForEditor = ->
        if $element().tinymce()
          done()
        else
          setTimeout waitForEditor, 0
      waitForEditor()

    it 'updates the observable when editor changes', ->
      $element().tinymce().execCommand('mceInsertContent', {}, 'More data')

      expect(@viewModel.richText()).toContain('More data')
