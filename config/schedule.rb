set :environment, :development
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "#{path}/log/cron.log"
#
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

# run this task only on servers with the :app role in Capistrano
# see Capistrano roles section below
# every :day, :at => '12:20am', :roles => [:app] do
  # runner "User.send_incomplete_profile_reminders"
# end

every 1.day, :at => '12:30 am' do
  puts "It's working at 12:30 am  !!!"
  rake "send_incomplete_profile_reminders"
  # runner "User.send_incomplete_profile_reminders"
end
