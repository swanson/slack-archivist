## Slack Archivist

A Slack integration to automatically tidy up your stale channels.

### Why bother to achive channels? Aren't they free? #ChannelsAreFree

It's fine to make new channels whenever you want. But at some point, the discussion in a channel might reach a natural conclusion -- especially for time-bound situations like a specific project or initiative.

Having a bunch of inactive channels clutters up the Channel search list in Slack. If you are looking for a place to have a discussion or ask a question, you don't want to have to wade through 50+ zombie channels to find the right one.

While Slack is a great place for quick, real-time collaboration, it is not an appropriate place to store things long-term. Use Slack for what it's made for (chat and emojis) and not as a catch-all dumping ground for bug reports, project tasks, historical records, or other important discussions and decisions.

### How it works

Archivist checks every public channels to find the time of the most recent message. If the most recent message in a channel is more than six months old, a message is posted in the channel warning the members that it is slated to be archived.

Anyone can reset the timer by posting a message in the channel after the warning message.

After a one-week warning period, if no new messages have been posted, the channel will be archived.
