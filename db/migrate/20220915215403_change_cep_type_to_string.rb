class ChangeCepTypeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :warehouses, :cep, :string
  end
end
