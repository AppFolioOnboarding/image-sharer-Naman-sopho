require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def test_feedback_record_validation
    feedback = Feedback.new(name: 'Test', comment: 'Comment')
    assert feedback.valid?
  end

  def test_feedback_record_validation__no_input
    feedback = Feedback.new(name: '', comment: '')
    assert_not feedback.valid?
  end

  def test_feedback_record_validation__invalid_input
    feedback = Feedback.new(name: 'Test')
    assert_not feedback.valid?

    feedback = Feedback.new(comment: 'comment')
    assert_not feedback.valid?
  end
end
