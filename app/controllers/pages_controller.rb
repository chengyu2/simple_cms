class PagesController < ApplicationController
	
	layout("admin")
	
	before_filter :confirm_logged_in
	before_filter :find_subject
	
	def index
		list
		render('list')
	end
	
	
	
	def list #show all the records
		#@pages = Page.order("position ASC").where(:subject_id=>@subject.id) #instance variable
		#@pages = Page.order("pages.position ASC") #instance variable
		
		@pages = Page.sorted.where(:subject_id=>@subject.id)
		
	end


	def show
		@page = Page.find(params[:id])

	end

	
	def new
		print @subject.id
		@page=Page.new(:name=>"new page", :subject_id=>@subject.id)
		#so that page instance variable can prepopulate the form with default value
		#@page_count = Page.count+1 
		#the quirckiness about ruby is that I should leave no space between page.count and 1 
		
		@page_count=@subject.pages.size+1
		#after we make pages nested, we need to adapt the position so that its no longer total number 
		#of pages but total number of pages under a particular subject
	end
	
	
	def create
	    
		new_position = params[:page].delete(:position)
	
		# instantiate  a new object using form parameters
		@page= Page.new(params[:page])
		#save the object
		if @page.save #if save succeeds
			
			@page.move_to_position(new_position)
			
			flash[:notice]="Page created." #flash hash stores messages, like a cookie
		#if save succeeds, redirect to the list action
			redirect_to(:action=> "list", :subject_id=>@page.subject_id) #in case the user selected another subject as parent subject
		#if save fails, redisplay the form so user can fix problems 
		else
			#@page_count = Page.count+1 
			@page_count = @subject.pages.size+1
			render('new') #@Page will be prepopulated with previous entries
		end
	end
	
	def edit
		@page=Page.find(params[:id])
		#@page_count = Page.count
		@page_count=@subject.pages.size
	end
	
	def update
	
	    new_position = params[:page].delete(:position)
		# find the object using form parameters
		@page= Page.find(params[:id])
		#save the object
		if @page.update_attributes(params[:page]) #if update succeeds, instead of saving it
		#if save succeeds, redirect to the show action
			
			@page.move_to_position(new_position)
			
			flash[:notice]="Page updated."

			redirect_to(:action=> "show", :id=>@page.id, :subject_id=>@page.subject_id)
		#if save fails, redisplay the form so user can fix problems 
		else
			#@page_count = Page.count
			@page_count=@subject.pages.size
			render('edit') #@page will be prepopulated with previous entries
		end
	end

	def delete
		@page=Page.find(params[:id])
	end
	
	def destroy
		@page=Page.find(params[:id])
		
		@page.move_to_position(nil)
		
		flash[:notice]="Page destroyed."
		@page.destroy
		redirect_to(:action=>"list", :subject_id=>@subject.id)
		
	end
	
	
	private
	def find_subject
	  if params[:subject_id]
	    @subject= Subject.find_by_id(params[:subject_id]) #using find_by_id it wont pop out error, it will only shows nil if nothing can be found
	  end
	end    


end
