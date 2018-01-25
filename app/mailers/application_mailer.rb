class ApplicationMailer < ActionMailer::Base
  default from: "newsb![Support Team]",
          bcc: "newsb.sns@gmail.com"
  layout 'mailer'
end
