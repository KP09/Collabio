class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search
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
