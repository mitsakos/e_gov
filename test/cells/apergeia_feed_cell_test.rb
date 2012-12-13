require 'test_helper'

class ApergeiaFeedCellTest < Cell::TestCase
  test "index" do
    invoke :index
    assert_select "p"
  end
  

end
