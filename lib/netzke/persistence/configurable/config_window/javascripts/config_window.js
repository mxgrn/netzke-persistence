{
  modal: true,

  onOk: function() {
    var successfulItems = 0,
        totalItems = this.items.getCount(),
        items;

    if (this.contentType == 'tabs') {
      items = this.items.first().items;
    } else {
      items = this.items;
    }

    // Cycle through panes and call the applySettings method on each
    items.each(function(item) {
      item.applySettings(function(i) {
        if (i.lastApplySettingsResult) {
          successfulItems++;
          if (successfulItems === totalItems) {
            this.hide();
          }
        }
      }, this);
    }, this);
  },

  onCancel: function() {
    this.hide();
  }
}
