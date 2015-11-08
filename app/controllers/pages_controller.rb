class PagesController < ApplicationController
  skip_before_action :is_loggedin?
  
  def index
  end
end
