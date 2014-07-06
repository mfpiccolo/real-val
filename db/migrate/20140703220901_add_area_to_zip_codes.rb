class AddAreaToZipCodes < ActiveRecord::Migration
  def change
    add_column :zip_codes, :area, :string
  end
end
