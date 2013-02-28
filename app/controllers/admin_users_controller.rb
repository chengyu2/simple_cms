class AdminUsersController < ApplicationController

  layout "admin"
  before_filter :confirm_logged_in #method is inherited from the superclass

  def index
    list
	render('list')
  end
  
  
  def list
    @admin_users = AdminUser.sorted
    #@admin_users = AdminUser.order("last_name ASC, first_name ASC")
  end
  
  
  def new
    @admin_user=AdminUser.new  
    #@admin_user_count=AdminUser.count+1
  end
  
  
  def create
    @admin_user=AdminUser.new(params[:admin_user])
	
	if @admin_user.save
	  flash[:notice] = "You successfully created a new user! Our Nanjing community is growing!"
	  redirect_to(:action=>'list')
	else
	  #@admin_user_count=AdminUser.count+1
	  render('new')
	end
  end
  
  def edit
    @admin_user=AdminUser.find(params[:id])
	#@admin_user_count=AdminUser.count
  end
  
  def update
    @admin_user=AdminUser.find(params[:id])
	if @admin_user.update_attributes(params[:admin_user])
	  flash[:notice]="Admin user updated."
	  redirect_to(:action=>"list")
	else
	  #@admin_user_count=AdminUser.count
	  render('edit') 
	end
  end
  
  def delete
    @admin_user=AdminUser.find(params[:id])
  end
  
  def destroy
    @admin_user=AdminUser.find(params[:id])
	flash[:notice]="Admin user successfully deleted"
	@admin_user.destroy
	redirect_to(:action=>'list')
  end
  

end
