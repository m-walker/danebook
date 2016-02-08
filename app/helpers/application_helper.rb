module ApplicationHelper

  # Adds error to field with that error on forms
  def field_with_errors(object, field_sym)
    unless object.errors[field_sym].empty?
      content_tag(:div, class: "text-danger") do
        "#{field_sym.to_s.titleize} #{object.errors[field_sym].first}"
      end
    end
  end

  def like_link(resource)
    # TODO: refactor - maybe change up routes
    if resource.is_a? Post
      path = post_like_path(resource)
    else
      path = comment_like_path(resource)
    end

    if resource.liked_by?(current_user.id)
      string = "#{link_to fa_icon('thumbs-up', text: 'Unlike'), path, method: :delete, class: 'post-action'}"
    else
      string = "#{link_to fa_icon('thumbs-up', text: 'Like'), path, method: :post, class: 'post-action'}"
    end

    string.html_safe
  end

end
