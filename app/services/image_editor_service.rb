require 'mini_magick'

class ImageEditorService
  def self.add_text(image_path:, text:, output_path:)
    image = MiniMagick::Image.open(image_path)

    image.draw("text 0,10 '#{text}'")
    image.gravity("South")
    image.pointsize("32")
    image.fill("black")
    image.write(output_path)
  end
end
