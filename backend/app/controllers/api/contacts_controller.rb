module Api
  class ContactsController < ActionController::Base
    protect_from_forgery with: :null_session

    def create
      contact_params = params.require(:contact).permit(:message)

      raise StandardError if contact_params[:message].size < 5 || contact_params[:message].size > 3000

      Mailer.contact_form(contact_params[:message]).deliver

      render json: {}, status: :ok
    rescue StandardError => e
      puts e
      render json: {}, status: :internal_server_error
    end
  end
end
