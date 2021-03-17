require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path
    assert_response :success

    # check form is correctly displayed
    assert_select 'input', id: 'image_link'
    assert_select 'input', name: 'commit'
  end

  def test_create
    image_url = 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png'
    assert_difference 'Image.count' do
      post images_path, params: { image: { link: image_url } }
      assert_redirected_to image_path(Image.last)
    end
  end

  def test_create__no_input
    assert_difference 'Image.count', 0 do
      post images_path, params: { image: { link: '' } }
      assert_response :success
      assert_select 'div', id: 'error_message', text: 'Please enter valid URL.'
    end
  end

  def test_create__invalid_input
    assert_difference 'Image.count', 0 do
      post images_path, params: { image: { link: 'random string' } }
      assert_response :success
      assert_select 'div', id: 'error_message', text: 'Please enter valid URL.'
    end
  end

  def test_show
    image_url = 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png'
    assert_difference 'Image.count' do
      post images_path, params: { image: { link: image_url } }
      assert_equal image_url, Image.last.link
    end
  end

  def test_index
    Image.create(link: 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png')
    image1 = Image.create(link: 'https://www.appfolio.com/_nuxt/img/product-communication-and-service_480px-min.4111e75.png')

    get root_path

    assert_response :success
    assert_select 'img', count: 2 do |image|
      assert_equal image1.link, image[0][:src]
    end
    assert_select 'h3', text: 'Image Sharer'
    assert_select 'a[href=?]', '/images/new'
  end
end
