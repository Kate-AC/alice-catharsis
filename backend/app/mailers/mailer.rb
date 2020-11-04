# frozen_string_literal: true

class Mailer < ApplicationMailer
  default from: "alice.catharsis.form@example.com"

  def contact_form(body)
    @body = body
    mail(
      subject: "Alice Catharsis Form Mail",
      to: "alice.catharsis.kate@gmail.com"
    )
  end
end
