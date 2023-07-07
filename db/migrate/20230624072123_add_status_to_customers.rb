class AddStatusToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :status, :integer, default: 1, null: false, limit: 1
  end
end
