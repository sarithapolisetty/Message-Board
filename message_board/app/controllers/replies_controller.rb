class RepliesController < ApplicationController

    before_action :authenticate_user!
    before_action :find_reply, only: [:destroy]
    before_action :authorize_user!, only: [:destroy]
    

    def create
      @message = Message.find params[:message_id]
      @reply = Reply.new reply_params
      @reply.message = @message
      @reply.user = current_user

      if @reply.save
        if @message.user.present?
          ReplyMailer
            .notify_message_owner(@reply)
            .deliver_now
        end
         redirect_to message_path(@message)
      else
        @replies = @message.replies.order(created_at: :desc)
        render 'messages/show'
      end
    end
    
    def destroy
      @reply.destroy
      redirect_to admin_panel_replies_path(@reply.message)
    end

    private

    def reply_params
        params.require(:reply).permit(:content)
    end
  
    def find_reply
      @reply = Reply.find(params[:id])
    end

    def authorize_user!
    @reply = Reply.find params[:id]
    unless can?(:delete, @reply)
      flash[:alert] = "Access Denied"
      redirect_to message_path(@reply.message)
    end
  end

end

