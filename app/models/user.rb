class User < ApplicationRecord
  has_many :followed_by_user, foreign_key: :from_user_id, class_name: 'Follow', dependent: :destroy
  has_many :following_user, foreign_key: :to_user_id, class_name: 'Follow', dependent: :destroy

  has_many :sleeps, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def sleeps_last_week
    sleeps.completed.where('date >= ?', 1.week.ago(Date.today)).order(duration: :desc)
  end

  def follows?(to_user_id)
    Follow.where(from_user_id: id, to_user_id:).exists?
  end
end
