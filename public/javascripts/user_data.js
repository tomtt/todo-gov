var todo_gov_user_data = {
  dirty: false,
  set: function(key, value) {
    if(current_user.data[key] !== value) {
      current_user.data[key] = value;
      this.dirty = true;
    }
  },
  save: function(data) {
    if(!this.dirty) { return; }

    var data = {"_method":"put"};
    for(key in current_user.data) {
      if(current_user.data.hasOwnProperty(key)) {
        data["user[datamap]["+key+"]"] = current_user.data[key];
      }
    }

    var user_request = $.ajax({
      type: "POST",
      url: "/account.json",
      data: data,
      context: todo_gov_user_data,
      success: todo_gov_user_data.success
    });
  },
  success: function() {
    this.dirty = false;
    todo_gov_widget.popuplate_user_data();
  }
}
