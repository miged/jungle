class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  # User log-in
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      # Save the user id inside the browser cookie.
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
