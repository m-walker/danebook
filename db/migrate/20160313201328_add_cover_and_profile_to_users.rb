class AddCoverAndProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cover_photo_id, :integer, index: true
    add_column :users, :profile_photo_id, :integer, index: true
  end
end
