class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  # TODO: limit to one like per user per resource
end
