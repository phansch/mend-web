# frozen_string_literal: true

require 'openssl'
require 'jwt'

# Generates a JWT to authenticate as GitHub installation
class WebToken
  # Setup the ENV variable via
  #
  # ```shell
  # export GITHUB_PEM=`cat path/to/file.pem`
  # ```
  def initialize
    @private_key = OpenSSL::PKey::RSA.new(ENV.fetch('GITHUB_PEM'))
  end

  def gen(issue_time: Time.now.to_i)
    # Generate the JWT
    payload = {
      # issued at time
      iat: issue_time,
      # JWT expiration time (10 minute maximum)
      exp: issue_time + (10 * 60),
      # GitHub App's identifier
      iss: ENV.fetch('GITHUB_APP_ID')
    }

    JWT.encode(payload, @private_key, 'RS256')
  end
end
