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
      post images_path, params: { image: { link: image_url} }
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

  def test_create__with_tags
    image_url = 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png'
    tags_list = %w[tag1 tag2]
    tags_list_input = 'tag1,tag2'

    assert_difference 'Image.count' do
      post images_path, params: { image: { link: image_url, tag_list: tags_list_input } }
      assert_equal tags_list, Image.last.tag_list
      assert_redirected_to image_path(Image.last)
    end
  end

  def test_create__invalid_tag_just_space
    image_url = 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png'
    tags_list = []
    tags_list_input = ' '

    assert_difference 'Image.count' do
      post images_path, params: { image: { link: image_url, tag_list: tags_list_input } }
      assert_equal tags_list, Image.last.tag_list
      assert_redirected_to image_path(Image.last)
    end
  end

  def test_create__tags_with_space
    image_url = 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png'
    tags_list = %w[tag1 tag2 tag3]
    tags_list_input = 'tag1, tag2,tag3'

    assert_difference 'Image.count' do
      post images_path, params: { image: { link: image_url, tag_list: tags_list_input } }
      assert_equal tags_list, Image.last.tag_list
      assert_redirected_to image_path(Image.last)
    end
  end

  def test_show
    image_url = 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png'
    image = Image.create(link: image_url)

    get images_path(Image.last.id)

    assert_select 'img' do |img|
      assert_equal image.link, img[0][:src]
    end
  end

  def test_show__with_tags
    image_url = 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png'
    tags_list = %w[tag1 tag2]
    image = Image.create(link: image_url)
    image.tag_list.add(tags_list)
    image.save

    get images_path(Image.last.id)

    assert_select 'span', count: 2
    assert_select 'span', text: tags_list[0]
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
