require './app/sms_carrier'
require './app/sms_sender'

MESSAGE_LENGTH = 160
MAX_SUFFIX_LENGTH = "\n - Part 99 of 99".length
MAX_MESSAGE_LENGTH = MESSAGE_LENGTH - MAX_SUFFIX_LENGTH
