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

Archivist.new(client, {
  username: ENV['BOT_USERNAME']
}).run!(dry_run)
