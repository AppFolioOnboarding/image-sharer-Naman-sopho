require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image_record_validation
    image = Image.new(link: 'https://www.appfolio.com/_nuxt/img/markets-residential@2x_1080px-min.ae96531.png')
    assert image.valid?
  end

  def test_image_record_validation__no_input
    image = Image.new(link: '')
    assert_not image.valid?
  end

  def test_image_record_validation__invalid_input
    image = Image.new(link: 'random')
    assert_not image.valid?
  end
end
