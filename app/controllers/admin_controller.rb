class AdminController < ApplicationController
    before_action :require_admin_login?
    def index
        @movies = Movie.all
    end

    def user_access
        @users = User.all
    end
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "User is successfully deleted!"
        redirect_to admin_user_access_path, status: :ok
    end
    
    private
    def require_admin_login?
        if Current.user == nil
            redirect_to user_session_new_path, alert: "Please login first"
        elsif !Current.user.admin?
            flash[:alert] = "unauthorized access"
            redirect_to user_session_new_path, status: :unprocessable_entity
        end
    end
end
