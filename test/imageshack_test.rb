require 'test_helper'
require "imageshack"

class ImageShackUser
  extend ImageShack
  
  attr_accessor :photo
  
  def [](attr_name)
    self.photo
  end
  
  def []=(attr_name, value)
    self.photo = value
  end
  
  def photo_changed?
    true
  end
  
  def self.before_validation(method)
  end
  
  upload_image_to_imageshack :photo
end

class ImageshackTest < ActiveSupport::TestCase

  test "uploading an image to imageshack" do
    result = mock("result", :body => IO.read(File.dirname(__FILE__) + "/fixtures/image_shack.xml"))
    Net::HTTP.any_instance.stubs(:start).returns(result)
    
    user = ImageShackUser.new
    user.photo = Tempfile.new("tempfile.jpg")
    user.check_if_an_imageshack_field_has_changed
    
    assert_equal "http://img196.imageshack.us/img196/503/ixia.gif", user.photo
  end

end
