class AddHoaFeeToProperties < ActiveRecord::Migration
  def change
    add_money :properties, :hoa_fee
  end
end
