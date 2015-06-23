class ShowsController < ApplicationController
  
  def index
    @shows = Show.top_ten
  end
end
