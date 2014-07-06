require "xmlsimple"

class Zillow

  attr_reader :zip, :state, :conn, :base_url, :zwsid, :demo_info

  def initialize(zip, state="CA")
    @conn = Faraday.new
    @base_url = "http://www.zillow.com/webservice/GetDemographics.htm?"
    @zwsid = "X1-ZWz1dv0z4sj6rv_2ca3z"
    @state = state
    @zip = zip
  end

  def get_zip_info
    demo_info_url = base_url

    response = conn.get demo_info_url do |request|
      request.params['zws-id'] = zwsid
      request.params['zip'] = zip
    end

    parsed_response = XmlSimple.xml_in(response.body)

    hashie_info = Hashie::Mash.new(parsed_response)
    binding.pry
    z_index_hash = hashie_info.response.first.pages.first.page.first.tables.first.table.first.data.first.attribute.first
    if z_index_hash.name.first == "Zillow Home Value Index"
      binding.pry
    end
  end

end
