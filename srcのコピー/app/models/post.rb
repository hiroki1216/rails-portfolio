class Post < ApplicationRecord
    validates :title, presence: true
    validates :contents, presence: true, length: { minimum: 10 }
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    #下のsource：：userについては、関連付け名から関連付けもとが推測できるため、敢えて書く必要はないが、動作確認のため書いている。
    has_many :users, through: :likes ,source: :user
    has_many :notifications, dependent: :destroy
    belongs_to :category
    belongs_to :user
end
