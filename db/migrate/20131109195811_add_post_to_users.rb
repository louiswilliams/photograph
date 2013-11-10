class AddPostToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :post, index: true
  end
end
