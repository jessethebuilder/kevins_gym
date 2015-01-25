class ToolsController < ApplicationController
  def home
    render :home, :layout => 'blank'
  end

  def membership

  end

  def personal_training

  end

  def nutrition

  end

  def massage

  end

  def gym_sign_in
    redirect_to '/d/users/sign_in'
  end
end
