class ChangePrecisionForTecr < ActiveRecord::Migration
  def change
    add_column :properties, :tecr2, :decimal, precision: 6, scale: 4
    execute "UPDATE properties SET tecr2 = tecr"
    remove_column :properties, :tecr
    rename_column :properties, :tecr2, :tecr
  end
end
