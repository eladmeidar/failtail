require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "invitation" do
    @expected.subject = 'Notifier#invitation'
    @expected.body    = read_fixture('invitation')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_invitation(@expected.date).encoded
  end

end
