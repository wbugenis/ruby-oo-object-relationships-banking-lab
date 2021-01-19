require 'pry'

class Transfer
    attr_reader :sender, :receiver, :amount
    attr_accessor :status

    def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
    end

    def valid?
      sender.valid? && receiver.valid?
    end

    def execute_transaction
      if sender.balance >= amount && self.valid? && status == "pending"
        sender.deposit(-amount)
        receiver.deposit(amount)
        self.status = "complete"
      else
        self.status = "rejected"
        "Transaction rejected. Please check your account balance."     
      end
    end

    def reverse_transfer
      if status == "complete"
        sender.deposit(amount)
        receiver.deposit(-amount)
        self.status = "reversed"
      end
    end
  

end
