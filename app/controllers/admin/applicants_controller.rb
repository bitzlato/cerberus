class Admin::ApplicantsController < Admin::AdminController
  def index
    @applicants = Applicant.all.decorate
  end

  def show
    @applicant = Applicant.find(params[:id]).decorate
  end
end
