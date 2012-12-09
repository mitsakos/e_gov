require 'test_helper'

class EventsCellTest < Cell::TestCase
  test "index" do
    invoke :index
    assert_select "p"
  end
  

end
