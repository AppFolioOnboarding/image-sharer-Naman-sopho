require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  def test_create
    assert_difference 'Feedback.count', 1 do
      post api_feedbacks_path, params: { feedback: { name: 'Test', comment: 'comment' } }
    end
  end

  def test_create__no_input
    assert_difference 'Feedback.count', 0 do
      assert_raises ActiveRecord::RecordInvalid do
        post api_feedbacks_path, params: { feedback: { name: '', comment: '' } }
      end
    end
  end

  def test_create__invalid_input
    assert_difference 'Feedback.count', 0 do
      assert_raises ActiveRecord::RecordInvalid do
        post api_feedbacks_path, params: { feedback: { name: 'Test' } }
      end
    end

    assert_difference 'Feedback.count', 0 do
      assert_raises ActiveRecord::RecordInvalid do
        post api_feedbacks_path, params: { feedback: { comment: 'comment' } }
      end
    end
  end
end
