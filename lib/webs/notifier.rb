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

    def test_event
      webs.event 'test-channel', 'test-event', {message: 'test'}
    end

    def send_chat_message(channel_name, event_name, data_hash={})
      webs.event channel_name, event_name, data_hash
    end

    def notify_chat_closing(channel_name, event_name)
      webs.event channel_name, event_name
    end

  end

end
