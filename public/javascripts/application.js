$(function($){
  $('#user_list .item input[type="checkbox"]').change(function(){
    var path = window.location.pathname + "/check_item";
    var id = this.name.replace("user_list[item_", "").replace("]", "");
    $.post(path, { item_id:  id, checked: this.checked });
  })
});