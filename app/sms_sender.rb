class SmsSender
  # You need to fix this method, currently it will crash with > 160 char messages.
  MESSAGE_LENGTH = 160

  def send_sms_message(text, to, from)
    split_the_message_and_deliver(text, to, from)
  end

  # This method actually sends the message via a SMS carrier
  # This method works, you don't change it,

  private

  def split_the_message_and_deliver(text, to, from)
    if text.length < MESSAGE_LENGTH
      deliver_message_via_carrier(text, to, from)
    else
      deliver_by_parts(text, to, from)
    end
  end

  def message_suffix(message_number, count_of_messages)
    " - Part #{message_number} of #{count_of_messages}"
  end

  def deliver_by_parts(text, to, from)
    count_of_messages = text.length / MESSAGE_LENGTH + 1

    0.upto(count_of_messages) do |message_number|
      first_el_index = message_number
      last_el_index = message_number
      part_of_text = text[first_el_index .. last_el_index]
      suffix = message_suffix(message_number, count_of_messages)

      deliver_message_via_carrier(part_of_text, to, from, suffix='')
    end
  end

  def deliver_message_via_carrier(text, to, from, suffix='')
    SMS_CARRIER.deliver_message(text, to, from)
  end
end
