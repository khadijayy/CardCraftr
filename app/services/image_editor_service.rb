
class ImageEditorService
  def self.add_text(image_path:, output_path:, text:)
    image = MiniMagick::Image.open(image_path)

    image.combine_options do |c|
      c.gravity "NorthWest" # top-left corner
      c.pointsize "24"
      c.fill "black"
      c.draw "text 50,100 '#{text[:name]}'"
      c.draw "text 50,150 '#{text[:date]}'"
      c.draw "text 50,200 '#{text[:message]}'"
    end

    image.write output_path
  end
end
