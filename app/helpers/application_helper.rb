# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include SpreedlyHelpers
  
  def link_to_active(display, url = nil, condition = nil, *other_css_classes)
    unless condition == true or condition == false
      condition = condition == display
    end
    condition ? link_to(display, url, :class => "active #{other_css_classes}") : link_to(display, url)
  end
  
  def print_subscription(sub)
    return "#{sub.contact_info}"                  if sub.is_a?(Email)
    return "#{sub.contact_info}"                  if sub.is_a?(AIM)
    return "#{sub.contact_info}"                  if sub.is_a?(JabberMessage)
    "#{number_to_phone(sub.contact_info)} (SMS)"  if sub.is_a?(SMS)
    return "#{sub.contact_info}"                  if sub.is_a?(Tweet)
  end
end
