class MainController < ApplicationController
  skip_before_filter :require_login, :only => [:index]
  skip_before_action :verify_authenticity_token
  def index
  end
end
