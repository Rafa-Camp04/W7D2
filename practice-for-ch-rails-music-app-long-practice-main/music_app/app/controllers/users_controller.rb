class UsersController < ApplicationController

    def index
        @users = User.all
        render json: @users
    end

    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        # debugger
        if @user.save
            login(@user)
            redirect_to users_url
        else
            render json: @user.errors.full_messages, status: 422
        end 
    end

    def show
        render json: self.email
    end



    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

end