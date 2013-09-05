class UsersController < ApplicationController

  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
	flash[:success] = "Profile updated"
	sign_in @user
	redirect_to @user
    else
	render 'edit'
    end
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      flash[:success] = "Welcome to the Template App!"
      redirect_to @user
    else
      render 'new'
    end
  end

private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # before filters
    
    def signed_in_user
	unless signed_in?
	    store_location
	    redirect_to signin_url, notice: "Please sign in."
	end
    end
    
    def correct_user
	@user = User.find(params[:id])
	redirect_to(root_url) unless current_user?(@user)
    end
    
end
