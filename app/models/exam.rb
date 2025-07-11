class Exam < ApplicationRecord
  belongs_to :course

  attribute :options, :json
  attribute :is_answered, :boolean, default: false
  attribute :is_skipped, :boolean, default: false

  class Option
    include ActiveModel::Serializers::JSON
    attr_accessor :key,
      :text_plain,
      :text_plain_html,
      :correct,
      :selected # this indicate for user selected

    def attributes
      instance_values
      # { "key" => nil, "text_plain" => nil, "text_plain_html" => nil, "correct" => nil, "selected": nil }
    end

    def attributes=(hash)
      hash.each do |key, value|
        send("#{key}=", value)
      end
    end

    def my_answered?(op_key)
      self.selected = op_key.present? and self.key.eql? op_key
    end

    def my_answered_correctly?(op_key)
      op_key.present? and self.key.eql? op_key and self.correct == true
    end
  end
end
