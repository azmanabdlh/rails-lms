module Sluggable
  extend ActiveSupport::Concern

  class_methods do
    def sluggable(column = :title, **options)
      options[:length] = 20 if options[:length].blank?

      before_save do
        generate_slug(column, options[:length])
      end
    end
  end

  private
  def generate_slug(column, length = 0)
    # this func to generate slug by title
    # ex: blabla-blabla-43289472893

    current = send(column).to_s
    prev = prev_value(column)
    return if prev.blank? or prev == current

    current = current.split().first if current.split().length == 1
    current = current.first(length) if current.length > length
    rand = SecureRandom.alphanumeric(8)

    self.slug = current.parameterize + "-#{rand}"
  end

  def prev_value(column)
    column_change = send("#{column}_change")
    prev = column_change.first if column_change.present?
    prev.to_s
  end
end
