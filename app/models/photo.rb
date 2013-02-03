# == Schema Information
# Schema version: 20090216032013
#
# Table name: photos
#
#  id           :integer(4)      not null, primary key
#  person_id    :integer(4)      
#  parent_id    :integer(4)      
#  content_type :string(255)     
#  filename     :string(255)     
#  thumbnail    :string(255)     
#  size         :integer(4)      
#  width        :integer(4)      
#  height       :integer(4)      
#  primary      :boolean(1)      
#  created_at   :datetime        
#  updated_at   :datetime        
#

class Photo < ActiveRecord::Base
  include ActivityLogger
  UPLOAD_LIMIT = 5 # megabytes
  
  # attr_accessible is a nightmare with attachment_fu, so use
  # attr_protected instead.
  attr_protected :id, :person_id, :parent_id, :created_at, :updated_at
  
  belongs_to :person
  belongs_to :group
  belongs_to :photoable, :polymorphic => true

  has_many :activities, :as => :item, :dependent => :destroy

  before_save :update_photo_attributes
  after_save :log_activity

  mount_uploader :picture, ImageUploader
  
  def log_activity
    if self.primary?
      unless self.person.nil?
        activity = Activity.create!(:item => self, :person => self.person)
        add_activities(:activity => activity, :person => self.person)
      end
    end
  end

  def update_photo_attributes
    if picture.present? && picture_changed?
      self.content_type = picture.file.content_type
      self.size = picture.file.size
    end
  end

end
