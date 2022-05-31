class CreateServiceProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_providers do |t|
      t.string :name
      t.string :clazz_name
      t.text :config_bundle

      t.timestamps
    end

    add_index(:service_providers, :name)
    add_index(:service_providers, :clazz_name)
    add_index(:service_providers, [:name, :clazz_name])
  end
end
