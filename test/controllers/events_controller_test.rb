# frozen_string_literal: true

require 'test_helper'
require 'helpers/env_helper'
require 'event_consumer'
require 'minitest/mock'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test 'should return :unauthorized on invalid signature' do
    EnvHelper.with_env('WEBHOOK_SECRET', 'mysecret') do
      post event_receiver_url
      assert_response :unauthorized
    end
  end

  test 'should return :accepted on valid signature' do
    EnvHelper.with_env('WEBHOOK_SECRET', 'mysecret') do
      post event_receiver_url, headers: {
        'HTTP_X_HUB_SIGNATURE' => 'sha1=ff4779c255664456d368f939de20a098042e83a8',
        'RAW_POST_DATA' => '[]'
      }
      assert_response :accepted
    end
  end

  test 'should delegate to EventConsumer' do
    mock = Minitest::Mock.new
    mock.expect(:eat, nil)

    EventConsumer.stub(:new, mock) do
      EnvHelper.with_env('WEBHOOK_SECRET', 'mysecret') do
        post event_receiver_url, headers: {
          'HTTP_X_HUB_SIGNATURE' => 'sha1=33f9d709782f62b8b4a0178586c65ab098a39fe2',
          'HTTP_X_GITHUB_EVENT' => 'abc'
        }
      end
    end
    assert_mock mock
  end
end
