class ItemsController < ApplicationController
  resources_controller_for :items
  before_filter :require_user

  def show
    redirect_to edit_list_url(params[:list_id])
  end
end
