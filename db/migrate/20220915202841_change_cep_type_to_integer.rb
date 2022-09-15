class ChangeCepTypeToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :warehouses, :cep, :integer
  end
end
