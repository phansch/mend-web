# frozen_string_literal: true

require 'test_helper'
require 'helpers/env_helper'

class WebTokenTest < ActiveSupport::TestCase
  def test_gen
    test_pem_path = file_fixture('sample.pem')
    jwt = EnvHelper.with_env('GITHUB_APP_ID', '1') do
      EnvHelper.with_env('GITHUB_PEM', File.read(test_pem_path)) do
        WebToken.new.gen(issue_time: 0)
      end
    end
    expected = <<~HEREDOC
      eyJhbGciOiJSUzI1NiJ9.eyJpYXQiOjAsImV4cCI6NjAwLCJpc3MiOiIxIn0.b6jdAZIVuzsn4clUSYGZ_v00opn8llD-2sO3sKgjtx4X7owSAuf4JmuUuecW4KEuN2IpIxjSupP6WDDvnTR0xQRg0aSPc9ruU4j7DM1GttsL6ZS1Q7aDbbVO4t24F8LlsjumSs5Vrl_V6F4SGzwP0lO4c3_Xg9XNFtUdlhxjcOKidEVp50zocgrcR87ByudkBb9XH7BzMhxhQIlGecRIpIG4IZz9w5WfMqaDLmDcrHD2XOVRJi1cRraM4so29nOFeiL-NOpXAqpEh4myTe8hgBrGBWkC5lHN3VUauwg43A60KE5qr_FwSQbnt_Wz3GxJpvaq1KHB2VDL8Q0o6O4OMA
    HEREDOC
    assert jwt.include?(expected.strip)
  end
end
