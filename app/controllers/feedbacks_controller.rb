class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.create(feedback_params)
    render :new unless @feedback.valid?
  end

  private

  def feedback_params
    params.require(:feedback).permit(:full_name, :age, :interview_date, :document)
  end
end
