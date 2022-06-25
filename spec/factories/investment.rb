FactoryBot.define do
  factory(:investment) do
    campaign factory: :campaign
    amount { 4.97 }
  end
end
