class UserListsController < ApplicationController
  def resource_service
    current_user.user_lists
  end

  resources_controller_for :user_lists
  before_filter :require_user

  def check_item
    user_list = UserList.find(params[:id])
    if item = user_list.item(params[:item_id])
      item.checked = (params[:checked] == "true")
    end
    render :json => {:completed_percentage => user_list.completed_percentage}
  end
end
