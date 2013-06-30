class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:create]
  def create
    if params[:registration_password] != $APP_CONFIG['registration_password']
      render :text => "unauthorized", :status => 401
    elsif User.where(:email => params[:email]).present? == true
      render :text => "Email in use.", :status => 400
    else
      user = User.create(:email => params[:email], :name => params[:name])
      user.setPassword(params[:password])

      render :json => {:name => user.name, :email => user.email, :id => user.id }
    end
  end
end
