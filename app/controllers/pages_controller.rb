class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @fun_fact = FunFact.all.sample
  end

  def profile
  end

  private

  def user_params
    params.require(:user).permit(:username, :avatar)
  end
end
