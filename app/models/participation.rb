class Participation < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :project
end
