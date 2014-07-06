class Property < ActiveRecord::Base
  belongs_to :user

  monetize :rent_per_month_cents
  monetize :listing_price_cents
  monetize :hoa_fee_cents

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
  end

  def split_address
    split_addy = ::Indirizzo::Address.new(address)
    self.number = split_addy.number
    self.street = split_addy.street.first
    self.city   = split_addy.city.first
    self.state  = split_addy.state
    self.zip    = split_addy.zip
  end

end
