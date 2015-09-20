describe 'tinymce binding', ->
  describe 'initialization', ->
    beforeEach ->
      @viewModel = { richText: ko.observable('Initial data') }
      setFixtures('<textarea id="target" data-bind="tinymce: richText"></textarea>')
      @element = $('#target')
      ko.applyBindings(@viewModel, @element.get(0))

    it 'sets the element text to the observable value', ->
      expect(@element).toHaveText('Initial data')
