class TemplatesController < ApplicationController
  
  layout :false

  def directive
    respond_to do |format|
      format.html {render "templates/directives/#{params[:name]}"}
    end
  end
  
  def subdirectory
    respond_to do |format|
      format.html {render "templates/#{params[:subdirectory]}/#{params[:name]}"}
    end
  end
  
end
