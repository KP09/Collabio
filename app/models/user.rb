class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  # Companies
  has_many :projects
  # Individuals
  has_many :participations
  has_many :contributions
  has_many :upvotes

  # Validations
  # email and password handled by Devise
  validate :name_validation
  validates :description, presence: true, on: [:update]

  private

  def name_validation
    if self.company == true
      if self.company_name.nil?
        errors.add(:company_name, "can't be blank")
      end
    else
      if self.first_name.nil?
        errors.add(:first_name, "can't be blank")
      end
      if self.last_name.nil?
        errors.add(:last_name, "can't be blank")
      end
    end
  end
end
