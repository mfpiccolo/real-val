class ZipCode < ActiveRecord::Base
  versioned

  belongs_to :user

  monetize :z_index_value_cents

  before_save :update_zillow_info


  private

  def update_zillow_info
    data = Rubillow::Neighborhood.demographics({ zip: code })
    self.z_index_value = data.affordability_data["Zillow Home Value Index"][:zip].value
  end

end
