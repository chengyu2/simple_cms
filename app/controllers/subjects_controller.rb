class SubjectsController < ApplicationController

	layout "admin"
	
	before_filter :confirm_logged_in #method is inherited from the superclass

	
	
	def index
		list
		render('list')
	end
	
	
	
	def list #show all the records
		#@subjects = Subject.order("subjects.position ASC") #instance variable
		@subjects = Subject.sorted
	end


	def show
		@subject = Subject.find(params[:id])

	end

	
	def new
		@subject=Subject.new(:name=>"default")
		@subject_count = Subject.count+1 
		

		
		#so that subject instance variable can prepopulate the form with default value
	
	end
	
	#by default, rails escape all user input
	def create
	    #pull the position out of the params hash and store it in a variable
		new_position=params[:subject].delete(:position) 
		
		
		
		# instantiate  a new object using form parameters
		@subject= Subject.new(params[:subject])
		#save the object
		if @subject.save #if save succeeds
		
		    #once we saved the @subject, we can update its position
			@subject.move_to_position(new_position)
		
			flash[:notice]="Subject created." #flash hash stores messages, like a cookie
		#if save succeeds, redirect to the list action
			redirect_to(:action=> "list")
		#if save fails, redisplay the form so user can fix problems 
		else
			@subject_count = Subject.count+1
			render('new') #@subject will be prepopulated with previous entries
		end
	end
	
	def edit
		@subject=Subject.find(params[:id])
		@subject_count = Subject.count 	
	end
	
	def update
	
	  #pull the position of the the params
	  new_position=params[:subject].delete(:position)
	
		# find the object using form parameters
		@subject= Subject.find(params[:id])
		#save the object
		if @subject.update_attributes(params[:subject]) #if update succeeds, instead of saving it
		#if save succeeds, redirect to the list action
			
			@subject.move_to_position(new_position)
			
			flash[:notice]="Subject updated."

			redirect_to(:action=> "show", :id=>@subject.id)
		#if save fails, redisplay the form so user can fix problems 
		else
			@subject_count = Subject.count 	
			render('edit') #@subject will be prepopulated with previous entries
		end
	end

	def delete
		@subject=Subject.find(params[:id])
	end
	
	def destroy
		@subject=Subject.find(params[:id])
		#shuffle position before destroying the object
		@subject.move_to_position(nil)
		
		flash[:notice]="Subject destroyed."
		@subject.destroy
		redirect_to(:action=>"list")
		
	end
	
end
