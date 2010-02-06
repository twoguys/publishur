task :cron => :environment do
  #if Time.now.hour == 0 # run at midnight
    puts "---> Sending daily event summary"
    Event.send_summary(Time.now)
  #end
end