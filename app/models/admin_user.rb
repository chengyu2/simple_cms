require 'digest/sha2'

class AdminUser < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :first_name, :last_name, :email, :password, :username, :email_confirmation, :password
  #set_table_name("admin_users") 
  #have a crazy table name instead of the rail convention
  
  has_and_belongs_to_many :pages
  
  
  has_many :section_edits
  has_many :sections, :through=> :section_edits
  
  attr_accessor :password #this is a nondatabase attribute
  
  
  
  
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  ########################### /i means case insensitive

  #Old way of validation
 # validates_length_of :first_name, :maximum=>25
  #validates_presence_of :last_name
  #validates_length_of :last_name, :maximum=>50
  #validates_presence_of :username
  #validates_length_of :username, :within=4..25
  
  #validates_uniqueness_of :username
  
  #validates_presence_of :email
  #validates_length_of :email, :maximum=>100
  #validates_format_of :email, :with=>EMAIL_REGEX
  #validates_confirmation_of :email
  
 
#new 'sexy' validations
	validates :first_name, :presence=>true, :length=>{:maximum=>25}
	validates :last_name, :presence=>true, :length=>{:maximum=>50}
	validates :username, :length=> {:within=>8..25}, :uniqueness=>true
	validates :email, :presence=>true, :length=>{:maximum=>99},:uniqueness=>true ,:format=>{:with=>EMAIL_REGEX}, :confirmation=>true
  
  validates_length_of :password, :within=>8..25, :on=>:create	
  before_save :create_hashed_password
  after_save :clear_password
  
  ##########################
  def name
    "#{first_name} #{last_name}"
  end
  
  
  
  
  
  ###########################
  
  scope :named, lambda {|first, last| where(:first_name => first, :last_name=>last )}
  
  scope :sorted, order("admin_users.last_name ASC, admin_users.first_name ASC")
  
  
  
  
  def self.authenticate(username="", password="")
    user=AdminUser.find_by_username(username)
	if user && user.password_match?(password)
		return user
	else 
	  return false
	end	
  end  

  def password_match?(password="") 
    #salt is available cuz its an instance method
	hashed_password == AdminUser.hash_with_salt(password, salt)
	#notice its double equal "=="
   
  end
	
	def self.hash(password="")
		Digest::SHA2.hexdigest(password)
	end
	#Without salt, hackers can use the rainbow table to decrypt shit
	def self.make_salt(username="")
		Digest::SHA2.hexdigest("Use #{username} with #{Time.now} to make salt. Remember Nanjing Massacre!")
	end
  
	def self.hash_with_salt(password="", salt="")
		Digest::SHA2.hexdigest("Put #{salt} on the #{password}")
	end
	
	

	
	
	
	#before_save, before_create, after_save, after_create, before_validation, after_validation
  private #so only this class can call it
  def create_hashed_password
		#if :password has a value
		#	-indicates we want to update the passowrd
		#	-before_save: encrypt value with salt
		#	-Save hash in :hashed_password
		# 	-after_save: clear :password
		
		#if :password does not have a value
		#	-No encryption, no :hashed_password change
		#	-Allow the record to save normally
		#Validate presence of :password for all new users
	
    unless password.blank?
	  self.salt = AdminUser.make_salt(username) if salt.blank? #for new record only. It's ok to add self.salt.blank, but not necesary
	  #Note: when we are doing assingment, self.salt is needed on the left side of the equal sign
	  self.hashed_password = AdminUser.hash_with_salt(password, salt)
	end
  end
	
  def clear_password
  #for security and efficiency. no need to hash again and again
	self.password = nil
  end
  
  
  
  
  
end
