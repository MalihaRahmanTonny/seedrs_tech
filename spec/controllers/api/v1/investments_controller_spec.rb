# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::InvestmentsController do
  let(:campaign) { FactoryBot.create(:campaign) }
  let!(:investment_1) { FactoryBot.create(:investment, campaign: campaign) }
  let!(:investment_2) { FactoryBot.create(:investment) }

  let(:investment_1_response) do
    {
      'id' => investment_1.id,
      'amount' => investment_1.amount,
      'campaign_id' => campaign.id,
      'created_at' => investment_1.created_at.iso8601(3),
      'updated_at' => investment_1.updated_at.iso8601(3),
    }
  end

  let(:investment_2_response) do
    {
      'id' => investment_2.id,
      'amount' => investment_2.amount,
      'campaign_id' => investment_2.campaign.id,
      'created_at' => investment_2.created_at.iso8601(3),
      'updated_at' => investment_2.updated_at.iso8601(3),
    }
  end

  describe 'GET #index' do
    let(:expected_response_1) { [investment_1_response, investment_2_response] }
    let(:expected_response_2) { [investment_1_response] }

    it 'lists all the investments' do
      get :index

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body).to match_array(expected_response_1)
    end

    it 'lists campaign based investments' do
      get :index, params: { campaign_id: campaign.id }

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body).to match_array(expected_response_2)
    end
  end

  describe 'GET #show' do
    let(:investment_1_response) do
      {
        'id' => investment_1.id,
        'amount' => investment_1.amount,
        'campaign_id' => campaign.id,
        'created_at' => investment_1.created_at.iso8601(3),
        'updated_at' => investment_1.updated_at.iso8601(3),
        'campaign' => {
          'id' => campaign.id,
          'name' => campaign.name,
          'percentage_raised' => campaign.percentage_raised,
          'target_amount' => campaign.target_amount,
          'sector' => campaign.sector,
          'country' => campaign.country,
          'investment_multiple' => campaign.investment_multiple,
          'created_at' => campaign.created_at.iso8601(3),
          'updated_at' => campaign.updated_at.iso8601(3),
        }
      }
    end

    it 'shows the excepted investmnet' do
      get :show, params: { campaign_id: campaign.id, id: investment_1.id }

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body).to eq(investment_1_response)
    end
  end

  describe 'POST #create' do
    it 'creates an investment' do
      post :create,
           params: {
             amount: 4.97,
             campaign_id: campaign.id,
           }

      expect(response).to have_http_status(200)
      expect(Investment.count).to eq(3)
    end
  end

  describe 'PUT #update' do
    it 'updates an investment' do
      put :update,
          params: {
            campaign_id: campaign.id,
            id: investment_1.id,
            amount: 9.94,
          }

      expect(response).to have_http_status(200)
      expect(investment_1.reload.amount).to eq(9.94)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys an investment' do
      delete :destroy, params: { campaign_id: campaign.id, id: investment_1.id }

      expect(response).to have_http_status(200)
      expect(Investment.count).to eq(1)
    end
  end
end
