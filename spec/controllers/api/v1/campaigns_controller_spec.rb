# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CampaignsController do
  let!(:campaign) { FactoryBot.create(:campaign) }

  let(:campaign_response) do
   {
      'id' => campaign.id,
      'name' => campaign.name,
      'percentage_raised' => campaign.percentage_raised,
      'target_amount' => campaign.target_amount,
      'sector' => campaign.sector,
      'country' => campaign.country,
      'investment_multiple' => campaign.investment_multiple,
      'created_at' => campaign.created_at.iso8601(3),
      'updated_at' => campaign.updated_at.iso8601(3),
      'image_url' => rails_blob_path(campaign.image),
   }
  end

  describe 'GET #index' do
    let(:expected_response) do
      [{
        'id' => campaign.id,
        'name' => campaign.name,
        'percentage_raised' => campaign.percentage_raised,
        'target_amount' => campaign.target_amount,
        'sector' => campaign.sector,
        'country' => campaign.country,
        'investment_multiple' => campaign.investment_multiple,
        'created_at' => campaign.created_at.iso8601(3),
        'updated_at' => campaign.updated_at.iso8601(3),
      }]
    end

    it 'lists all the campaigns' do
      get :index

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body).to match_array(expected_response)
    end

    it 'lists all the campaigns based on filter' do
      get :index, params: { country: 'US' }

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body).to eq([])
    end
  end

  describe 'GET #show' do

    it 'shows the excepted campaign' do
      get :show, params: { id: campaign.id }

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body).to eq(campaign_response)
    end
  end

  describe 'POST #create' do
    it 'creates a campaign' do
      post :create,
           params: {
             name: 'Campaign X',
             target_amount: 100,
             sector: 'XX',
             country: 'BD',
             investment_multiple: 2,
             image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/test.png")
           }

      expect(response).to have_http_status(200)
      expect(Campaign.count).to eq(2)
    end
  end

  describe 'PUT #update' do
    it 'updates a campaign' do
      put :update,
           params: {
             id: campaign.id,
             target_amount: 90,
            }

      expect(response).to have_http_status(200)
      expect(campaign.reload.target_amount).to eq(90)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys a campaign' do
      delete :destroy, params: { id: campaign.id }

      expect(response).to have_http_status(200)
      expect(Campaign.count).to eq(0)
    end
  end
end
