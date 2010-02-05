task :cron => :environment do
  if Time.now.hour == 0 # run at midnight
    Event.send_summary(Time.now)
  end
end