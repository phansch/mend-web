# frozen_string_literal: true

require 'test_helper'
require 'event_consumer'

class EventConsumerTest < Minitest::Test
  def test_pull_request_opened
    event = 'pull_request'
    data = { 'action' => 'opened' }.to_json

    consumer = EventConsumer.new(event, data)
    mock = Minitest::Mock.new
    mock.expect(:push, true) do |a|
      a[:jid].is_a?(String) &&
        a[:queue] == 'default' &&
        a[:jobtype] == 'pull_request' &&
        a[:args] == [data]
    end
    Faktory::Client.stub(:new, mock) do
      consumer.eat
    end

    assert_equal({ 'action' => 'opened' }, consumer.parsed_data)
    assert_mock mock
  end
end
