# frozen_string_literal: true

module Api
  module V1
    class CampaignsController < Api::ApiController

      before_action :load_campaign, except: %i(index create)

      def index
        @campaigns = Campaign.all
        filter_by_query_params

        render json: @campaigns
      end

      def show
        render_json
      end

      def create
        @campaign = Campaign.create!(campaign_params)

        render_json
      end

      def update
        @campaign.update!(campaign_params)
        render_json
      end

      def destroy
        @campaign.destroy
        render_json
      end

      private

      def campaign_params
        params.permit(:name,
                      :image,
                      :target_amount,
                      :sector,
                      :country,
                      :investment_multiple)
      end

      def load_campaign
        @campaign = Campaign.find(params[:id])
      end

      def filter_by_query_params
        @campaigns = @campaigns.where('name LIKE ?', "%#{params[:name]}%") if params[:name]
        @campaigns = @campaigns.where('sector LIKE ?', "%#{params[:sector]}%") if params[:sector]
        @campaigns = @campaigns.where('country LIKE ?', "%#{params[:country]}%") if params[:country]
        @campaigns = @campaigns.where(target_amount: params[:target_amount]) if params[:target_amount]
        @campaigns = @campaigns.where(investment_multiple: params[:investment_multiple]) if params[:investment_multiple]
        filter_based_on_investor if params[:investor_number]
      end

      def filter_based_on_investor
        @campaigns.each do |campaign|
          next if campaign.investors_count == params[:investor_number].to_i

          @campaigns = @campaigns.reject{ |camp| camp == campaign }
        end
      end

      def render_json
        render json: @campaign.attributes.merge(image_url: rails_blob_path(@campaign.image))
      end
    end
  end
end
