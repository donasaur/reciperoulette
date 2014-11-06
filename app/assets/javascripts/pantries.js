jQuery(function() {

  return $('#ingredient_name').autocomplete({
    source: $('#ingredient_name').data('autocomplete-source')
  });


  return $('#ingredients').sortable({
    axis: 'y',
    update: function() {
      return $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  });
});