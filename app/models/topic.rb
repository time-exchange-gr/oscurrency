# == Schema Information
# Schema version: 9
#
# Table name: topics
#
#  id                :integer(11)     not null, primary key
#  forum_id          :integer(11)     
#  person_id         :integer(11)     
#  name              :string(255)     
#  forum_posts_count :integer(11)     default(0), not null
#  created_at        :datetime        
#  updated_at        :datetime        
#

class Topic < ActiveRecord::Base
  
  MAX_NAME = 70
  
  belongs_to :forum, :counter_cache => true
  belongs_to :person
  has_many :posts, :order => :created_at, :dependent => :destroy,
                   :class_name => "ForumPost"
  
  validates_presence_of :name, :forum, :person
  validates_length_of :name, :maximum => MAX_NAME
end