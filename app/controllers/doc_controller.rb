class DocController < ApplicationController
  skip_before_filter :require_login
  def index
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :apis => [
        {
          :path => "/doc/sessions",
          :description => ""
        },
        {
          :path => "/doc/users",
          :description => ""
        },
        {
          :path => "/doc/libraries",
          :description => ""
        },
        {
          :path => "/doc/songs",
          :description => ""
        },
        {
          :path => "/doc/albums",
          :description => ""
        },
        {
          :path => "/doc/genres",
          :description => ""
        },
        {
          :path => "/doc/playlists",
          :description => ""
        },
        {
          :path => "/doc/artists",
          :description => ""
        }
      ]
    }
  end

  def sessions
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :resourcePath => "/sessions",
      :apis => [
        {
          :path => "/sessions",
          :description => "Create a session.",
          :operations => [
            {
              :httpMethod => "POST",
              :summary => "Create a session using a user's credentials.",
              :responseClass => "session_key",
              :nickname => "createSession",
              :parameters => [
                {
                  :description => "A json objet with user name and password.",
                  :paramType => "body",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "Credentials"
                }
              ],
              :errorResponses => [
                {
                  :code => 401,
                  :reason => "Invalid email and password"
                }
              ]
            }
          ]
        }
      ],
      :models => {
        :Credentials => {
          :id => "Credentials",
          :properties => {
            :email => {
              :type => "string",
              :required => true
            },
            :password => {
              :type => "string",
              :required => true
            }
          }
        },
        :session_key => {
          :id => "session_key",
          :properties => {
            :session_key => {
              :type => "string",
              :required => true
            }
          }
        }
      }
    }
  end

  def users
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :resourcePath => "/users",
      :apis => [
        {
          :path => "/users",
          :description => "Create a user account.",
          :operations => [
            {
              :httpMethod => "POST",
              :summary => "Create a user account.",
              :responseClass => "RegistrationResponse",
              :nickname => "createUserAccount",
              :parameters => [
                {
                  :description => "A json objet with user details.",
                  :paramType => "body",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "User"
                },
                {
                  :description => "A password required for registration.",
                  :paramType => "query",
                  :required => false,
                  :allowMultiple => false,
                  :dataType => "string"
                }
              ],
              :errorResponses => [
                {
                  :code => 400,
                  :reason => "E-mai address in use."
                },
                {
                  :code => 401,
                  :reason => "Incorrect registration password."
                }
              ]
            }
          ]
        }
      ],
      :models => {
        :User => {
          :id => "User",
          :properties => {
            :name => {
              :type => "string",
              :required => true
            },
            :email => {
              :type => "string",
              :required => true
            },
            :password => {
              :type => "string",
              :required => true
            },
            :registration_password => {
              :type => "string"
            }
          }
        },
        :RegistrationResponse => {
          :id => "User",
          :properties => {
            :id => {
              :type => "integer",
              :required => true
            },
            :name => {
              :type => "string",
              :required => true
            },
            :email => {
              :type => "string",
              :required => true
            }
          }
        }
      }
    }
  end

  def libraries
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :resourcePath => "/libraries",
      :apis => [
      ]
    }
  end

  def songs
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :resourcePath => "/songs",
      :apis => [
      ]
    }
  end

  def albums
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :resourcePath => "/albums",
      :apis => [
      ]
    }
  end

  def genres
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :resourcePath => "/genres",
      :apis => [
      ]
    }
  end

  def playlists
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :resourcePath => "/playlists",
      :apis => [
      ]
    }
  end

  def artists
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :resourcePath => "/artists",
      :apis => [
      ]
    }
  end
end
