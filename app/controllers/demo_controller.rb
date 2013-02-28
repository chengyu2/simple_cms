class DemoController < ApplicationController
  def index
	render(:template => 'demo/index')
	#redirect_to(:controller => "demo", :action=>'hi')
  end
  
  def hello
  @array = [1,2,3,4,5]
  @id = params[:id].to_i
  @page = params[:page].to_i
  end 
  #params is a method that will return a hash with indifferent access
  #that means using indifferent between using string or symbol to access values in the hash
  
  def yo
	render(:template => 'demo/hello')
  end

  #latest way
  def wasup
	render('hello')
   end
  
  def hi
	@array = [7,11,13,15,19]
	render('demo/hello')
  end
  
  def ghetto
	render(:text => 'keep it G')
  end
  
  def google
	redirect_to("http://www.google.com")
end


  
end
