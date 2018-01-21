class ApplicationMailer < ActionMailer::Base
  default from: "NEWSB![Support Team]",
          bcc: "natsukingly01@gmail.com"
  layout 'mailer'
end
