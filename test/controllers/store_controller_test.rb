require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
	assert_response :success
    assert_select '#colums #side　a', minimum: 4
    assert_select '#main .entry', 3
    assert_select 'h2', 'Programming Ruby 1.9'
	assert_select '.price', /\Z[,\d]+\.\d\d/
  end
end
