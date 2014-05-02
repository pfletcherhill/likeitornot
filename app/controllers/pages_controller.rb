class PagesController < ApplicationController
  
  before_filter :restrict_access
  
  def index
    user = User.find_by(uid: params[:user_id])
    respond_to do |format|
      if user
        format.json {render json: user.pages_by_count(params[:count]), status: 200}
      else
        format.json {render json: {error: "User not found"}, status: 404}
      end
    end
  end
  
  def show
    page = Page.find_by(uid: params[:page_id])
    respond_to do |format|
      format.json {render json: page, status: 200}
    end
  end
  
end
