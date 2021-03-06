class Inquiry < ApplicationRecord
  attr_accessor :name, :message

  validates :name, presence: true, length: { maximum: 255 }
  validates :message, presence: true, length: { maximum: 500 }
end
