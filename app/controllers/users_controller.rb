class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if updated = @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      respond_to do |wants|
        wants.html{ redirect_to account_url }
        wants.json{ render :json => {:status => true} }
      end
    else
      respond_to do |wants|
        wants.html{ render :action => :edit }
        wants.json{ render :json => {:status => false, :errors => @user.errors} }
      end
    end
  end
end
