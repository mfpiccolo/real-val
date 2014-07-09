class Property < ActiveRecord::Base
  belongs_to :user

  monetize :rent_per_month_cents
  monetize :listing_price_cents
  monetize :hoa_fee_cents
  monetize :z_tax_assessment_cents
  monetize :z_last_sold_price_cents
  monetize :z_price_cents
  monetize :z_price_high_cents
  monetize :z_price_low_cents
  monetize :z_price_change_cents
  monetize :z_rent_cents
  monetize :z_rent_low_cents
  monetize :z_rent_high_cents
  monetize :z_rent_change_cents

  RATE = 0.0425

  before_save :update_stats

  def expenses
    Money.new(units*17500)
  end

  def adj_rent_per_month
    rent_per_month * 0.9
  end

  def gross_mthly_inc_before_debt
    adj_rent_per_month - expenses - hoa_fee
  end

  def debt_service_per_month(ltv)
                                                                                            # taxes and ins
    listing_price * ltv * (RATE / 12 * (1 + RATE / 12) ** 360) / ((1 + RATE / 12)**360-1) + (listing_price * (0.019/12))
  end

  def income_per_month(ltv)
    gross_mthly_inc_before_debt - debt_service_per_month(ltv) - hoa_fee
  end

  def true_earnings_coverage_ratio(ltv)
    adj_rent_per_month / (debt_service_per_month(ltv) + expenses + hoa_fee)
  end

  def break_even_value(ltv)
    listing_price * ((adj_rent_per_month- expenses - hoa_fee)/debt_service_per_month(ltv))
  end


  private

  def update_stats
    self.tecr = true_earnings_coverage_ratio(0.965)
    self.price_per_sqr_ft = listing_price / sqr_ft
    split_address
    update_z_stats
  end

  def split_address
    split_addy = Indirizzo::Address.new(address)
    self.number = split_addy.number
    self.street = split_addy.street.first
    self.city   = split_addy.city.first
    self.state  = split_addy.state
    self.zip    = split_addy.zip
  end

  def update_z_stats
    response = Rubillow::PropertyDetails.deep_search_results({ :address => "#{number} #{street}", :citystatezip => "#{city}, #{state}", rentzestimate: "true" })
    self.z_bedrooms = response.bedrooms.to_i
    self.z_bathrooms = response.bathrooms.to_f
    self.z_tax_assessment = response.tax_assessment
    self.z_tax_assessment_year = response.tax_assessment_year
    self.z_year_built = response.year_built
    self.z_last_sold_on = response.last_sold_date
    self.z_last_sold_price = response.last_sold_price
    self.z_lot_size_square_feet = response.lot_size_square_feet
    self.z_finished_square_feet = response.finished_square_feet
    self.z_price = response.price
    if response.valuation_range.present?
      self.z_price_high = response.valuation_range[:high]
      self.z_price_low = response.valuation_range[:low]
    end
    self.z_price_change = response.change
    self.z_price_change_duration = response.change_duration
    self.zpid = response.zpid
    if response.rent_zestimate.present?
      self.z_rent = response.rent_zestimate[:price]
      self.z_rent_low = response.rent_zestimate[:valuation_range][:low] if response.rent_zestimate[:valuation_range].present?
      self.z_rent_high = response.rent_zestimate[:valuation_range][:high] if response.rent_zestimate[:valuation_range].present?
      self.z_rent_updated_on = response.rent_zestimate[:last_updated]
      self.z_rent_change = response.rent_zestimate[:value_change]
      self.z_rent_change_duration = response.rent_zestimate[:value_duration]
    end
  end

end
