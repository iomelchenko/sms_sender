class SmsSender
  attr_reader :sms_carrier

  def initialize(sms_carrier: ::SMS_CARRIER)
    @sms_carrier = sms_carrier
  end

  def send_sms_message(text, to, from)
    split_the_message_and_deliver(text, to, from)
  end

  private

  def split_the_message_and_deliver(text, to, from)
    if text.length < MESSAGE_LENGTH
      deliver_message_via_carrier(text, to, from)
    else
      deliver_message_by_parts(text, to, from)
    end
  end

  def add_suffix(text, message_number, count_of_messages)
    text + "\n - Part #{message_number} of #{count_of_messages}"
  end

  def deliver_message_by_parts(text, to, from)
    messages_cnt = count_of_messages(text)

    1.upto(messages_cnt) do |message_number|
      part_of_text = text[first_el_index(message_number) .. last_el_index(message_number)]
      text_for_delivering = add_suffix(part_of_text, message_number, messages_cnt)

      deliver_message_via_carrier(text_for_delivering, to, from)
    end
  end

  def deliver_message_via_carrier(text, to, from)
    sms_carrier.deliver_message(text, to, from)
  end

  def count_of_messages(text)
    (text.length / MESSAGE_LENGTH) + (text.length % MESSAGE_LENGTH > 0 ? 1 : 0 )
  end

  def first_el_index(message_number)
    return 0 if message_number == 1

    (message_number - 1) * MESSAGE_LENGTH
  end

  def last_el_index(message_number)
    return MESSAGE_LENGTH - 1 if message_number == 1

    message_number * MESSAGE_LENGTH - 1
  end
end
