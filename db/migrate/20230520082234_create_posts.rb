class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :caption
      t.timestamps
      t.integer :customer_id
    end
  end
end
