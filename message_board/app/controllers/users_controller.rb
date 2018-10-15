class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params

        if @user.save
            session[:user_id] = @user.id 
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        @user = User.find params[:id]
    end

    def update
        @user = User.find params[:id]
        if @user.update(edit_user_params)
          redirect_to admin_panel_index_path
          flash[:success] = "User saved"
        else
          flash[:alert] = @user.errors.full_messages.join(", ")
          render :edit
        end 
    end

    def destroy
        @user = User.find params[:id]
        @user.destroy
        flash[:success] = "User removed"
        redirect_to admin_panel_index_path
    end

    private

    def edit_user_params
        params.require(:user).permit(:first_name, :last_name, :email)
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
