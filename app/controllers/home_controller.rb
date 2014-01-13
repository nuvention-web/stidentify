class HomeController < ApplicationController

  def landing
    @initial_user = InitialUser.new
  end

end