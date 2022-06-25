# frozen_string_literal: true

class Api::ApiController < ActionController::API
  include Api::Concerns::StatusCode

  before_action :set_headers

  rescue_from StandardError do |exception|
    status = STATUS_CODE_TYPE[exception.class] || :internal_server_error
    json = { error_message: exception.message }

    render json: json, status: status
  end

  private

  def set_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
