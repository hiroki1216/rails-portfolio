class User < ApplicationRecord
  #carrierwaveの設定
  mount_uploader :avatar, AvatarUploader

  #投稿機能
  has_many :posts, dependent: :destroy
  #いいね機能
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  #投稿コメント機能
  has_many :comments, dependent: :destroy
  #follow機能
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #Relationshipsテーブルに外部キーが２つあり、いずれもユーザーテーブルに紐づくものであるため、名前を変更して、class_name:で指定しないといけない。
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followee_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followee
  #throughの後は、reverse_of_relationshipsでも問題ない。
  has_many :followers, through: :relationships
  #DM機能
  has_many :entries, dependent: :destroy
  has_many :talks, through: :entries
  has_many :messages, dependent: :destroy
  #通知機能
  has_many :notifications, foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers:[:twitter]
         
         def self.from_omniauth(auth)
          find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
            user.provider = auth["provider"]
            user.uid = auth["uid"]
            user.username = auth["info"]["nickname"]
          end
        end
      
        def self.new_with_session(params, session)
          if session["devise.user_attributes"]
            new(session["devise.user_attributes"]) do |user|
              user.attributes = params
            end
          else
            super
          end
        end

        #いいね機能

        def like(user_post)
          self.likes.find_or_create_by(post_id: user_post.id)
        end

        def unlike(user_post)
          like=self.likes.find_by(post_id: user_post.id)
          like.destroy if like
        end

        def liked_by?(user_post)
          self.like_posts.include?(user_post)
        end

        #フォロー機能
        def follow(other_user)
          unless self == other_user
            self.relationships.find_or_create_by(followee_id: other_user.id)
          end
        end
        def unfollow(other_user)
          relationship = self.relationships.find_by(followee_id: other_user.id)
          relationship.destroy if relationship
        end
        def following?(other_user)
          self.followings.include?(other_user)
        end

        #トーク機能
        def entry(talk)
          self.entries.find_or_create_by(talk_id: talk.id)
        end

        def unentry(talk)
          entry=self.entries.find_by(talk_id: talk.id)
          entry.destroy if entry
        end

        #通知機能
        def create_notification_like!(other_user, user_post)
          self.notifications.find_or_create_by(visited_id: other_user.id, post_id: user_post.id, action: 'like'  )
        end

        def create_notification_comment!(other_user, post_comment, user_post)
          self.notifications.create(visited_id: other_user.id, comment_id: post_comment.id, post_id: user_post.id, action: 'comment' )
        end

        def create_notification_message!(other_user, message)
          self.notifications.create(visited_id: other_user.id, message_id: message.id, action: 'message' )
        end

        def create_notification_following!(other_user)
          self.notifications.find_or_create_by(visited_id: other_user.id, action: 'following' )
        end


        # def self.from_omniauth(auth)
        #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        #     user.email = auth.info.email
        #     user.password = Devise.friendly_token[0, 20]
        #     user.name = auth.info.name   # assuming the user model has a name
        #     user.image = auth.info.image # assuming the user model has an image
        #     # If you are using confirmable and the provider(s) you use validate emails, 
        #     # uncomment the line below to skip the confirmation emails.
        #     # user.skip_confirmation!
        #   end
        # end

          # def self.new_with_session(params, session)
          #   super.tap do |user|
          #     if data = session["devise.twitter_data"] 
          #       user.username = data["username"] if user.username.blank?
          #     end
          #   end
            
          # end
          #     if data = session["devise.twitter_data"]
          #       user.provider = data["provider"] if user.provider.blank?
          #       user.uid = data["uid"] if user.uid.blank?
          #       user.password = Devise.friendly_token[0,20] if user.password.blank?
          #     end
          #   end
          # end
        



end
