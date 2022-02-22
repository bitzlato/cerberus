class Admin::ApplicantsController < Admin::AdminController
  def index
    @applicants = Applicant.all.page(page).per(per_page || 15).decorate
  end

  def show
    @applicant = Applicant.find(params[:id]).decorate
  end

  private

  def per_page
    params[:per]
  end

  def page
    params[:page]
  end
end
