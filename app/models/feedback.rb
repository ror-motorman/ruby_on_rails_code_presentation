class Feedback < ActiveRecord::Base
  # available characters: ' - .
  ONLY_LETTERS_WITH_AVAILABLE_CHARACTERS = /\A^[\s\p{L}'-.]+$\z/

  validates_presence_of :full_name, :age, :interview_date
  validates :full_name, format: { with: ONLY_LETTERS_WITH_AVAILABLE_CHARACTERS, message: :must_contain_only_letters }
  validates :age, inclusion: { in: 17..65, message: :should_be_between_17_to_65 }
  validate :validate_full_name_should_consist_of_two_words, if: :full_name?
  validate :validate_interview_date_must_be_in_future, if: :interview_date?

  mount_uploader :document, DocumentUploader

  def full_name=(value)
    super(value.split.map(&:capitalize).join(' '))
  end

  private

  def validate_full_name_should_consist_of_two_words
    size = full_name.split.size
    errors.add(:full_name, :should_consist_of_two_words) if size != 2
  end

  def validate_interview_date_must_be_in_future
    return if interview_date > Time.now
    errors.add(:interview_date, :must_be_in_future)
  end
end
