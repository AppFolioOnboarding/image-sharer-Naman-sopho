require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  def test_home
    get root_url
    assert_response :success
    assert_select 'h6', text: 'Hello World!!'
  end
end
