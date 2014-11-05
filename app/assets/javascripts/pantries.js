jQuery(function() {
  return $('#ingredients').sortable({
    axis: 'y',
    update: function() {
      return $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  });
});