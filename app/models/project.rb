class Project < ApplicationRecord
  is_impressionable
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
  # validate :time_valid

  def project_open?
    days_left > 0
  end

  def self.expired_projects
    where('end_date < ?', Date.today).order(:end_date)
  end

  def days_left
    days_left = (self.end_date.to_date - DateTime.now.to_date).to_i
  end

  def spaces_left
    space_left = (self.max_participations - self.participations.count).to_i
  end

  # def self.number_participations
  #   Project.participations.countorder(:participations)
  # end

  private

  def time_valid
    if self.end_date <= DateTime.now
      errors.add(:end_date, "can't be in the past")
    end
  end
end
