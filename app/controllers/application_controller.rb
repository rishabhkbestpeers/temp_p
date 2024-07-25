class ApplicationController < ActionController::Base
    before_action :is_authenticate?

    private
    def is_authenticate?
        allowed_paths_for_unauthenticated = [
            { controller: 'user/registration', action: 'new' },
            { controller: 'user/session', action: 'new' },
            { controller: 'active_admin/devise/sessions', action: 'new' },
            { controller: 'user/registration', action: 'create' },
            { controller: 'user/session', action: 'create' }
          ]
      
          # If user is logged in
          if session[:user_id].present?
            # Prevent access to registration and session controllers
            if ["user/registration", "user/session","active_admin/devise/sessions"].include?(params[:controller]) &&
               ["new", "create"].include?(params[:action])
              redirect_to root_path, notice: "You are already logged in! PLEASE LOG OUT"
            else
              # Set the current user
              Current.user = User.find_by(id: session[:user_id])
            end
          else
            # If user is not logged in, allow access to certain actions
            unless allowed_paths_for_unauthenticated.any? { |path| path[:controller] == params[:controller] && path[:action] == params[:action] }
              redirect_to user_session_new_path, notice: "Please log in!"
            end
          end
        end


        # if session[:user_id].nil?
        #     return if ["user/registration","user/session"].include?(params[:controller]) && ["new","create"].include?(params[:action])
        #    redirect_to user_session_new_path, notice:"please login !"
        # else
        #     Current.user = User.find_by(id: session[:user_id])
        # end
    end

