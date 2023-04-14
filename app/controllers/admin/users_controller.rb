class Admin::UsersController < ApplicationController
  before_action :require_authentication
  before_action :set_user!, only: %i[edit update destroy]

  def index
    @pagy, @users = pagy User.order(created_at: :desc)
  end
  def edit; end

  def update
    @user.admin_edit = true
    if @user.update user_params
      flash[:success] = 'users update!'
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'Користувач видалений'
    redirect_to admin_user_path
  end

  private

  def set_user!
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(
      :email, :name, :password, :password_confirmation, :role
    )
  end
end