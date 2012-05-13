require "spec_helper"

describe Kanji::Image::Base do
  let(:image_path) { "./spec/fixtures/images/samurai_kanji.png" }
  let(:samurai_poor_quality) { "./spec/fixtures/images/samurai_kanji_quality_10.png" }
  let(:small_image) { "./spec/fixtures/images/8_pixels.png" }

  def image_content(image = image_path)
    ChunkyPNG::Image.from_file(image)
  end

  describe "loading a image" do

  end

  describe "#get_pixel" do
    it "should get the given image" do
      image = Kanji::Image::Base.new(image_path)
      image.get_pixels(0.1).should == image_content(samurai_poor_quality)
    end
  end

  describe "#matrix_dimensions" do
    it "should return an array with dimensions according to quality" do
      image = Kanji::Image::Base.new(image_path)
      image.stub_chain(:resource, :dimension, :height).and_return(50)
      image.stub_chain(:resource, :dimension, :width).and_return(100)

      image.matrix_dimensions(0.1).should == [10, 5]
    end
  end

  describe "#prepare_for_neurons" do
    it "returns pixel values" do
      image = Kanji::Image::Base.new(small_image)
      image.prepare_for_neurons.should == [1, 0, 1, 1, 0, 1, 1, 0]
    end
  end
end
