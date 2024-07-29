class User::SessionController < ApplicationController
    
    def new
        @user = User.new
    end
    def create
        
        if User.find_by(email: params[:email])&.authenticate(params[:password])
             @user = User.find_by(email: params[:email])
             session[:user_id] = @user.id
             if @user.role == 'admin'
                redirect_to user_admin_path, notice: "#{@user.username} Logged in successfully"
             else
                redirect_to movie_index_path, notice: "#{@user.username} Logged in successfully"
             end
        else
            if params[:username].empty? || params[:email].empty? || params[:password].empty?
                redirect_to user_session_new_path, alert: "Please fill the fields"
            else
                redirect_to user_session_new_path, alert: "Invalid password"
            end
        end
    end

    def destroy
        if session[:user_id] == nil
            redirect_to user_session_new_path, alert: "Please log in first", status: :unprocessable_entity
        else
            @user = User.find_by_id(session[:user_id])
            session[:user_id] = nil
            Current.user = nil
            redirect_to user_session_new_path, notice: "#{@user.username} Logged out successfully"
        end
    end

end
