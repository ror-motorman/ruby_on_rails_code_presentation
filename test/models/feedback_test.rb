require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  test 'persists' do
    assert_difference 'Feedback.count' do
      Feedback.create(
        full_name: 'Test Name',
        age: 20,
        interview_date: Time.now + 1.day,
        document: File.open(Rails.root.join('test/fixtures/files/test.txt'))
      )
    end
  end

  test 'validates presence' do
    assert_no_difference 'Feedback.count' do
      invalid_feedback = Feedback.create

      assert_includes invalid_feedback.errors.messages[:full_name], "can't be blank"
      assert_includes invalid_feedback.errors.messages[:age], "can't be blank"
      assert_includes invalid_feedback.errors.messages[:interview_date], "can't be blank"
    end
  end

  test 'validates #age should be between 17 to 65' do
    [16, 66].each do |invalid_age|
      invalid_feedback = Feedback.create(
        full_name: 'Test Name',
        age: invalid_age,
        interview_date: Time.now + 1.day
      )

      assert_equal(
        ['should be between 17 to 65'],
        invalid_feedback.errors.messages[:age]
      )
    end
  end

  test 'validates #full_name should consist of two words' do
    invalid_feedback = Feedback.create(
      full_name: 'Test',
      age: 30,
      interview_date: Time.now + 1.day
    )

    assert_equal(
      ['should consist of two words'],
      invalid_feedback.errors.messages[:full_name]
    )
  end

  test 'validates #full_name must contain only letters or available characters: \' - .' do
    invalid_feedback = Feedback.create(
      full_name: 'Test 33',
      age: 30,
      interview_date: Time.now + 1.day
    )

    assert_equal(
      ["must contain only letters or available characters: ' - ."],
      invalid_feedback.errors.messages[:full_name]
    )
  end

  test 'validates #interview_date must be in future' do
    invalid_feedback = Feedback.create(
      full_name: 'Test Name',
      age: 30,
      interview_date: Time.now - 1.day
    )

    assert_equal(
      ['must be in future'],
      invalid_feedback.errors.messages[:interview_date]
    )
  end

  test 'returns capitalized #full_name' do
    feedback = Feedback.new(
      full_name: 'test name',
      age: 30,
      interview_date: Time.now + 1.day
    )

    assert_equal 'Test Name', feedback.full_name
  end

  test 'uploads document' do
    feedback = Feedback.create(
      full_name: 'Test Name',
      age: 20,
      interview_date: Time.now + 1.day,
      document: File.open(Rails.root.join('test/fixtures/files/test.txt'))
    )

    assert_equal "/documents/#{feedback.id}_Test%20Name/test.txt", feedback.document.url
    assert_equal 'test.txt', feedback.document.identifier
  end

  test 'validates #document should not upload .png file' do
    invalid_feedback = Feedback.create(
      full_name: 'Test Name',
      age: 20,
      interview_date: Time.now + 1.day,
      document: File.open(
        Rails.root.join('test/fixtures/files/test.png')
      )
    )

    assert_equal(
      ['You are not allowed to upload "png" files, allowed types: doc, docx, pdf, txt'],
      invalid_feedback.errors.messages[:document]
    )
  end
end
