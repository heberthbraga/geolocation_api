class Geolocation < ApplicationRecord
  after_save :clear_cached_geolocations
  after_destroy :clear_cached_geolocations

  validates_presence_of :latitude, on: :create, message: "can't be blank"
  validates_presence_of :longitude, on: :create, message: "can't be blank"
  validates :lookup_address, presence: true, uniqueness: { case_sensitive: true }

  private

  def clear_cached_geolocations
    Cacher.flush_cached_gelocations
  end
end
