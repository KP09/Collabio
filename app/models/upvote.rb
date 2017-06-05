class Upvote < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :contribution

  # Validations
  validates :contribution_id, uniqueness: { scope: :user_id }
end
