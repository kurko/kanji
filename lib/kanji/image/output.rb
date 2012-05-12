module Kanji::Image
  module Output
    def get_pixels(quality = 0.1)
      image = resource.grayscale

      # generates sample according to quality
      white_canvas = ChunkyPNG::Image.new(
        matrix_dimensions(quality).first,
        matrix_dimensions(quality).last
      )

      sample = generate_sample(white_canvas)
      sample.save("tmp/output_get_pixel.png")
      sample
    end

    def generate_sample(sample)
      width_relation = resource.dimension.width / sample.dimension.width
      height_relation = resource.dimension.height / sample.dimension.height
      (0..sample.dimension.width-1).each do |x|
        (0..sample.dimension.height-1).each do |y|
          resource_x = ((x+1) * width_relation - (width_relation/2)).floor
          resource_y = ((y+1) * height_relation - (height_relation/2)).floor

          sample[x,y] = resource[resource_x, resource_y]
        end
      end
      sample
    end

    def matrix_dimensions(quality)
      [ (resource.dimension.width*quality).floor,
        (resource.dimension.height*quality).floor ]
    end
  end
end
