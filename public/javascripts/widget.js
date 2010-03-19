var todo_gov_widget = {
  perform: function() {
    widget = $(this).closest('.widget')
    info = $(this).closest('.widget').find('.perform_info')
    widget.children().hide();
    info.show();
    widget.append(info)
    return false;
  }
}

$(document).ready(function () {
  $('input.widget_perform[type=submit]').click(todo_gov_widget.perform)                           
});
