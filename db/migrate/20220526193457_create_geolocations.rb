class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :country_code
      t.string :country_name
      t.string :region_code
      t.string :region_name
      t.string :city
      t.decimal :latitude
      t.decimal :longitude
      t.string :lookup_type
      t.string :lookup_address

      t.timestamps
    end

    add_index(:geolocations, :lookup_address)
    add_index(:geolocations, :latitude)
    add_index(:geolocations, :longitude)
    add_index(:geolocations, [:latitude, :longitude])
  end
end
