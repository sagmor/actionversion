class ApplicationController < ActionController::API
  include ActionVersion::Controller

  rescue_from Exception do |e|
    render json: { error: e.message }
  end
end
