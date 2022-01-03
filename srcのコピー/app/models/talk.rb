class Talk < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :members, class_name: "User", through: :entries, source: :user
  has_many :messages, dependent: :destroy
end
