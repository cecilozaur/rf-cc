class AuthController < ApplicationController
  def index

  end

  def login
    authorized_user = User.authenticate(params[:email],params[:password])

    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to(:action => 'index', :controller => 'home')
    else
      flash[:notice] = 'Invalid Username or Password'
      render 'index'
    end
  end

end
