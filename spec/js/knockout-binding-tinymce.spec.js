(function() {
  describe('tinymce binding', function() {
    return describe('initialization', function() {
      beforeEach(function() {
        this.viewModel = {
          richText: ko.observable('Initial data')
        };
        setFixtures('<textarea id="target" data-bind="tinymce: richText"></textarea>');
        this.element = $('#target');
        return ko.applyBindings(this.viewModel, this.element.get(0));
      });
      return it('sets the element text to the observable value', function() {
        return expect(this.element).toHaveText('Initial data');
      });
    });
  });

}).call(this);
