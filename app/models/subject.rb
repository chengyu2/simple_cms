#require 'position_mover'
#this is a good practice beccause no error shows if we just use "include"

class Subject < ActiveRecord::Base
  
  include PositionMover
  
  attr_accessible :name, :position, :visible, :created_at
  #this is because the latest rails disables mass assignment
  #has_one :page
  has_many :pages
  
  #Don't need to validate (in most cases):
  # ids, foreign keys, timestampls, booleans, counters
  validates_presence_of :name
  validates_length_of :name, :maximum=>128
  
  
  scope :visible, where(:visible=>true)
  scope :invisible, where(:visible=>false)
  scope :sorted, order('subjects.position ASC')
  scope :search, lambda {|query| where (["name LIKE ?", "%#{query}%"])}

  #dont need to overide position scope
  
  
end
