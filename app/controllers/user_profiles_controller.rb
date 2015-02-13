class UserProfilesController < ApplicationController
  before_action :authenticate_user!, :only => [:show]

  def index
    @users = User.all
  end

  def show
     @user = User.find(params[:id])

    respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @user }
    end
  end
end
