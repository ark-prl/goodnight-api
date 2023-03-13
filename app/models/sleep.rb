class Sleep < ApplicationRecord
  belongs_to :user
  validates :date, presence: true

  scope :completed, -> { where.not(duration: nil) }

  def calc_duration
    update(duration: (clockout_at - clockin_at).round) if clockout_at.present?
  end
end
