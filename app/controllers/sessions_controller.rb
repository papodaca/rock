class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:create]
  def create
    user = User.where(:email => params[:email]).first
    if user == nil || user.auth(params[:password]) == false
      render :text => "unauthorized", :status => 401
    else
      session = Session.create(:user_id => user.id)
      session.setKey()
      render :json => { :session_key => session.session_key }
    end
  end

  def test
    render :text => "OK"
  end
end
