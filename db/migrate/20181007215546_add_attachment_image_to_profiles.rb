class AddAttachmentImageToProfiles < ActiveRecord::Migration[5.2]
  def self.up
    change_table :profiles do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :profiles, :image
  end
end
