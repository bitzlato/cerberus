class VerificationsController < ApplicationController
  def index
    @verifications = Verification.all.page(page).per(per_page).decorate
  end

  def show
    @verification = Verification.find(params[:id])
  end

  def new
    @verification = Verification.new
  end

  def create
    @verification = Verification.new(verifcation_params)
    if @verification.save
      redirect_to @verification
    else
      render 'new'
    end
  end

  def update
  end

  def verifcation_params
    params.require(:form).permit(:country, {documents: []})
  end
end
