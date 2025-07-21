class Exam < ApplicationRecord
  belongs_to :course
  attribute :options, :json
  has_one :answer
  delegate :answered?, :skipped?, to: :answer, allow_nil: true

  def options
    opts = super || []
    opts.map { |op| Objects::Option.new(op) }
  end

  def options=(opts)
    raw = opts.map { |op| op.is_a?(Option) ? op.as_json : op }
    super(raw)
  end
end
