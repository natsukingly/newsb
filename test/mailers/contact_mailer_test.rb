require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  test "send_when_contacted" do
    mail = ContactMailer.send_when_contacted
    assert_equal "Send when contacted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
