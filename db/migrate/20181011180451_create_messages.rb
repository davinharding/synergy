class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :sender, foreign_key: {to_table: :profiles}
      t.references :recipient, foreign_key: {to_table: :profiles}

      t.timestamps
    end
  end
end
