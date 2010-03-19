$(function($){
  var update_checked_css = function(){
    $('#user_list .item').each(function(){
      var checkbox = $(this).find('input[type="checkbox"]');
      if(checkbox.attr("checked")){
        $(this).addClass("checked")
      }else{
        $(this).removeClass("checked")
      }
    });
  };
  $('#user_list .item input[type="checkbox"]').change(function(){
    var path = window.location.pathname + "/check_item";
    var id = this.name.replace("user_list[item_", "").replace("]", "");
    $.post(path, { item_id:  id, checked: this.checked }, function(json){
      $("#completed_percentage").text(json.completed_percentage);
      update_checked_css();
    });
  })
  update_checked_css();
});