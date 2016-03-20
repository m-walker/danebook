require 'rails_helper'

describe Photo do

  it { is_expected.to have_attached_file(:photo) }

  it { is_expected.to validate_attachment_content_type(:photo).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml') }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_one(:cover_photo).dependent(:nullify) }
  it { is_expected.to have_one(:profile_photo).dependent(:nullify) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
end
