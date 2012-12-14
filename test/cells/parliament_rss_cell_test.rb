require 'test_helper'

class ParliamentRssCellTest < Cell::TestCase
  test "index" do
    invoke :index
    assert_select "p"
  end
  

end
