class StaticPagesController < ApplicationController
  # TODO: change to real current_user helper method once have users
  before_action :set_logged_in, except: [:home]

  def home
    @logged_in = false
  end

  def timeline
  end

  def friends
  end

  def about
  end

  def about_edit
  end

  def photos
  end

  private

  def set_logged_in
    @logged_in = true
  end
end
