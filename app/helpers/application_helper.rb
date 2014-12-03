module ApplicationHelper
  def nav_link_to(text, path)
    css_class = 'active' if path[1..-1] == request.path_parameters[:controller]
    content_tag(:li, class: css_class) { link_to text, path }
  end
end
