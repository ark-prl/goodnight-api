class Follow < ApplicationRecord
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  validate :cannot_follow_self

  def cannot_follow_self
    if from_user_id.equal?(to_user_id)
      errors.add(:from_user_id, "cannot follow self")
    end
  end
end
