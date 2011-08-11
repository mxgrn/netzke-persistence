{
  modal: true,

  onOk: function() {
    var successfulItems = 0,
        totalItems = this.items.getCount();

    // Cycle through panes and call the applySettings method on each
    this.items.each(function(item) {
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
