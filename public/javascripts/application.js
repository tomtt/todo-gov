$(function($){
  var update_checked_css = function(){
    $('#user_list .item').each(function(){
      $(this).removeClass("next");
      var checkbox = $(this).find('input[type="checkbox"]');
      if(checkbox.attr("checked")){
        $(this).addClass("checked")
      }else{
        $(this).removeClass("checked")
      }
    });
    $($('#user_list .item:not(.checked)').first()).addClass("next");
  };
  update_checked_css();

  $('#user_list .item input[type="checkbox"]').change(function(){
    var path = window.location.pathname + "/check_item";
    var id = this.name.replace("user_list[item_", "").replace("]", "");
    $.post(path, { item_id:  id, checked: this.checked }, function(json){
      $("#completed_percentage").text(json.completed_percentage);
      update_checked_css();
    });
  }).hide();
  
  $('#user_list li.item').append($("<div/>").addClass("actions"));

  $('#user_list .item .actions').each(function(){
    var actions = $(this);
    var link = $("<button />");
    link.click(function(){
      var checkbox = $(this).closest("li").find('input:checkbox');
      if( checkbox.attr("checked") ){
        checkbox.attr("checked", false);
      }else{
        checkbox.attr("checked", true);
      }
      checkbox.change();
      return false;
    });
    link.text("Done").addClass("done_link");
    actions.append(link);


    link = $("<button />");
    link.click(function(){
      $(this).closest("li").slideUp();
      return false;
    });
    link.text("Skip").addClass("done_link");
    actions.append(link);
  });
  

  var NoteSaver = {pending: {}, known_text: {}};

  NoteSaver.setup = function(notes){
    NoteSaver.known_text[notes.attr("id")] = notes.val();
    var link = $("<a><img src='/images/notes_toggle.png'/></a>")
      .addClass("notes_toggle")
      .click(function(){ notes.toggle(); notes.focus(); });
    notes.parent("li").append(link);
    if(notes.val() === ""){ notes.hide(); }
    notes.keyup(function(){
      NoteSaver.start(notes);
    });
  };

  NoteSaver.start = function(notes){
    if(NoteSaver.known_text[notes.attr("id")] === notes.val()){return;}
    
    if(this.pending[notes.attr("id")]){
      clearTimeout(this.pending[notes.attr("id")]);
    }
    notes.parent("li").find(".working").remove();
    notes.parent("li").find(".done").remove();
    notes.parent("li").append($("<p class='working'/>").text("Saving…"));
    this.pending[notes.attr("id")] = setTimeout(function(){NoteSaver.save(notes);}, 500);
  };

  NoteSaver.save = function(notes){
    var path = window.location.pathname + "/update_notes";
    var id = notes.attr("name").replace("user_list[notes_", "").replace("]", "");
    $.post(path, { item_id:  id, notes: notes.val() }, function(result){
      if(result.ok){
        var li = notes.parent("li");
        li.find(".working").remove();
        li.find(".done").remove();
        li.append($("<p class='done'/>").text("Saved."));
        li.find("p.done").fadeOut(1000);
        NoteSaver.known_text[notes.attr("id")] = notes.val();
      }else{
        NoteSaver.start(notes);
      }
    });
  };

  $('#user_list .item .notes').each(function(){ NoteSaver.setup($(this)); });
});

