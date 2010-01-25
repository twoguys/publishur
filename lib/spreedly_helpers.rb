module SpreedlyHelpers
  
  def subscriber_account_url(group, opts={})
    url = "https://spreedly.com/#{ENV['SPREEDLY_SITE_NAME']}/subscriber_accounts/#{group.spreedly_token}"
    url << "&redirect_to=#{opts[:redirect_to]}" if opts[:redirect_to]
    url
  end
  
  def spreedly_plan_url(group, plan_id, opts={})
    # opts for email, first_name, last_name, and redirect_to
    "https://spreedly.com/#{ENV['SPREEDLY_SITE_NAME']}/subscribers/#{group.id}/subscribe/#{plan_id}/#{group.to_param}"
  end
  
end