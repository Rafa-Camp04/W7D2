class ApplicationController < ActionController::Base
    def login
        user.reset_session_token!
        session[:session_token] = user.session_token



    end
end
