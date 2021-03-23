require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    super
    @image_url1 = 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png'
    @image_url2 = 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png'
    @tags_list = %w[tag1 tag2]
    @tags_list_input = 'tag1,tag2'
  end

  def test_new
    get new_image_path
    assert_response :success

    assert_select 'input', id: 'image_link'
    assert_select 'input', name: 'commit'
  end

  def test_create
    assert_difference 'Image.count' do
      post images_path, params: { image: { link: @image_url1 } }
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
    assert_difference 'Image.count' do
      post images_path, params: { image: { link: @image_url1, tag_list: @tags_list_input } }
      assert_equal @tags_list, Image.last.tag_list
      assert_redirected_to image_path(Image.last)
    end
  end

  def test_create__invalid_tag_just_space
    tags_list = []
    tags_list_input = ' '

    assert_difference 'Image.count' do
      post images_path, params: { image: { link: @image_url1, tag_list: tags_list_input } }
      assert_equal tags_list, Image.last.tag_list
      assert_redirected_to image_path(Image.last)
    end
  end

  def test_create__tags_with_space
    tags_list = %w[tag1 tag2 tag3]
    tags_list_input = 'tag1, tag2,tag3'

    assert_difference 'Image.count' do
      post images_path, params: { image: { link: @image_url1, tag_list: tags_list_input } }
      assert_equal tags_list, Image.last.tag_list
      assert_redirected_to image_path(Image.last)
    end
  end

  def test_show
    image = Image.create(link: @image_url1)

    get images_path(Image.last.id)

    assert_select 'img' do |img|
      assert_equal image.link, img[0][:src]
    end
  end

  def test_show__with_tags
    Image.create(link: @image_url1, tag_list: @tags_list)

    get images_path(Image.last.id)

    assert_select 'span', count: 2
    assert_select 'span', text: @tags_list[0]
    assert_select 'a', href: "/images?tag=#{@tags_list[0]}"
  end

  def test_index
    Image.create(link: @image_url1)
    image1 = Image.create(link: @image_url2)

    get root_path

    assert_response :success
    assert_select 'img', count: 2 do |image|
      assert_equal image1.link, image[0][:src]
    end
    assert_select 'h3', text: 'Image Sharer'
    assert_select 'a[href=?]', '/images/new'
  end

  def test_index__with_tags
    Image.create(link: @image_url1, tag_list: %w[tag01 tag02])
    image1 = Image.create(link: @image_url2,
                          tag_list: @tags_list)

    get '/images?tag=tag1'

    assert_response :success
    assert_select 'img', count: 1 do |image|
      assert_equal image1.link, image[0][:src]
    end
    assert_select 'h3', text: 'Image Sharer'
    assert_select 'a[href=?]', '/images/new'
  end

  def test_index__non_existent_tag
    Image.create(link: @image_url1, tag_list: %w[tag01 tag02])
    Image.create(link: @image_url2, tag_list: @tags_list)

    get '/images?tag=random_tag'

    assert_response :success
    assert_select 'img', count: 0
    assert_select 'h3', text: 'Image Sharer'
    assert_select 'a[href=?]', '/images/new'
  end

  def test_destroy
    image = Image.create(link: @image_url1, tag_list: %w[tag01 tag02])

    assert_difference 'Image.count', -1 do
      delete image_path(image.id)
      assert_redirected_to images_path
    end
  end

  def test_destroy__invalid_id
    assert_raises ActiveRecord::RecordNotFound do
      delete image_path(-1)
    end
  end
end
