class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
  end

  def new
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    message = Reservation.check_reservation_day(@day.to_date)
    if !!message
      redirect_to @reservation, flash: { alert: message }
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservation_path @reservation.id
    else
      render :new
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to user_path(current_user.id), flash: { notice: "予約を削除しました" }
    else
      render :show, flash: { alert: "予約の削除に失敗しました" }
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:day, :time, :user_id, :start_time)
  end
end
