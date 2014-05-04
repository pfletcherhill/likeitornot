class MainController < ApplicationController
  
  before_filter :restrict_access, except: [:privacy]
  
  def index
  end
  
  def privacy
  end
  
  def about
  end
  
end
