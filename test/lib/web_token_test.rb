# frozen_string_literal: true

require 'test_helper'

class WebTokenTest < ActiveSupport::TestCase
  def test_gen
    test_pem_path = file_fixture('sample.pem')
    jwt = WebToken.new(test_pem_path).gen(issue_time: 0)
    expected = <<~HEREDOC
      eyJhbGciOiJSUzI1NiJ9.eyJpYXQiOjAsImV4cCI6NjAwLCJpc3MiOiIxOTM0MiJ9.cum6FDnWaWrRB6KW0LuwhdlZZbTEnP67sdFs1U7LsBvGyMDdFpjWzEZSMAKpDCVvLHlPHC-5fHWn-erGw--CdALCvyLlth9v74l4LOAmaomXmf6M1jKtoh17wSqsYXzQxQe3zjbG41jh9SfUI-m4blAeaBNTaa8tlBscl1mXlgjIE8G71fA1QbMmOPYWFEiCBxjQjq1J-u5zP6j-NekCbUukorUwsUagGU84K60MITpzZqVnglYyL1A83gsnV0T6qA4Jh5d65InGcWTbNNMVwbGD5Qyn_HYrx-0VbUTl8jqRuqYwm7ZyVYYZHtP-sk555IjVBMCG2Qe9B32Y_wC1EA
    HEREDOC
    assert jwt.include?(expected.strip)
  end
end
