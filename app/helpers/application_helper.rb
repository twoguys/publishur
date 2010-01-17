# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_active(display, url = nil, condition = nil, *other_css_classes)
    unless condition == true or condition == false
      condition = condition == display
    end
    condition ? link_to(display, url, :class => "active #{other_css_classes}") : link_to(display, url)
  end
  
  def print_subscription(sub)
    return "#{sub.contact_info}" if sub.contact_type == "Email"
    return "#{sub.contact_info}" if sub.contact_type == "AIM"
    return "#{sub.contact_info}" if sub.contact_type == "Jabber"
    "#{number_to_phone(sub.contact_info)} (SMS)" if sub.contact_type == "SMS"
  end
end
