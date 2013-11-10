class AddColumnsImageAndCaptionToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :image
    add_reference :posts, :caption
  end
end
