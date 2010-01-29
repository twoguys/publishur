class Admin::BaseController < ApplicationController
  before_filter :require_admin
  before_filter { |c| c.nav :admin }
  
  def index
    @subscription_chart = GoogleChart::PieChart.new('320x200', "Subscription Types", false) do |pc|
      pc.data "AIM", AIM.count
      pc.data "Jabber", JabberMessage.count
      pc.data "Twitter", Tweet.count
      pc.data "Email", Email.count
      pc.data "HTTP Post", PostHook.count

      # Pie Chart with no labels
      pc.show_labels = true
    end
  end
  
end