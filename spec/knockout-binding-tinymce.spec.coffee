describe 'tinymce binding', ->
  $element = -> $('#target')

  applyBindings = (options) ->
    params = $.extend({
      fixture: '<textarea id="target" data-bind="tinymce: richText"></textarea>'
      viewModel: { richText: ko.observable('Initial <b>data</b>') }
    }, {}, options)
    setFixtures(params.fixture)
    ko.applyBindings(params.viewModel, $element().get(0))

  describe 'initialization', ->
    it 'sets the element text to the observable value', ->
      applyBindings()
      expect($element()).toHaveText('Initial <b>data</b>')

    describe 'when the bound value is not a writable observable', ->
      it 'throws an exception', ->
        expect(-> applyBindings(viewModel: { richText: ko.computed -> 'nothing' })).toThrow()
