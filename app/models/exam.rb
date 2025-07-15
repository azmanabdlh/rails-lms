class Exam < ApplicationRecord
  belongs_to :course

  attribute :options, :json

  has_one :answer

  delegate :answered?, :skipped?, to: :answer, allow_nil: true

  def options
    opts = super || []
    opts.map { |op| Option.new(op) }
  end

  def options=(opts)
    raw = opts.map { |op| op.is_a?(Option) ? op.as_json : op }
    super(raw)
  end

  class Option
    include ActiveModel::Model, ActiveModel::Serializers::JSON
    # attr selected for indicate user selected
    attr_accessor :key, :text_plain, :text_plain_html, :correct, :selected

    def initialize(attributes = {})
      super
      self.selected ||= false
    end


    def attributes
      instance_values
    end

    def attributes=(hash)
      hash.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end

    def answer_by?(op_key)
      op_key.present? and self.key == op_key
    end

    def answer_correctly?(op_key)
      answer_by? op_key and self.correct == true
    end

    def mark_as_selected(op_key)
      self.selected = self.key == op_key
    end
  end
end
