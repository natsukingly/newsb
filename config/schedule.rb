# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
# require File.expand_path(File.dirname(__FILE__) + "/environment")
# Example:
#
set :output, 'log/crontab.log'
#
set :environment, :production
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 8.hours do
  runner 'Schneider.hello'
  runner 'Schneider.auto_post'
end

every 24.hours do
  runner 'Fix.followers_count'
  runner 'Fix.following_count'
end

every 1.day, at: '8:00 pm' do
  runner 'Bot.twitter_business'
end

every 1.day, at: '9:00 pm' do
  runner 'Bot.twitter_business'
end

every 1.day, at: '10:00 pm' do
  runner 'Bot.twitter_business'
end

every 1.day, at: '9:30 am' do
  runner 'Bot.twitter_business'
end

every 1.day, at: '10:30 am' do
  runner 'Bot.twitter_business'
end

every 1.day, at: '11:30 am' do
  runner 'Bot.twitter_business'
end

every 1.day, at: '7:35 am' do
  runner 'Bot.twitter_business'
end