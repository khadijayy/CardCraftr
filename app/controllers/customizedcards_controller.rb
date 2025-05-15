class CustomizedCardsController < ApplicationController
  def new
    @template = Template.find(params[:template_id])
  end

  def create
    template = Template.find(params[:template_id])
    name = params[:name]
    date = params[:date]
    message = params[:message]

    input_path = Rails.root.join("tmp", "#{SecureRandom.hex}_input.jpg")
    File.open(input_path, "wb") { |file| file.write(template.image.download) }

    # Output path
    output_path = Rails.root.join("tmp", "custom_#{SecureRandom.hex}.jpg")

    full_text = "#{name}\n#{date}\n#{message}"

    ImageEditorService.add_text(
      image_path: input_path.to_s,
      text: full_text,
      output_path: output_path.to_s,
      options: {
        gravity: "center",
        size: 36,
        color: "white"
      }
    )

    # Save customized card in DB
    card = CustomizedCard.create!(
      name: name,
      date: date,
      message: message,
      card_template: template
    )
    card.final_image.attach(io: File.open(output_path), filename: "custom_card.jpg")

    redirect_to customized_card_path(card)
  end

  def show
    @card = CustomizedCard.find(params[:id])
  end

  def new
  @template = Template.find(params[:template_id])
  @customized_card = CustomizedCard.new
end

def create
  @template = Template.find(params[:template_id])
  @customized_card = @template.customized_cards.build(customized_card_params)
  if @customized_card.save
    redirect_to @customized_card, notice: 'Card created successfully!'
  else
    render :new
  end

end
