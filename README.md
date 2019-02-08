## Slack Archivist

A Slack integration to automatically tidy up your stale channels

### Why bother to achive channels? Aren't they free? #ChannelsAreFree

It's fine to make new channels whenever you want. But at some point, the discussion in a channel might reach a natural conclusion -- especially for time-bound situations like a specific project, initiative, or company event (I'm looking at you #company-picnic-2015...).

Having a bunch of inactive channels clutters up the Channel search list in Slack. If you're looking for a place to have a discussion or ask a question, you don't want to have to wade through 50+ zombie channels to find the right one.

While Slack is a great place for quick, real-time collaboration, it is not an appropriate place to store things long term. Use Slack for what it's made for (chat and emojis), not as a catch-all dumping ground for bug reports, project tasks, historical documents, or other important discussions and decisions.

### How it works

Archivist periodically checks every public channel to find the most recent message. If the most recent message in a channel is more than six months old, a warning message is posted in the channel to announce that it is slated to be archived.

Anyone in the channel can "bump" the timer by posting anything in the channel.

After a one-week grace period, if no new messages have been posted, the channel will be archived.

Messages in archived channels are saved and still show up in search results. And if you find that you want the channel to be restored, you can easily un-archive it and pretend like nothing happened.
