class AddAddressFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :number, :string
    add_column :properties, :street, :string
    add_column :properties, :city, :string
    add_column :properties, :state, :string
    add_column :properties, :zip, :string
  end
end
