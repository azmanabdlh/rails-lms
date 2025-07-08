module Sluggable
  extend ActiveSupport::Concern

  class_methods do
    def sluggable(column = :title, length:)
      before_save do
        generate_slug(column, length)
      end
    end
  end

  private
  def generate_slug(column, length)
    # this func to generate slug by title
    # ex: blabla-blabla-43289472893
    len = length or 20
    t = send(column).to_s
    t = t.split().first if t.split().length == 1
    t = t.first len if t.length > len
    rand = SecureRandom.alphanumeric(8)

    self.slug = t.parameterize + "-#{rand}"
  end
end
