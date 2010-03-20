var todo_gov_widget = {
  perform: function() {
    var widget = $(this).closest('.widget');
    var info = $(this).closest('.widget').find('.perform_info');
    widget.children().hide();
    info.show();
    widget.append(info);

    var form = $(this).parent('form');

    var request = $.ajax({
      type: "POST",
      url: form.attr('action'),
      data: form.serialize(),
      context: widget,
      success: todo_gov_widget.success,
      error: todo_gov_widget.error
    });

    var user_data = {};
    form.find("input").each(function() {
      var matches = $(this).attr("name").match(/^user_data\[([^\]]+)\]$/);
      if(matches) {
        var field_name = "user[datamap]["+matches[1]+"]";
        user_data[field_name] = $(this).attr("value");
      }
    });

    var user_request = $.ajax({
      type: "POST",
      url: "/account.json",
      data: $.extend({"_method":"put"}, user_data)
    });

    return false;
  },
  success: function(response) {
    $(this).empty();
    $(this).append(response)
    todo_gov_widget.activate_perform_buttons();
  },
  error: function(XMLHttpRequest, textStatus, errorThrown) {
    $(this).children().show();
    $(this).find('.perform_info').hide();
    todo_gov_widget.activate_perform_buttons();
  },
  activate_perform_buttons: function() {
    $('input.widget_perform[type=submit]').click(todo_gov_widget.perform)
  },
  popuplate_user_data: function() {
    $(".widget form input").each(function() {
      var matches = $(this).attr("name").match(/^user_data\[([^\]]+)\]$/);
      if(matches) {
        $(this).attr("value", current_user.data[matches[1]]);
      }
    });
  },
  init: function() {
    this.activate_perform_buttons();
    this.popuplate_user_data();
  }
}

$(document).ready(function () {
  todo_gov_widget.init();
});
