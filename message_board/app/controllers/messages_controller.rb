class MessagesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_message, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def new
        @message = Message.new
    end

    def create
        @message = Message.new message_params
        @message.user = current_user
        if @message.save
            redirect_to message_path(@message.id) 
        else
            render :new
        end
    end

    def show
        @message.save

        @reply = Reply.new
        @replies = @message.replies.order(created_at: :desc)

        @like = @message.likes.find_by(user: current_user)
    end

    def index
        @messages = Message.order(created_at: :desc).paginate(:per_page => 3, :page => params[:page])
    end

    def edit
    end

    def update
        if @message.update message_params
           redirect_to admin_panel_messages_path(@message.id)
           flash[:success] = "Message saved"
        else
            render :edit
        end
    end

    def destroy
        @message.destroy
        redirect_to admin_panel_messages_path
        flash[:success] = "Message removed"
    end

    def liked
      @messages = current_user
       .liked_messages
       .order("likes.created_at DESC")
    end

    private

    def message_params
        params.require(:message).permit(:title, :description, { tag_ids: [] }, :image)
    end

    def find_message
        @message = Message.find(params[:id])
    end

    def authorize_user!
      @message = Message.find(params[:id])
    unless can?(:manage, @message)
      flash[:error] = "Access Denied"
      redirect_to message_path(@message)
    end
   end
end
