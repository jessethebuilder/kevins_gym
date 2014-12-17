class GymsController < ApplicationController
  before_action :set_gym, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    #@gyms = Gym.all
    #respond_with(@gyms)
    @gym = Gym.first
    redirect_to :show
  end

  def show
    respond_with(@gym)
  end

  def new
    @gym = Gym.new
    respond_with(@gym)
  end

  def edit
  end

  def create
    @gym = Gym.new(gym_params)
    @gym.save
    respond_with(@gym)
  end

  def update
    @gym.update(gym_params)
    respond_with(@gym)
  end

  def destroy
    @gym.destroy
    respond_with(@gym)
  end

  private
    def set_gym
      @gym = Gym.find(params[:id])
    end

    def gym_params
      params.require(:gym).permit(:name, :phone, :email, :fax)
    end
end
