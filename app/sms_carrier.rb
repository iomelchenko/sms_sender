module SMS_CARRIER
  def self.deliver_message(text, to, from)
    # This is supposed to be an abstraction that communicates with aside service that sends the sms messages.
    puts '#######################'
    puts 'Sending the SMS message'
    puts "from - #{from}"
    puts "to - #{to}"
    puts "text - #{text}"
  end
end
