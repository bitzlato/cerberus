class VerificationsController < ApplicationController
  def index
    @verifications = Verification.all.page(page).per(per_page).decorate
  end

  def new
  end

  def create
  end

  def update
  end
end
