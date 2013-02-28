class PublicController < ApplicationController
  
  layout 'public'
  
  before_filter :setup_navigation
  
  def index
  #intro text
  end

  def show
    #gets the permalink information from the routes through the symbol :permalink defined in the routes.rb
	@page = Page.where(:permalink=> params[:permalink], :visible => true).first
	redirect_to(:action=>'index') unless @page
  end
  
  
  def setup_navigation
  #using the name scopes here
    @subjects=Subject.visible.sorted
	
	
	
  end
  
end
