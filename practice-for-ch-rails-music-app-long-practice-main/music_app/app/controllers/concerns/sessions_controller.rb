class SessionsController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        email=params[:user][:email]
        password=params[:user][:password]
        @user = User.find_by_credentials(email, password)
        if @user
            login(@user)
            redirect_to user_url
        else
            render :new
        end
    end

end