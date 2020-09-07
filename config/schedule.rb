# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "../logs/mailer.log"

every 1.minute do
  rake "hacker_news"
end

# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
