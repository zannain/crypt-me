require 'message_sender.rb'

module ConfirmationSender
  def self.send_confirmation_to(user)
    verification= CodeGenerator.generate
    user.update(verification_code: verification)
    MessageSender.send_code(user.phone_number, verification)
  end
end