class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.bigint :post_id, null: false
      t.bigint :customer_id, null: false
      t.timestamps
    end
  end
end
