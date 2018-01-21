class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.send_when_contacted.subject
  #
  def auto_reply(name, address, message)
    @name = name
    @message = message
    mail to: address, subject: "#{name}, thanks for your message!"
  end
end
