class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to plans_path(@user.id)
        else
            render 'new'
        end
    end
    
    def show
        @user = User.find(params[:id])
        @favorites_plans = @user.favorites
        @reviews_plans = @user.reviews
    end
    
    private
    
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation, :country, :image, :image_cache)
        end
end