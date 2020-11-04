module Api
  class MemosController < ActionController::Base
    def index
      memo_params = params.permit(:tag_id)
      memos = memo_params[:tag_id].blank? ? Memo.get_list : Memo.get_list_by_tag_id(memo_params[:tag_id])

      render json: memos, status: :ok
    end

    def show
      memo_params = params.permit(:id)
      memo = Memo.find(memo_params[:id])

      render json: { memo: memo, tag: memo.tag }, status: :ok
    end
  end
end
