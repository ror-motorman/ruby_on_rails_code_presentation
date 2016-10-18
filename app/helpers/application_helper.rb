module ApplicationHelper
  def time_format(time)
    l(time, format: :datetime)
  end
end
