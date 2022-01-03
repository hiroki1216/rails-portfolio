class Message < ApplicationRecord
  belongs_to :user
  belongs_to :talk
  has_many :notifications, dependent: :destroy
  validates :content, presence: true
end
