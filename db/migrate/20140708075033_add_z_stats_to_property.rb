class AddZStatsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :z_bedrooms, :integer
    add_column :properties, :z_bathrooms, :float
    add_money :properties, :z_tax_assessment
    add_column :properties, :z_tax_assessment_year, :string
    add_column :properties, :z_year_built, :string
    add_column :properties, :z_last_sold_on, :date
    add_money :properties, :z_last_sold_price
    add_column :properties, :z_lot_size_square_feet, :string
    add_column :properties, :z_finished_square_feet, :string
    add_money :properties, :z_price
    add_money :properties, :z_price_high
    add_money :properties, :z_price_low
    add_money :properties, :z_price_change
    add_column :properties, :z_price_change_duration, :string
    add_column :properties, :zpid, :integer
    add_money :properties, :z_rent
    add_money :properties, :z_rent_low
    add_money :properties, :z_rent_high
    add_column :properties, :z_rent_updated_on, :date
    add_money :properties, :z_rent_change
    add_column :properties, :z_rent_change_duration, :string
  end
end
