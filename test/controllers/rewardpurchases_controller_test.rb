require 'test_helper'

class RewardpurchasesControllerTest < ActionDispatch::IntegrationTest
  test "should get myrewards" do
    get rewardpurchases_myrewards_url
    assert_response :success
  end

end
