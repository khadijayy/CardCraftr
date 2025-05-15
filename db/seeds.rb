categories = ["birthday", "eid", "graduation", "party"]

categories.each do |cat_name|
  category = Category.find_or_create_by(name: cat_name)

  # Folder where images are stored: tmp/images/birthday/, etc.
  image_folder = Rails.root.join("tmp/images", cat_name)

  Dir.glob("#{image_folder}/*.{jpg,jpeg,png}").each do |filepath|
    filename = File.basename(filepath)
    name = File.basename(filename, ".*")  # e.g., "card1" from "card1.jpg"

    # Create template record if not already present
    template = category.templates.find_or_initialize_by(name: name)

    # Save the template first (needed for Active Storage associations)
    template.save! unless template.persisted?

    # Attach image only if not already attached
    unless template.image.attached?
      content_type = case File.extname(filename).downcase
                     when ".jpg", ".jpeg" then "image/jpeg"
                     when ".png" then "image/png"
                     else "application/octet-stream"
                     end

      template.image.attach(
        io: File.open(filepath),
        filename: filename,
        content_type: content_type
      )

      puts "Attached: #{filename} → #{cat_name}"
    else
      puts "Skipped (already attached): #{filename}"
    end
  end
end

puts "Seeding complete."
