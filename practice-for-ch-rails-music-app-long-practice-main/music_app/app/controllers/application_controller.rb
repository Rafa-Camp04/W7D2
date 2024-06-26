class ApplicationController < ActionController::Base
    
    helper_method :current_user, :logged_in?

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def current_user
        current_session_token = session[:session_token]
        User.find_by(session_token: current_session_token)
    end

    def logged_in?
        !!current_user
    end

    def logout!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

end
