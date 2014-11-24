jQuery(function() {

  return $('.new_ingredient').autocomplete({
    source: $('.new_ingredient').data('autocomplete-source')
  });
});