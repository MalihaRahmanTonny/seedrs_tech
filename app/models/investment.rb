class Investment < ApplicationRecord
  belongs_to :campaign

  validates_presence_of :amount
  validate :investment_multiple, if: :campaign_id?

  after_commit :update_campaign

  private

  def investment_multiple
    return if (amount % campaign.investment_multiple).zero?

    errors.add(:investment_multiple,
               I18n.t(:investment_multiple,
                      scope: %i(activerecord errors messages investment),
                      amount: campaign.investment_multiple))
  end

  def update_campaign
    campaign.update(percentage_raised: campaign.calculate_percentage_raised)
  end
end
