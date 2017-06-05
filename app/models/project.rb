class Project < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :participations
  has_many :contributions
end
