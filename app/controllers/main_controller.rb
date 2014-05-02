class MainController < ApplicationController
  
  before_filter :restrict_access
  
  def index
  end
  
end
