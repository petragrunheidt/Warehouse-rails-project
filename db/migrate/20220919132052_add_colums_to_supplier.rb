class AddColumsToSupplier < ActiveRecord::Migration[7.0]
  def change
    add_column :suppliers, :address, :string
    change_column :suppliers, :registration_number, :string

  end
end
