class SessionsController < ApplicationController

  def login
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    if user
      session[:user_id] = user.id
      flash[:success] = "#{user.username} is logged in"
      redirect_to root_path
    elsif
      user = User.create(username: params[:user][:username])
      user.save
      if user
        session[:user_id] = user.id
        flash[:success] = "#{user.username} is logged in"
        redirect_to root_path
      end
    else
      flash[:failure] = "Could not login as #{params[:user][:username]}"
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    session.delete(:user_id)
    flash[:success] = "Logged out successfully"

    redirect_to root_path
  end
end