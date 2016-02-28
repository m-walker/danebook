require 'rails_helper'

describe Like do

  context 'associations' do
    it{ is_expected.to belong_to(:user) }
    it{ is_expected.to belong_to(:likeable) }
  end

  context 'validations' do
    # TODO: this doesn't work - maybe because validation is on the associated resource? Switch to factory and old-fashioned model spec.

    # Trying to test this:
    # validates_uniqueness_of :user_id, :scope => [:likeable_id, :likeable_type]

    # it do
    #   is_expected.to validate_uniqueness_of(:user_id).
    #     scoped_to([:likeable_id, :likeable_type])
    # end
  end
end