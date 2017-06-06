class Project < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :participations, dependent: :destroy
  has_many :contributions, dependent: :nullify

  # Validations
  validates :title, presence: true
  validates :brief, presence: true
  validates :end_date, presence: true
  validates :max_participations, presence: true
  validates :category, presence: true
  validate :time_valid

  def days_left
    days_left = (self.end_date.to_date - DateTime.now.to_date).to_i
  end

  private

  def time_valid
    if self.end_date <= DateTime.now
      errors.add(:end_date, "can't be in the past")
    end
  end
end
