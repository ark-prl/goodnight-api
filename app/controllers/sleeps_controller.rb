class SleepsController < ApplicationController
  before_action :set_user, :set_pending_clockout, only: %i[clockin clockout]

  def clockin
    if !@pending_clockout.exists?
      start_new_sleep
      render json: @user.sleeps.order(clockin_at: :asc).select(:id, :date, :clockin_at)
    else
      @sleep = @pending_clockout.first
      render json: "Pending clockout. Last clock in at #{@sleep.clockin_at}", status: :unprocessable_entity
    end
  end

  def clockout
    if @pending_clockout.exists?
      @sleep = @pending_clockout.first
      @sleep.update(clockout_at: DateTime.now)
      @sleep.calc_duration
      render json: "Clocked out at #{@sleep.clockin_at}."
    else
      render json: 'No active sleep. Clockin first.', status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_pending_clockout
    @pending_clockout = Sleep.where(user_id: @user.id, clockout_at: nil)
  end

  def start_new_sleep
    @sleep = Sleep.create(
      user_id: @user.id,
      date: Date.today,
      clockin_at: DateTime.now
    )
  end
end
