class AddSqrFtToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :sqr_ft, :integer
    add_column :properties, :price_per_sqr_ft, :float
  end
end
