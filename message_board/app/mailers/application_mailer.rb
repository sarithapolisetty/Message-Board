class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@messageboard.io'
  layout 'mailer'
end
