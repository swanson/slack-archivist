require 'dotenv'
Dotenv.load

require "bundler"
Bundler.require(:default)

require_relative "./archivist"

Slack.configure do |config|
  config.token = ENV['SLACK_TOKEN']
end

client = Slack::Web::Client.new

dry_run = true
if ENV['PRODUCTION'] == true
  dry_run = false
end

puts "Running clean-up for #{Date.today}. Dry run flag: #{dry_run}..."

Archivist.new(client, {
  username: ENV['BOT_USERNAME']
}).run!(dry_run)
