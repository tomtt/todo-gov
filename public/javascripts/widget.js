var todo_gov_widget = {
  perform: function() {
    $(this).closest('.widget').replaceWith('Performing...')
    return false;
  }
}

$(document).ready(function () {
  $('input.widget_perform[type=submit]').click(todo_gov_widget.perform)                           
});
