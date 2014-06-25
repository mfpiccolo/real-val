class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string   :address
      t.integer  :units
      t.money    :listing_price
      t.money    :rent_per_month
      t.float    :tecr

      t.timestamps
    end
  end
end
