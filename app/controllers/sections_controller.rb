class SectionsController < ApplicationController


	layout 'admin'

	
	before_filter :confirm_logged_in 
    before_filter :find_page


	
	def index
		list
		render('list')
	end
	
	
	
	def list #show all the records
		#@sections = Section.order("position ASC").where(:page_id=>@page.id) #instance variable
		@sections = Section.sorted.where(:page_id=>@page.id)
	end


	def show
		@section = Section.find(params[:id])


	end

	
	def new
		@section=Section.new(:name=>"default", :page_id=>@page.id)
		#so that section instance variable can prepopulate the form with default value
		@section_count=@page.sections.size+1
	end
	
	
	def create
	
	    new_position = params[:section].delete(:position)
		# instantiate  a new object using form parameters
		@section= Section.new(params[:section])
		#save the object
		if @section.save #if save succeeds
		
		    @section.move_to_position(new_position)
		
			flash[:notice]="Section created." #flash hash stores messages, like a cookie
		#if save succeeds, redirect to the list action
			redirect_to(:action=> "list", :page_id=>@section.page_id)
		#if save fails, redisplay the form so user can fix problems 
		else
			@section_count=@page.sections.size+1

			render('new') #@Section will be prepopulated with previous entries
		end
	end
	
	def edit
		@section=Section.find(params[:id])
		@section_count = @page.sections.size
	end
	
	def update
	
	    new_position = params[:section].delete(:position)

		# find the object using form parameters
		@section= Section.find(params[:id])
		#save the object
		if @section.update_attributes(params[:section]) #if update succeeds, instead of saving it
		
		    @section.move_to_position(new_position)
		
		#if save succeeds, redirect to the list action
			flash[:notice]="section updated."

			redirect_to(:action=> "show", :id=>@section.id, :page_id=>@section.page_id)
		#if save fails, redisplay the form so user can fix problems 
		else
			@section_count=@page.sections.size

			render('edit') #@section will be prepopulated with previous entries
		end
	end

	def delete
		@section=Section.find(params[:id])
	end
	
	def destroy
		@section=Section.find(params[:id])
		
		@section.move_to_position(nil)
		
		flash[:notice]="Section destroyed."
		@section.destroy
		redirect_to(:action=>"list", :page_id=>@page.id)
		
	end

   private
	def find_page
	  if params[:page_id]
	    @page= Page.find_by_id(params[:page_id]) #using find_by_id it wont pop out error, it will only shows nil if nothing can be found
	  end
	end    


end
