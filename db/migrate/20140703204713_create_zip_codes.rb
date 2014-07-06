class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.integer :code
      t.money :z_index_value
      t.integer :user_id

      t.timestamps
    end
  end
end
