require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test '#time_format returns time in datetime format' do
    time = '01.01.01 00:00'
    travel_to time do
      assert_equal time, time_format(Time.now)
    end
  end
end
