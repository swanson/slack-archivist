class Archivist
  WARNING = <<~HEREDOC
    :wave: Hello, very quiet channel. It looks like there has been no discussion in this channel for at least six months so it is scheduled to be *Archived*. :recycle:

    Archiving a channel removes it from the list of active channels. But don't worry, all of the messages are saved and searchable! :floppy_disk: :mag:

    Keeping Slack tidy makes it easier for people to find relevant discussions happening in active channels and is a nice reminder that Slack is not a place for long-term storage of project assets. :file_cabinet: :fire:

    I'm just a dumb :robot_face:, so if you want to keep this channel open, post ANYTHING in this channel in the next week and I'll reset the timer.
  HEREDOC

  def initialize(client, options = {})
    @client = client
    @bot_username = options[:username]
  end

  def run!(dry_run = true)
    all_channels.each do |channel|
      puts "\n\n#" + channel.name
      msg = most_recent_message_in(channel.id)
      channel_created = time_from_ts(channel.created)

      if msg.nil? # No message ever posted...
        if stale?(channel_created)
          puts "Stale channel (no messages) detected."
          puts "Post the warning message!"
          post_warning!(channel.id) unless dry_run
        end

        next
      end

      last_msg_at = time_from_ts(msg.ts)
      puts "Last message: %s" % last_msg_at
      puts "Channel created: %s" % channel_created

      if from_archivist?(msg) && warning_period_expired?(last_msg_at)
        puts "Archive channel!"
        archive_channel!(channel.id) unless dry_run
        next
      end

      if stale?(last_msg_at)
        puts "Stale channel detected."
        puts "Post the warning message!"
        post_warning!(channel.id) unless dry_run
      end

      sleep(1)
    end
  end

  private

  def all_channels
    @all_channels ||= @client.channels_list(exclude_archived: true).channels.sort_by{|c| c.created}
  end

  def most_recent_message_in(channel_id)
    @client.channels_history(channel: channel_id, count: 100)
      .messages
      .find{|m| !join_or_leave?(m) }
  end

  def join_or_leave?(msg)
    [
      "channel_join",
      "channel_leave"
    ].include? msg.subtype
  end

  def from_archivist?(msg)
    msg.subtype == "bot_message" && msg.username == @bot_username
  end

  def stale?(last_msg)
    last_msg < 6.months.ago
  end

  def warning_period_expired?(last_msg)
    last_msg < 1.week.ago
  end

  def time_from_ts(ts)
    Time.at(ts.to_i)
  end

  def post_warning!(channel_id)
    @client.chat_postMessage(
      channel: channel_id,
      text: WARNING,
      username: @bot_username
    )
  end

  def archive_channel!(channel_id)
    @client.channels_archive({
      channel: channel_id
    })
  end
end
