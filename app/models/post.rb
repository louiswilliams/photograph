class Post < ActiveRecord::Base
  belongs_to :user
  has_many :shares
  has_attached_file :image, :styles =>{:large => "500x500#", :medium => "300x300#", :thumb => "100x100#"}
end