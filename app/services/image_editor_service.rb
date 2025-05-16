class ImageEditorService
  def self.add_text(image_path:, text:, output_path:)
    image = MiniMagick::Image.open(image_path)

    image.combine_options do |c|
      c.gravity 'South'
      c.pointsize '32'
      c.fill 'black'
      c.draw "text 0,10 '#{text}'"
    end

    image.write(output_path)
  end
end
