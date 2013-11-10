class RemovePostFromUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :post, index: true
  end
end
