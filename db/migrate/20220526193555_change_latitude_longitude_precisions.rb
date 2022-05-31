class ChangeLatitudeLongitudePrecisions < ActiveRecord::Migration[7.0]
  def change
    change_column :geolocations, :latitude, :decimal, :precision => 10, :scale => 6
    change_column :geolocations, :longitude, :decimal, :precision => 10, :scale => 6
  end
end
