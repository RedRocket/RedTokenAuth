require_relative "omniauthable/callbacks_and_validations"

module RedTokenAuth
  module Omniauthable
    extend ActiveSupport::Concern

    included do
      include CallbacksAndValidations
    end

    class_methods do
    end
  end
end
