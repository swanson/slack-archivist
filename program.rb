require 'dotenv'
Dotenv.load

require_relative "./archivist"

Slack.configure do |config|
  config.token = ENV['SLACK_BOT_TOKEN']
end

client = Slack::Web::Client.new

Archivist.new(client).run!
