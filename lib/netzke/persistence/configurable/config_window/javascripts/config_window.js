{
  height: 300,
  modal: true,

  onOk: function() {
    var res = [];
    this.items.each(function(item) {
      if (item.getSettings) res.push(item.getSettings());
    }, this);

    this.submitSettings(res, function(success) {
      if (success) {
        this.feedback('Success!');
        this.hide();
      }
    }, this);
  },

  onCancel: function() {
    this.hide();
  }
}
