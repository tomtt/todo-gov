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
  update_checked_css();

  $('#user_list .item input[type="checkbox"]').change(function(){
    var path = window.location.pathname + "/check_item";
    var id = this.name.replace("user_list[item_", "").replace("]", "");
    $.post(path, { item_id:  id, checked: this.checked }, function(json){
      $("#completed_percentage").text(json.completed_percentage);
      update_checked_css();
    });
  })

  $('#user_list .item .notes')
    .each(function() {
      var notes = $(this);
      var link = $("<a><img src='/images/notes_toggle.png'/></a>")
        .addClass("notes_toggle")
        .click(function(){ notes.toggle(); });
      $(this).parent("li").append(link);
      if(notes.val() === ""){ notes.hide(); }
      notes.keyup(function(){
        NoteSaver.start(notes);
      });
    });

  var NoteSaver = {pending: {}};
  NoteSaver.start = function(notes){
    if(this.pending[notes.id]){
      clearTimeout(this.pending[notes.id]);
    }
    this.pending[notes.id] = setTimeout(function(){ NoteSaver.save(notes) }, 500);
  };
  NoteSaver.save = function(el){
    var path = window.location.pathname + "/update_notes";
    var id = el.attr("name").replace("user_list[notes_", "").replace("]", "");
    $.post(path, { item_id:  id, notes: el.val() });
  };
});

