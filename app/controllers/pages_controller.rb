class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search
  	@projects = Project.all
  	@companies = User.where(company: true)
  	@people = User.where (company: false)
  end
end
