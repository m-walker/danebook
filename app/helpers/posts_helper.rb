module PostsHelper

  def user_photo_column_width(photo_size)
    photo_size == 'medium' ? "col-sm-3" : "col-sm-2"
  end

  def user_name_column_width(photo_size)
    photo_size == 'medium' ? "col-sm-9" : "col-sm-10"
  end
end
