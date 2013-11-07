class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :shares
end

class Photo < Post
  
end

class Text < Post

end
