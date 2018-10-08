class AddColumnsToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :street, :string
    add_column :profiles, :city, :string
    add_column :profiles, :state, :string
    add_column :profiles, :country, :string
    add_column :profiles, :ip, :string
    add_column :profiles, :latitude, :float
    add_column :profiles, :longitude, :float
  end
end
