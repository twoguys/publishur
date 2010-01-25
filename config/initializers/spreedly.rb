RSpreedly::Config.setup do |config|
  config.api_key        = ENV['SPREEDLY_API_KEY']   || '28358b0fcd7f95a20aabb1b991660c370f9f03a6'
  config.site_name      = ENV['SPREEDLY_SITE_NAME'] || 'mwhuss-test'
end