# frozen_string_literal: true

module Api
  module V1
    class InvestmentsController < Api::ApiController

      before_action :load_campaign, :load_investment, except: %i(index create)

      def index
        @investments = if params[:campaign_id]
                         Investment.where(campaign_id: params[:campaign_id])
                       else
                         Investment.all
                       end

        render json: @investments
      end

      def show
        render_json
      end

      def create
        @investment = Investment.create!(investment_params)
        render_json
      end

      def update
        @investment.update!(investment_params)
        render_json
      end

      def destroy
        @investment.destroy
        render_json
      end

      private

      def investment_params
        params.permit(:campaign_id, :amount)
      end

      def load_campaign
        @campaign = Campaign.find(params[:campaign_id])
      end

      def load_investment
        @investment = @campaign.investments.find(params[:id])
      end

      def render_json
        render json: @investment.attributes.merge(campaign: @investment.campaign)
      end
    end
  end
end
