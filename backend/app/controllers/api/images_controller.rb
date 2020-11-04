module Api
  class ImagesController < ActionController::Base
    def index
      begin
        condition = create_params
        images = Image.search_by_condition(condition)
      rescue StandardError => e
        logger.debug e
      end

      render json: images.to_json, status: :ok
    end

    private

    def create_params
      params.permit(:target_type)
    end
  end
end
