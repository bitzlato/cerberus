class Admin::ApplicantsController < Admin::AdminController
  def index
    @applicants = Applicant.all
  end

  def show
    @applicant = Applicant.find(params[:id])
  end
end
