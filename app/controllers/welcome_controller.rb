class WelcomeController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]  
  def index
  end
end
