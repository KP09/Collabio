class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  # Companies
  has_many :projects, dependent: :nullify
  # Individuals
  has_many :participations, dependent: :destroy
  has_many :contributions, dependent: :nullify
  has_many :upvotes, dependent: :destroy

  # Validations
  # email and password handled by Devise
  validate :name_validation
  validates :description, presence: true, on: [:update]

   # Finds specific participation instance if there is one for that user on that project.
  def participation(project)
    participations.find_by(project: project)
  end

  # Returns true or false depending on whether the user has participated (using the action above)
  def participated_to?(project)
    !participation(project).nil?
  end

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
