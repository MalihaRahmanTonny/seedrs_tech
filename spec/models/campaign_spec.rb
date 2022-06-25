require 'rails_helper'

RSpec.describe Campaign do
  let!(:campaign) { FactoryBot.create(:campaign) }
  let(:investment) { FactoryBot.create(:investment, amount: 4.97, campaign: campaign) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_presence_of(:percentage_raised) }
    it { is_expected.to validate_presence_of(:target_amount) }
    it { is_expected.to validate_presence_of(:sector) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:investment_multiple) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to have_many(:investments) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe '.calculate_percentage_raised' do
    before { investment }

    it 'calculates the campaign percentage_raised value' do
      expect(campaign.calculate_percentage_raised).to eq(50.0)
    end
  end

  describe '.investors_count' do
    before { investment }

    it 'returns total investors count' do
      expect(campaign.investors_count).to eq(1)
    end
  end
end
