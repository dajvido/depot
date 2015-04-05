require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /^\d[,\d]+\.\d\d zł$/
  end

  test "should display session counter" do
    15.times do
      get :index
    end
    assert_select '.session_counter', 'You have been here 15 times.'
  end
end
