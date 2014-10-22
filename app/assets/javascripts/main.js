// for now, all this function does is it swaps out the old image
// with a new image when the recipe is changed
// also modifies the recipe name.
var change_displayed_recipe = function(list_of_recipe_names, recipe_index) {
  $("#recipe-name").html(list_of_recipe_names[recipe_index]);

  old_image_element = $("#roulette-picture").html();
  new_image_element = old_image_element;
  new_image_element = old_image_element.replace(/\/assets\/\w+/, "/assets/" + list_of_recipe_names[recipe_index]);
  $("#roulette-picture").html(new_image_element);
};

$(document).ready(function() {
  var recipe_names_in_json = $.cookie('list_of_recipe_names');
  console.log(recipe_names_in_json); // todo: need to see value of this

  var list_of_recipe_names = JSON.parse(recipe_names_in_json);
  var recipe_index = 0;
  var len_of_recipe_list = list_of_recipe_names.length; // length should be at least one
  
  $("#skip").on("click", function() {
    recipe_index = (recipe_index + 1) % len_of_recipe_list;
    change_displayed_recipe(list_of_recipe_names, recipe_index);
  });



});
