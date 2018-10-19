# frozen_string_literal: true

# Check X-Hub-Signature to confirm that this webhook was generated by GitHub, and not a third party.
#
# The way this works is: We have registered with GitHub a secret, and we have
# stored it locally in WEBHOOK_SECRET.  GitHub will cryptographically sign
# the request payload with this secret. We will do the same, and if the
# results match, then we know that the request is from GitHub (or, at least,
# from someone who knows the secret!) If they don't match, this request is an
# attack, and we should reject it.  The signature comes in with header
# x-hub-signature, and looks like "sha1=123456" We should take the left hand
# side as the signature method, and the right hand side as the HMAC digest
# (the signature) itself.
class SignatureValidator
  def self.validate(their_signature, payload_raw)
    their_signature_header = their_signature || 'sha1='
    method, their_digest = their_signature_header.split('=')
    our_digest = OpenSSL::HMAC.hexdigest(method, ENV.fetch('WEBHOOK_SECRET'), payload_raw)
    their_digest == our_digest
  end
end