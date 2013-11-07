class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :post, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
