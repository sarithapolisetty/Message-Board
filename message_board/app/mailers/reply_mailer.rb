class ReplyMailer < ApplicationMailer

    def hello_world
      mail(
        to: "saritha@messageboard.io",
        subject: "Hello, World!"
        )
    end

    def notify_message_owner(reply)
        @reply = reply
        @message = reply.message
        @message_owner = @message.user

        mail(
            to: @message_owner.email,
            subject: "You got a new reply!"
        )
    end
end
