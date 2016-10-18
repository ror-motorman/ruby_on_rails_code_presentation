require 'test_helper'

class FeedbacksControllerTest < ActionController::TestCase
  test 'shows new page' do
    get :new
    assert_response :success
    assert_template :new
  end

  test 'creates feedback' do
    assert_difference 'Feedback.count' do
      post :create, feedback: {
        full_name: 'Test Name',
        age: 20,
        interview_date: Time.now + 1.day
      }
    end
    assert_response :success
    assert_template :create
  end

  test 'does not create feedback' do
    assert_no_difference 'Feedback.count' do
      post :create, feedback: {
        full_name: '',
        age: 20,
        interview_date: Time.now + 1.day
      }
    end
    assert_response :success
    assert_template :new
  end
end
