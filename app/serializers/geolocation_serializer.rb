class GeolocationSerializer < ApplicationSerializer
  set_id :id

  attributes :country_code, :country_name, :region_code, :region_name, 
    :city, :latitude, :longitude, :lookup_type, :lookup_address
end