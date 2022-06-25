# frozen_string_literal: true

image = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/test.png")

(1..20).each do |campaign_number|
  Campaign.create_with(
    image: image,
    percentage_raised: 0.0,
    target_amount: 100,
    sector: 'XX',
    country: 'BD',
    investment_multiple: 4.97
  ).find_or_create_by(name: "Campaign #{campaign_number}")
end
