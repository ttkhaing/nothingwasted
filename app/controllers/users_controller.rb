class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @items = @user.items
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :image, :bio)
  end
end