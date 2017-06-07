class Contribution < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :project
  has_many :upvotes, dependent: :destroy

  has_attachment :file

  # Validations
  validates :comment, presence: true
# validates :file, presence: true
  validates :project_id, uniqueness: { scope: :user_id }
end
