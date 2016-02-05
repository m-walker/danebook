class RemoveFieldsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :dob, :string
    remove_column :users, :gender, :string
    add_index :users, :email
  end
end
