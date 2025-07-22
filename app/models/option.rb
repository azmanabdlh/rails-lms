class Option
  include ActiveModel::Model, ActiveModel::Serializers::JSON

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
