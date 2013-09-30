module Webs
  # Notifiers for different kind of events
  # Having everything in this place we can easily decide where we need to push given inforamtion.
  # So if we later want some live updates on page on user status change, we just push to additional
  # channel here and don't worry about changes anywhere else
  class Notifier

    attr_accessor :webs

    def initialize(webs)
      @webs = webs
    end

    def notify(channel_name, event_name, data_hash={})
      webs.event channel_name, event_name, data_hash
    end

  end

end
