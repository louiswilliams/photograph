class RemoveCaptionIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :caption_id, :integer
    add_column :posts, :caption, :string
  end
end
