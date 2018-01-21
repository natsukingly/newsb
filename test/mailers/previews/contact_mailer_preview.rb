# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/send_when_contacted
  def send_when_contacted
    ContactMailer.send_when_contacted
  end

end
