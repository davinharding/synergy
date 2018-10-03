class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :age
      t.string :location
      t.string :picture
      t.string :gender
      t.string :bio

      t.timestamps
    end
  end
end
