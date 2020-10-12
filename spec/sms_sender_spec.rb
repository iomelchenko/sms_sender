require 'spec_helper'

describe SmsSender do
  let(:to) { '+49 178 920 10 33' }
  let(:from) { '+49 178 920 10 22' }

  describe '#send_sms_message' do
    context 'one message' do
      let(:text) { 'one message sms_text' }

      it "should trigger the SMS carrier one time" do
        expect(SMS_CARRIER).to receive(:deliver_message)
          .with(text, to, from).once

        subject.send_sms_message(text, to, from)
      end
    end

    context 'two messages (161 symbols)' do
      let(:text) { 'a' * 160 + '!' }
      let(:first_suffix) { "\n - Part 1 of 2" }
      let(:second_suffix) { "\n - Part 2 of 2" }

      let(:first_texts_part) { text[0..159] + first_suffix }
      let(:second_texts_part) { text[160] + second_suffix }

      it "should trigger the SMS carrier two times" do
        expect(SMS_CARRIER).to receive(:deliver_message)
          .with(first_texts_part, to, from).once
        expect(SMS_CARRIER).to receive(:deliver_message)
          .with(second_texts_part, to, from).once

        subject.send_sms_message(text, to, from)
      end
    end

    context 'two messages (320 symbols)' do
      let(:text) { 'a' * 319 + '!' }
      let(:first_suffix) { "\n - Part 1 of 2" }
      let(:second_suffix) { "\n - Part 2 of 2" }

      let(:first_texts_part) { text[0..159] + first_suffix }
      let(:second_texts_part) { text[160..319] + second_suffix }

      it "should trigger the SMS carrier two times" do
        expect(SMS_CARRIER).to receive(:deliver_message)
          .with(first_texts_part, to, from).once
        expect(SMS_CARRIER).to receive(:deliver_message)
          .with(second_texts_part, to, from).once

        subject.send_sms_message(text, to, from)
      end
    end

    context 'three messages (321 symbols)' do
      let(:text) { 'a' * 320 + '!' }
      let(:first_suffix) { "\n - Part 1 of 3" }
      let(:second_suffix) { "\n - Part 2 of 3" }
      let(:third_suffix) { "\n - Part 3 of 3" }

      let(:first_texts_part) { text[0..159] + first_suffix }
      let(:second_texts_part) { text[160..319] + second_suffix }
      let(:third_texts_part) { text[320] + third_suffix }

      it "should trigger the SMS carrier two times" do
        expect(SMS_CARRIER).to receive(:deliver_message)
          .with(first_texts_part, to, from).once
        expect(SMS_CARRIER).to receive(:deliver_message)
          .with(second_texts_part, to, from).once
        expect(SMS_CARRIER).to receive(:deliver_message)
          .with(third_texts_part, to, from).once

        subject.send_sms_message(text, to, from)
      end
    end
  end
end