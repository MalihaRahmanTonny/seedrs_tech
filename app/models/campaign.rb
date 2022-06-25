class Campaign < ApplicationRecord
  has_many :investments, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates_presence_of :percentage_raised,
                        :target_amount,
                        :sector,
                        :country,
                        :investment_multiple
  validates :image, attached: true, content_type: %w[image/jpeg image/png]

  def calculate_percentage_raised
    total_investment = investments.map(&:amount).sum

    ((total_investment * 100) / target_amount).round(2)
  end

  def investors_count
    investments.size
  end
end
