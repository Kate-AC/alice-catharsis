module Api
  class HealthsController < ActionController::Base
    def show
      render plain: "Status OK."
    end
  end
end
