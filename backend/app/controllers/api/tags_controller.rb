module Api
  class TagsController < ActionController::Base
    def index
      render json: Tag.all, status: :ok
    end
  end
end
