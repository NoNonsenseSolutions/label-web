class SessionsController < ApplicationController
  def new
  end

  def create
  	params[:auth] = env["omniauth.auth"]
  	user = User.from_omniauth(user_params)
  	session[:user_id] = user.id
  	redirect_to '/tutorial/1'
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url
  end

  private
    def user_params
      params.require(:auth).permit(:provider, :uid, 
                                    info: [:name, :image], 
                                    credentials: [:token, :expires_at],
                                    extra: [:gender])
    end


end