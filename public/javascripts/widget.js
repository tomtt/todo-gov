var todo_gov_widget = {
  perform: function() {
    widget = $(this).closest('.widget')
    info = $(this).closest('.widget').find('.perform_info')
    widget.children().hide();
    info.show();
    widget.append(info);

    form = $(this).parent('form');

    request = $.ajax({
      type: "POST",
      url: form.attr('action'),
      data: form.serialize(),
      context: widget,
      success: todo_gov_widget.success,
      error: todo_gov_widget.error
    })


    return false;
  },
  success: function(response) {
    $(this).empty();
    $(this).append(response)
  },
  error: function(XMLHttpRequest, textStatus, errorThrown) {
    $(this).children().show();
    $(this).find('.perform_info').hide();
  }
}

$(document).ready(function () {
  $('input.widget_perform[type=submit]').click(todo_gov_widget.perform)                           
});
