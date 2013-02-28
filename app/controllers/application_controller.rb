class ApplicationController < ActionController::Base
  protect_from_forgery
  
   #this means this class and its inherited classes can access the methods below
  #private so the user can't directly access the methods in the form of URL
  
  protected
  
  def confirm_logged_in
    unless session[:user_id]
		flash[:notice]="Please log in."
		redirect_to(:controller=>'access', :action=>'login')
		return false #halts the before_filter
	else
      return true
	end
  end
  
  
end
