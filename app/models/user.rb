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

  # Attachinary associations
  has_attachment :profile_picture
  has_attachment :cover_photo

   # Finds specific participation instance if there is one for that user on that project.
  def participation(project)
    participations.find_by(project: project)
  end

  # Returns true or false depending on whether the user has participated (using the action above)
  def participated_to?(project)
    !participation(project).nil?
  end

  def get_profile_picture
    if profile_picture?
      return profile_picture.path
    elsif linkedin_picture_url
      return linkedin_picture_url
    else
      return 'sample'
    end
  end

  def get_cover_picture
    if cover_photo? # Need to add attachinary into the model so 'profile_picture' method is in place
      # Waiting for James to merge.
      return cover_photo.path
    else
      return 'http://unsplash.it/1200/?random'
    end
  end

  # Returns the full_name of the user
  def full_name
    if self.company
      return "#{self.company_name}"
    else
      return "#{self.first_name} #{self.last_name}"
    end
  end

  # Returns true if the user is an individual
  def is_individual?
    self.company == false
  end

  # Returns true if the user is a company
  def is_company?
    self.company
  end

  # Returns the number of closed contributions
  def count_contributions
    self.contributions.select{ |c| c.project.end_date < DateTime.now }.count
  end

  # Returns the number of starred and closed contributions
  def count_starred_contributions
    self.contributions.select{ |c| c.project.end_date < DateTime.now && c.starred == true }.count
  end

  # Returns the total number of upvotes a user has on all their contributions
  def count_upvotes
    total = 0
    self.contributions.each do |c|
      total += c.upvotes.count
    end
    return total
  end

  def count_participations
    self.participations.select { |p| p.project.end_date > DateTime.now }.count
  end

  # Returns the participations that are currently active
  # i.e. for which the end_date is greater than the current date
  def active_participations
    active_participations = self.participations.select { |p| p.project.end_date > DateTime.now }
    if active_participations.length >= 1
      return active_participations
    else
      return false
    end
  end

  # Returns the contributions of a user for which the deadline has expired
  def closed_contributions
    closed_contributions = self.contributions.select{ |c| c.project.end_date < DateTime.now }
    if closed_contributions.length >= 1
      return closed_contributions
    else
      return false
    end
  end

  def favorite_companies
    company_frequencies = {}
    self.contributions.each do |c|
      owner = c.project.user.full_name
      if company_frequencies[owner]
        company_frequencies[owner] += 1
      else
        company_frequencies[owner] = 1
      end
    end
    if company_frequencies.length >= 1
      return company_frequencies.sort_by { |k,v| v }.reverse.first(3)
    else
      return false
    end
  end

  def get_picture
    if profile_picture?
      return profile_picture.path
    else
      return 'sample'
    end
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
