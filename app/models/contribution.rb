class Contribution < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :project
  has_many :upvotes
end
