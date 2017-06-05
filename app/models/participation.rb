class Participation < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :project

  # Validations
  validates :project_id, uniqueness: { scope: :user_id }
end
