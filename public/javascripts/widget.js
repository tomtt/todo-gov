var todo_gov_widget = {
  perform: function() {
    var widget = $(this).closest('.widget');
    var results = widget.find('.results');
    var info = widget.find('.perform_info');
    var form = widget.find('form');

    widget.children().hide();
    results.show();
    info.show();
    widget.append(info);

    var data = widget.find('input').serialize();
    var url = widget.find('.url').attr('value')

    var request = $.ajax({
      type: "POST",
      url: url,
      data: data,
      context: widget,
      success: todo_gov_widget.success,
      error: todo_gov_widget.error
    });

    form.find("input").each(function() {
      var matches = $(this).attr("name").match(/^user_data\[([^\]]+)\]$/);
      if(matches) {
        todo_gov_user_data.set(matches[1], $(this).attr("value"));
      }
    });

    todo_gov_user_data.save();

    return false;
  },
  success: function(response) {
    $(this).empty();
    $(this).append(response)
    todo_gov_widget.popuplate_user_data();
  },
  error: function(XMLHttpRequest, textStatus, errorThrown) {
    $(this).children().show();
    $(this).find('.perform_info').hide();
    $('.error_message', this).show();
  },
  activate_perform_buttons: function() {
    $('input.widget_perform[type=submit]').live("click", todo_gov_widget.perform)
  },
  popuplate_user_data: function() {
    $(".widget_field").each(function() {
      var matches = $(this).attr("name").match(/^user_data\[([^\]]+)\]$/);
      if(matches && !$(this).attr("value")) {
        $(this).attr("value", current_user.data[matches[1]]);
      }
    });
  },
  auto_submit: function() {
    $(".widget.auto_submit").each(function() {
      var unfilled_fields = $(this).find("input[value='']");
      if(unfilled_fields.length == 0) {
        todo_gov_widget.perform.apply(this);
      }
    });
  },
  init: function() {
    this.activate_perform_buttons();
    this.popuplate_user_data();
    this.auto_submit();
  }
}

$(document).ready(function () {
  todo_gov_widget.init();
});
