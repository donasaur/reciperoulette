var update_view_button_url = function(list_of_recipe_names, recipe_index) {
  $("#roulette-picture").find("a").attr("href", "http://" + window.location.host + "/recipes/" + list_of_recipe_names[recipe_index]);
};

var update_block_button_url = function(list_of_recipe_names, recipe_index) {
  $("#block").find("form").attr("action", "http://" + window.location.host + "/users/block/" + list_of_recipe_names[recipe_index]);
};

// for now, all this function does is it swaps out the old image
// with a new image when the recipe is changed
// also modifies the recipe name.
var change_displayed_recipe = function(list_of_recipe_names, recipe_index) {
  $("#recipe-name").html(list_of_recipe_names[recipe_index]);

  old_image_element = $("#roulette-picture").html();
  new_image_element = old_image_element;
  new_image_element = old_image_element.replace(/\/assets\/\w+/, "/assets/" + list_of_recipe_names[recipe_index]);
  $("#roulette-picture").html(new_image_element);

  update_view_button_url(list_of_recipe_names, recipe_index);
  update_block_button_url(list_of_recipe_names, recipe_index);
};



$(document).ready(function() {
  console.log(list_of_recipe_names);
  
  var recipe_index = 0;
  var len_of_recipe_list = list_of_recipe_names.length; // length should be at least one
  
  $("#skip").on("click", function() {
    recipe_index = (recipe_index + 1) % len_of_recipe_list;
    change_displayed_recipe(list_of_recipe_names, recipe_index);
  });

  update_view_button_url(list_of_recipe_names, recipe_index);
  update_block_button_url(list_of_recipe_names, recipe_index);


  if (window.location.href.indexOf("/block/") > -1) {
    window.history.pushState("Roulette", "Roulette", "/users/roulette");
  }
});
