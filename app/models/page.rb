#require 'position_mover'

class Page < ActiveRecord::Base
  
  include PositionMover
 
  # attr_accessible :title, :body
  attr_accessible :subject_id, :name, :permalink, :position, :visible
  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, :class_name=> "AdminUser"  #which is suppoed to admin_users
  
  
  validates_presence_of :name
  validates_length_of :name, :maximum=>128
  validates_presence_of :permalink
  validates_length_of :permalink, :within=>3..255
  #use presence with length to disallow spaces
  
  validates_uniqueness_of :permalink
  #otherwise rails doesnt know which page to load
  #for unique values by subject, :scope=> :subject_id   Note: this means the permalink is just unique for some :subject_id
  
  
  scope :visible, where(:visible=>true)
  scope :invisible, where(:visible=>false)
  scope :sorted, order('pages.position ASC')
  scope :search, lambda {|query| where (["name LIKE ?", "%#{query}%"])}
  
   private
  
  def position_scope
    "pages.subject_id=#{subject_id.to_i}" #SQL query
	
  end
  
end
