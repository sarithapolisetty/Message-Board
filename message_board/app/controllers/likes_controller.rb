class LikesController < ApplicationController

   before_action(:authenticate_user!)

  def create
    message = Message.find params[:message_id]

    unless can?(:like, message)
      flash[:danger] = "That's a bit narcissistic..."
      return redirect_to message_path(message)
    end

    like = Like.new(user: current_user, message: message)

    if like.save
      flash[:success] = "Message Liked! 💚"
    else
      flash[:danger] = "Already Liked Message... 🚫"
    end

    redirect_to message_path(message)
  end

  def destroy
    like = Like.find params[:id]
    like.destroy

    flash[:success] = "Message Unliked! 💔"
    redirect_to message_path(like.message)
  end

end
