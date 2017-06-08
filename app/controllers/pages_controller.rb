class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [ :home, :search ]

  def home
  end

  def search
    # @top_projects = Project.number_participations
    @expired_projects = Project.expired_projects
    if params[:term].blank?
  		@projects = Project.all
      @companies = User.all.where(company: true)
  		@people = User.where(company: false)
    else
      @projects = Project.where("title iLIKE :term OR category iLIKE :term", term: "%#{params[:term]}%")
      @companies = User.where(company: true).where("company_name iLIKE :term", term: "%#{params[:term]}%")
      @people = User.where(company: false).where("first_name iLIKE :term OR last_name iLIKE :term", term: "%#{params[:term]}%")
    end
  end

end
