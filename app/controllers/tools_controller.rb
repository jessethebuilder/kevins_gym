class ToolsController < ApplicationController
  def home

  end

  def membership

  end

  def gym_sign_in
    redirect_to '/d/users/sign_in'
  end
end
