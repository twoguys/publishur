# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_active(display, url = nil, condition = nil, *other_css_classes)
    unless condition == true or condition == false
      condition = condition == display
    end
    condition ? link_to(display, url, :class => "active #{other_css_classes}") : link_to(display, url)
  end
end
