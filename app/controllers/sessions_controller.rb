class SessionsController < ApplicationController
  def new
  end

  def create
  	params[:auth] = env["omniauth.auth"]
  	user = User.from_omniauth(user_params)
  	log_in(user)
    if user.new_user
      user.update(new_user: false)
	    redirect_to '/tutorial/1'
    else
      redirect_to '/'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
    def user_params
      params.require(:auth).permit(:provider, :uid, 
                                    info: [:name, :image, :email], 
                                    credentials: [:token, :expires_at],
                                    extra: [:gender])
    end


end
