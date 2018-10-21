# frozen_string_literal: true

require 'faktory'

# Handles received events from GitHub
#
# Accepted events are pushed onto a Faktory instance
# where they are then consumed by a Rust worker.
# The Rust worker will deal with all the GitHub stuff.
#
# This is probably a good place to give an overview over the infrastructure:
#
# | Component         | Role                                      |
# |-------------------|-------------------------------------------|
# | mend-web (Rails)  | User auth, User interface, event consumer |
# | mend-rs (Rust)    | parses diffs, runs clippy, posts comments |
# | Faktory instance  | Runs the mend-rs stuff from above         |
class EventConsumer
  attr_reader :event, :parsed_data, :data

  def initialize(event, data)
    @event = event
    @data = data
    @parsed_data = JSON.parse(data)
  end

  # 🤖💢🤖💢🤖💢 NOM NOM NOM FEED ME EVENTS!1!!1! 🤖💢🤖💢🤖💢
  def eat
    case @event
    when 'pull_request'
      if parsed_data.fetch('action') == 'opened'
        faktory.push(jid: SecureRandom.hex(12), queue: 'default', jobtype: @event, args: [data])
      end
    end
  end

  def faktory
    @faktory ||= Faktory::Client.new(url: ENV.fetch('FAKTORY_URL'))
  end
end
