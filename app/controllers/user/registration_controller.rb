class User::RegistrationController < ApplicationController
    # skip_before_action :is_authenticate?, only: [:new, :create]
    # before_action :already_logged_in?

    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_session_new_path, notice: "Successfully created account"
        elsif !@user.valid?
            flash[:alert] = @user.errors.full_messages[0]
            render :new, status: :unprocessable_entity
        else
            flash[:alert] = "invalid email or password"
            redirect_to new_user_registration_path, status: :unprocessable_entity
        end
    end

    private
    def already_logged_in?
        if !session[:user_id].nil?
            redirect_to movie_index_path,status: :unprocessable_entity, alert:"Already Logged in!"
        end
    end
    def user_params
        params.require(:user).permit(:username,:email,:password,:password_confirmation,:role)
    end
end
