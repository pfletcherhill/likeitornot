class UsersController < ApplicationController
  
  before_filter :restrict_access, except: [:create_from_facebook, :login, :logout]
  
  def create_from_facebook
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end
  
  def me
    respond_to do |format|
      format.json {render json: @current_user, status: 200}
    end
  end
  
  def login
  end
  
  def logout
    session[:user_id] = nil
    redirect_to root_url
  end
  
  def all_stats
    respond_to do |format|
      format.json {render json: User.stats, status: 200}
    end
  end
  
  def stats
    user = User.find_by(uid: params[:user_id])
    respond_to do |format|
      format.json {render json: user.stats, status: 200}
    end
  end
    
end
