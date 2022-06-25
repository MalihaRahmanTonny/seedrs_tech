require 'rails_helper'

RSpec.describe Investment do
  let!(:campaign) { FactoryBot.create(:campaign) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }

    context 'invalid investment amount' do
      let!(:investment) { FactoryBot.build(:investment, amount: 1.2, campaign: campaign) }

      it 'raises validation error for invalid investment amount' do
        expect(investment.valid?).to eq(false)
        expect(investment.errors.messages[:investment_multiple])
          .to eq([I18n.t('activerecord.errors.messages.investment.investment_multiple',
                         amount: campaign.investment_multiple)])
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:campaign) }
  end

  describe '.update_campaign' do
    let!(:investment) { FactoryBot.create(:investment, amount: 4.97, campaign: campaign) }

    it 'updated the campaign percentage_raised value' do
      expect(campaign.reload.percentage_raised).to eq(50.0)
    end
  end

end
