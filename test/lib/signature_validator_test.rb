# frozen_string_literal: true

require 'test_helper'
require 'helpers/env_helper'
require 'signature_validator'

class SignatureValidatorTest < Minitest::Test
  def test_validate_valid_signature
    EnvHelper.with_env('WEBHOOK_SECRET', 'mysecret') do
      some_payload = 'aoredinoaedi'
      assert SignatureValidator.validate(
        'sha1=e7d93b26433b85f2cf111701c6f06ae68c25b888',
        some_payload
      )
    end
  end

  def test_validate_invalid_signature
    EnvHelper.with_env('WEBHOOK_SECRET', 'mysecret') do
      some_payload = 'aoredinoaedi'
      refute SignatureValidator.validate('sha1=invalidsha', some_payload)
    end
  end
end
