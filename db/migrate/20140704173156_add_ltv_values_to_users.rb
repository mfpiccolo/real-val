class AddLtvValuesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ltv_1, :float, :precision => 3, :scale => 3, :default => 0.965
    add_column :users, :ltv_2, :float, :precision => 3, :scale => 3, :default => 0.8
  end
end
