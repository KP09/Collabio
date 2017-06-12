class Contribution < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :project
  has_many :upvotes, dependent: :destroy

  # Attachinary method
  has_attachment :file

  # Validations
  validates :comment, presence: true
	validates :file, presence: true
  validates :project_id, uniqueness: { scope: :user_id }

  def toggle_star
    if self.starred
      self.starred = false
      self.save
    else
      self.starred = true
      self.save
    end
  end
end
