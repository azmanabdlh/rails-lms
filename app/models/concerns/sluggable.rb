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
    t = send(column).to_s
    t = t.split().first if t.split().length == 1
    t = t.first(length)  if t.length > length
    rand = SecureRandom.alphanumeric(8)

    self.slug = t.parameterize + "-#{rand}"
  end
end
