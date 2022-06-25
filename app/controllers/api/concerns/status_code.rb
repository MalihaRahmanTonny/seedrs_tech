# frozen_string_literal: true

module Api
  module Concerns
    module StatusCode
      STATUS_CODE_TYPE = {
        ActiveRecord::RecordNotFound => :not_found,
        Errors::NotFound => :not_found,
        Errors::UnprocessableEntity => :unprocessable_entity,
        Errors::BadRequest => :bad_request,
      }.freeze
    end
  end
end
