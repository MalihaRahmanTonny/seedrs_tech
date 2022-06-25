FactoryBot.define do
  factory(:campaign) do
    sequence(:name) { |n| "Campaign_#{n}"}
    percentage_raised { 5.0 }
    target_amount { 9.94 }
    sector { 'Dhaka' }
    country { 'BD' }
    investment_multiple { 4.97 }
    image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/test.png") }
  end
end