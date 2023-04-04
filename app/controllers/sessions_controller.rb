# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_on_authentication, only: %i[create new]
  before_action :require_authentication, only: :destroy

  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      do_sign_in @user
    else
      flash[:warning] = 'Incorrect email and/or password'
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash[:success] = 'Good bye!'
    redirect_to root_path
  end

  private

  def do_sign_in(user)
    sing_in user
    remember(user) if params[:remember_me] == '1'
    flash[:success] = "Welcome to back, #{current_user.name_or_email}!"
    redirect_to root_path
  end
end
