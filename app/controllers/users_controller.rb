class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @user_reservations = current_user.reservations.where("day >= ?", Date.current).order(day: :desc)
    @visit_historys = current_user.reservations.where("day < ?", Date.current).where("day > ?", Date.today << 12).order(day: :desc)
  end
end
