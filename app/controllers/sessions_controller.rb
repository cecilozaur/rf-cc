class SessionsController < ApplicationController

  def create

    auth = request.env['omniauth.auth']

    user = User.find_by_username_and_email(auth['info']['name'], auth['info']['email']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id

    redirect_to root_url, :notice => 'Signed in'

  end

  def destroy

    session[:user_id] = nil
    redirect_to(action: :index, controller: :auth)

  end
end
