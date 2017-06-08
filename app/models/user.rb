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

  # Gets the profile picture for a user
  def get_profile_picture
    if profile_picture
      return profile_picture.path
    # elsif linkedin_picture_url
    #   return linkedin_picture_url
    else
      return 'sample'
    end
  end

  # Gets the cover_photo for a user
  def get_cover_photo
    if cover_photo
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

  # Returns integer of number of projects currently open
  def projects_open
    number_projects_open = 0
    if self.company
      self.projects.each do |project|
        if project.end_date.to_date > DateTime.now.to_date
          number_projects_open += 1
        end
      end

    end
    number_projects_open
  end

  def companies_total_joins
    number_joins = 0
    if self.company
      self.projects.each do |p|
        number_joins += p.participations.count
      end
    end
    return number_joins
  end

  def total_project_views
    total_views = 0
    if self.company
      self.projects.each do |p|
        total_views += p.impressionist_count(filter: :ip_address)
      end
    end
    return total_views
  end

  def average_project_views
    average_views = 0
    if self.company
      average_views = (total_project_views / self.projects.count)
    else
      return 0
    end
    return average_views
  end

  # Returns the number of closed contributions
  def count_contributions
    self.contributions.select{ |c| c.project.end_date < DateTime.now }.count
  end

  # Returns the number of starred and closed contributions
  def count_starred_contributions
    self.contributions.select{ |c| c.project.end_date < DateTime.now && c.starred == true }.count
  end

  # Returns the total number of upvotes a user has on all their closed contributions
  def count_upvotes
    total = 0
    if self.closed_contributions
      self.closed_contributions.each do |c|
        total += c.upvotes.count
      end
      return total
    else
      return total
    end
  end

  # Returns the total number of active projects created by a user (company)
  # or returns false if there aren't any
  def active_projects
    active_projects = self.projects.select {|p| p.end_date > DateTime.now }
    if active_projects.count >= 1
      return active_projects
    else
      return false
    end
  end

  # Returns the total number of closed projects created by a user (company)
  # or returns false if there aren't any
  def closed_projects
    closed_projects = self.projects.select {|p| p.end_date <= DateTime.now }
    if closed_projects.count >= 1
      return closed_projects
    else
      return false
    end
  end

  # Returns the total number of contributions received by a user (company)
  # or returns false if there aren't any
  def count_contributions_received
    contributions_received = 0
    self.projects.each do |p|
      contributions_received += p.contributions.count
    end
    return contributions_received
  end

  # Returns all starred contributions received by a user (company)
  def all_contributions
    # Create an empty array
    all_contributions = []
    # For each project
    self.projects.each do |project|
    # Select the contributions that are starred
      project_contributions = project.contributions.select { |c| c.project.end_date < DateTime.now }
      # And push them into an array
      project_contributions.each do |contribution|
        all_contributions << contribution
      end
    end
    return all_contributions.sort_by { |c| c.created_at }
  end

  # Returns all starred contributions received by a user (company)
  def starred_contributions
    # Create an empty array
    starred_contributions = []
    # For each project
    self.projects.each do |project|
    # Select the contributions that are starred
      project_starred_contributions = project.contributions.select { |c| c.starred == true && c.project.end_date < DateTime.now }
      # And push them into an array
      project_starred_contributions.each do |contribution|
        starred_contributions << contribution
      end
    end
    return starred_contributions.sort_by { |c| c.created_at }
  end

   def non_starred_contributions
    # Create an empty array
    non_starred_contributions = []
    # For each project
    self.projects.each do |project|
    # Select the contributions that are starred
      project_starred_contributions = project.contributions.select { |c| c.starred == false && c.project.end_date < DateTime.now }
      # And push them into an array
      project_starred_contributions.each do |contribution|
        non_starred_contributions << contribution
      end
    end
    return non_starred_contributions.sort_by { |c| c.created_at }
  end

  # Returns a hash with the top_individuals of a company
  # Where top individuals are defined by those with the most stars awarded by the company
  def top_individuals
    starred_contributions = self.starred_contributions
    # Create an empty hash
    frequencies = {}
    # Using the array of all starred contributions, build a frequency hash
    if starred_contributions.count >= 1
      starred_contributions.each do |c|
        owner = c.user
        if frequencies[owner]
          frequencies[owner] += 1
        else
          frequencies[owner] = 1
        end
      end
      return frequencies.sort_by { |k,v| v }.reverse.first(3)
    else
      return false
    end
  end

  # Returns a hash with the most frequent contributors of a company
  # or false if there aren't any contributions
  def most_frequent_contributors
    all_contributions = self.all_contributions
    if all_contributions.count >= 1
      contributor_frequencies = {}
      all_contributions.each do |c|
        owner = c.user
        if contributor_frequencies[owner]
          contributor_frequencies[owner] += 1
        else
          contributor_frequencies[owner] = 1
        end
      end
      return contributor_frequencies.sort_by { |k,v| v }.reverse.first(3)
    else
      return false
    end
  end

  # Returns the number of participations for a user
  # where the projects is still open
  def count_participations
    self.participations.select { |p| p.project.end_date > DateTime.now }.count
  end

  # Returns the participations that are currently active
  # i.e. for which the end_date is greater than the current date
  def active_participations
    active_participations = self.participations.select { |p| p.project.end_date > DateTime.now }
    if active_participations.count >= 1
      return active_participations
    else
      return false
    end
  end

  # Returns the contributions of a user for which the deadline has expired
  def closed_contributions
    closed_contributions = self.contributions.select{ |c| c.project.end_date < DateTime.now }
    if closed_contributions.count >= 1
      return closed_contributions
    else
      return false
    end
  end

  # Returns a hash of companies from which a user (individual has received the most stars)
  def most_rated_by
    rated_frequencies = {}
    starred_contributions = self.contributions.select { |c| c.starred == true && c.project.end_date < DateTime.now }
    if starred_contributions.count >= 1
      starred_contributions.each do |c|
        project_owner = c.project.user
        if rated_frequencies[project_owner]
          rated_frequencies[project_owner] += 1
        else
          rated_frequencies[project_owner] = 1
        end
      end
      return rated_frequencies.sort_by { |k,v| v }.reverse.first(3)
    else
      return false
    end
  end

  # Returns a hash of companies and frequencies for closed contributions
  def favorite_companies
    company_frequencies = {}
    if self.closed_contributions
      self.closed_contributions.each do |c|
        owner = c.project.user
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
