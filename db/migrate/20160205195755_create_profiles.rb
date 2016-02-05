class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.date :dob
      t.string :gender
      t.string :college
      t.string :hometown
      t.string :current_city
      t.string :phone
      t.string :words_to_live_by
      t.text :about

      t.timestamps null: false
    end
  end
end
