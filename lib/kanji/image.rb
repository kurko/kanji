require "chunky_png"
require "kanji/image/edge_detection"
require "kanji/image/pixelize"
require "kanji/image/output"

module Kanji::Image
  class Base
    include Kanji::Image::Pixelize
    include Kanji::Image::Output
    include ::ChunkyPNG

    attr_reader :resource

    def initialize(image_path = nil)
      @resource = ChunkyPNG::Image.from_file(image_path)
    end
  end
end
