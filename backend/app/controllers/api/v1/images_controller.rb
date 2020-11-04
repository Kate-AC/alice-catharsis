module Api
  class V1::ImagesController < ActionController::Base
    class RequestParamsException < StandardError; end

    LIMIT_RANGE = [*1..5].freeze
    TARGET_TYPES = %w[all normal r18].freeze

    def latest
      condition = create_params
      validate(condition)
      images = Image.select("id, title, url, thumbnail, target_type").search_by_condition(condition).limit(condition[:limit])

      render json: images.to_json, status: :ok
    rescue StandardError => e
      render json: e.message, status: :bad_request
    end

    private

    def validate(condition)
      raise RequestParamsException, "target_typeが未知の値" unless TARGET_TYPES.include?(condition[:target_type])
      raise RequestParamsException, "limitが範囲外" unless LIMIT_RANGE.include?(condition[:limit].to_i)
    end

    def create_params
      condition = params.permit(:target_type, :limit)
      condition[:target_type] ||= "all"
      condition[:limit] ||= 5

      condition
    end
  end
end
