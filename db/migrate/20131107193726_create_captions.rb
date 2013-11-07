class CreateCaptions < ActiveRecord::Migration
  def change
    create_table :captions do |t|
      t.references :post, index: true
      t.string :text

      t.timestamps
    end
  end
end
