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
end
