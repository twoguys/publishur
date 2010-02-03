class Admin::DashboardController < Admin::BaseController
  def index
    @subscription_chart = GoogleChart::PieChart.new('640x400', "Subscription Types", false) do |pc|
      pc.data "AIM (#{AIM.count})", AIM.count
      pc.data "Jabber (#{JabberMessage.count})", JabberMessage.count
      pc.data "Twitter (#{Tweet.count})", Tweet.count
      pc.data "Email (#{Email.count})", Email.count
      pc.data "HTTP Post (#{PostHook.count})", PostHook.count

      # Pie Chart with no labels
      pc.show_labels = true
    end
  end
end