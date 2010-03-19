class UserListsController < ApplicationController
  resources_controller_for :user_lists
  def check_item
    user_list = UserList.find(params[:id])
    if item = user_list.item(params[:item_id])
      item.checked = (params[:checked] == "true")
    end
    render :nothing => true
  end
end
