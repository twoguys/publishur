require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "message" do
    @expected.subject = 'Notifications#message'
    @expected.body    = read_fixture('message')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_message(@expected.date).encoded
  end

end
