module Observable
  extend ActiveSupport::Concern

  included do
    after_initialize :register
    observed
  end

  class_methods do
    def observed(model = "")
      model = model || name
      klass = model.respond_to?(:to_sym) ? "#{model.to_s.camelize}Observer".constantize : model
      define_method(:observed_class) do
        klass
      end
    end
  end

  def observed_class
    "#{self.class.name}Observer".camelize.constantize
  end

  def register
    klass = observed_class
    add_observer(klass)
  end

  def add_observer(klass)
    define_callbacks klass
  end

  def define_callbacks(klass)
    observer = klass.new
    observer_name = klass.name.underscore.gsub("/", "__")

    model_observable = self.class

    ActiveRecord::Callbacks::CALLBACKS.each do |callback|
      next unless observer.respond_to?(callback)
      callback_meth = :"_notify_#{observer_name}_for_#{callback}"

      unless self.respond_to?(callback_meth)
        model_observable.send(:define_method, callback_meth) do |&block|
          observer.send(callback, self, &block)
        end
        model_observable.send(callback, callback_meth)
      end
    end
  end
end


class UserObserver
  def before_update(user)
    puts "user => #{user}"
    puts "user update ===>"
  end
end


class User < ApplicationRecord
  include Observable

  has_secure_password

  has_many :submissions
  has_many :enrollments
end
