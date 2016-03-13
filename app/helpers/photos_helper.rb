module PhotosHelper

  def cover_photo(user)
    if user.cover_photo
      html = image_tag user.cover_photo.photo.url(:cover), id: "cover-photo", class: "img-responsive", alt: "User's cover photo"
    else
      html = '<img src="http://placehold.it/1138x400" id="cover-photo" class="img-responsive", alt: "Default cover photo">'
    end

    html.html_safe
  end

  def profile_photo(user)
    if user.profile_photo
      html = image_tag user.profile_photo.photo.url(:preview), id: "profile-photo", class: "img-responsive img-thumbnail"
    else
      html = '<img src="http://placehold.it/160x160" id="profile-photo" class="img-responsive img-thumbnail", alt: "Default profile photo">'
    end

    html.html_safe
  end
end
