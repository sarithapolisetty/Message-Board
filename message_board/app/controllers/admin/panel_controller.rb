class Admin::PanelController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = User.all
  end

  def messages
    @messages = Message.all
  end

  def replies
    @replies = Reply.all
  end

  private
  def authorize_admin!
    unless current_user.admin?
      flash[:danger] = "Access Denied"
      redirect_to root_path
    end
  end
  
end
