class Photo < ActiveRecord::Base
  belongs_to :user

  # http://www.imagemagick.org/script/command-line-processing.php#geometry
  # timeline preserves width
  has_attached_file :photo, styles: { timeline: "600>", thumb: "100x100#", profile_thumb: "80x80#", preview: "200x200#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
