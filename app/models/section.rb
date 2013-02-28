#require 'position_mover'


class Section < ActiveRecord::Base
  
  include PositionMover
  
  # attr_accessible :title, :body
  attr_accessible :page_id, :name, :position, :visible, :content_type, :content
  
  
  ##################################################################
  
  belongs_to :page
  
   has_many :section_edits
  #section_edits not section_edit
  
  
  #What if we wanna directly pull out a list of users who edit the section, we can't directly call it unless we have
  has_many :editors, :through=>:section_edits, :class_name=> "AdminUser"
  
 
  ##################################################################
  
  validates_presence_of :name
  validates_length_of :name, :maximum=>255
  
  validates_presence_of :content
  validates_length_of :content, :maximum => 1000
  
  scope :visible, where(:visible=>true)
  scope :invisible, where(:visible=>false)
  scope :sorted, order('sections.position ASC')
  scope :search, lambda {|query| where (["name LIKE ?", "%#{query}%"])}
 
  private
  
  def position_scope
    "sections.page_id=#{page_id.to_i}"
	
  end
  
end
