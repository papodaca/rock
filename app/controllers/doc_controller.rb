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
          :description => "Sessions with this API",
          :operations => [
            {
              :httpMethod => "POST",
              :summary => "Create a session using a user's credentials.",
              :responseClass => "session_key",
              :nickname => "createSession",
              :parameters => [
                {
                  :description => "A json objet with user name and password",
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
          :description => "Users of this API",
          :operations => [
            {
              :httpMethod => "POST",
              :summary => "Create a user account",
              :responseClass => "RegistrationResponse",
              :nickname => "createUserAccount",
              :parameters => [
                {
                  :description => "A json objet with user details",
                  :paramType => "body",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "User"
                },
                {
                  :name => "registration_password",
                  :description => "A password required for registration",
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
        {
          :path => "/libraries",
          :description => "Libraries of songs",
          :operations => [
            {
              :httpMethod => "get",
              :summary => "Current list of libraries",
              :responseClass => "List[Library]",
              :nickname => "listLibraries",
              :parameters => [
                {
                  :name => "session_key",
                  :description => "A session key",
                  :paramType => "header",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "string"
                }
              ],
              :errorResponses => [
                {
                  :code => 401,
                  :reason => "Invalid session_key."
                }
              ]
            },
            {
              :httpMethod => "POST",
              :summary => "Create a library",
              :responseClass => "Library",
              :nickname => "createLibrary",
              :parameters => [
                {
                  :description => "A Library Prototype",
                  :paramType => "body",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "LibraryPrototype"
                },
                {
                  :name => "session_key",
                  :description => "A session key",
                  :paramType => "header",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "string"
                }
              ],
              :errorResponses => [
                {
                  :code => 401,
                  :reason => "Invalid session_key."
                }
              ]
            }
          ]
        },
        {
          :path => "/libraries/{id}",
          :description => "A library of songs",
          :operations => [
            {
              :httpMethod => "get",
              :summary => "Get a library",
              :responseClass => "Library",
              :nickname => "getLibrary",
              :parameters => [
                {
                  :name => "id",
                  :description => "A library id",
                  :paramType => "path",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "integer"
                },
                {
                  :name => "session_key",
                  :description => "A session key",
                  :paramType => "header",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "string"
                }
              ],
              :errorResponses => [
                {
                  :code => 401,
                  :reason => "Invalid session_key."
                },
                {
                  :code => 404,
                  :reason => "Library not found"
                }
              ]
            },
            {
              :httpMethod => "put",
              :summary => "Update a library",
              :responseClass => "Library",
              :nickname => "updateLibrary",
              :parameters => [
                {
                  :name => "id",
                  :description => "A library id",
                  :paramType => "path",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "integer"
                },
                {
                  :description => "A Library Prototype",
                  :paramType => "body",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "LibraryPrototype"
                },
                {
                  :name => "session_key",
                  :description => "A session key",
                  :paramType => "header",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "string"
                }
              ],
              :errorResponses => [
                {
                  :code => 401,
                  :reason => "Invalid session_key."
                },
                {
                  :code => 404,
                  :reason => "Library not found"
                }
              ]
            },
            {
              :httpMethod => "delete",
              :summary => "Delete a library",
              :responseClass => "void",
              :nickname => "deleteLibrary",
              :parameters => [
                {
                  :name => "id",
                  :description => "A library id",
                  :paramType => "path",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "integer"
                },
                {
                  :name => "session_key",
                  :description => "A session key",
                  :paramType => "header",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "string"
                }
              ],
              :errorResponses => [
                {
                  :code => 401,
                  :reason => "Invalid session_key."
                },
                {
                  :code => 404,
                  :reason => "Library not found"
                }
              ]
            }
          ]
        },
        {
          :path => "/libraries/{id}/scan",
          :description => "Libraries of songs",
          :operations => [
            {
              :httpMethod => "post",
              :summary => "scan a library into database",
              :responseClass => "Library",
              :nickname => "scanLibrary",
              :parameters => [
                {
                  :name => "id",
                  :description => "A library id",
                  :paramType => "path",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "integer"
                },
                {
                  :name => "session_key",
                  :description => "A session key",
                  :paramType => "header",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "string"
                }
              ],
              :errorResponses => [
                {
                  :code => 401,
                  :reason => "Invalid session_key."
                },
                {
                  :code => 404,
                  :reason => "Library not found"
                }
              ]
            }
          ]
        }
      ],
      :models => {
        :Library => {
          :id => "Library",
          :properties => {
            :id => {
              :type => "integer",
              :required => true
            },
            :name => {
              :type => "string",
              :required => true
            },
            :path => {
              :type => "string",
              :required => true
            },
            :songs => {
              :type => "integer",
              :required => true
            },
            :progress => {
              :type => "integer",
              :required => true,
              :description => "percentage of scanning progress"
            }
          }
        },
        :LibraryPrototype => {
          :id => "Library",
          :properties => {
            :name => {
              :type => "string",
              :required => true
            },
            :path => {
              :type => "string",
              :required => true
            }
          }
        }
      }
    }
  end

  def songs
    render :json => {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
      :resourcePath => "/songs",
      :apis => [
        {
          :path => "/songs",
          :description => "paginated list of songs",
          :operations => [
            {
              :httpMethod => "get",
              :summary => "paginated list of songs",
              :responseClass => "PaginatedSongs",
              :notes => "The actual results will varry slightly from what is shown here, try this out to see what it looks like!",
              :nickname => "listSongs",
              :parameters => [
                {
                  :name => "session_key",
                  :description => "A session key",
                  :paramType => "header",
                  :required => true,
                  :allowMultiple => false,
                  :dataType => "string"
                },
                {
                  :name => "page",
                  :description => "page in the array",
                  :paramType => "query",
                  :required => false,
                  :allowMultiple => false,
                  :dataType => "integer"
                },
                {
                  :name => "per_page",
                  :description => "count per page",
                  :paramType => "header",
                  :required => false,
                  :allowMultiple => false,
                  :dataType => "integer"
                }
              ],
              :errorResponses => [
                {
                  :code => 401,
                  :reason => "Invalid session_key."
                }
              ]
            }
          ]
        }
      ],
      :models => {
        :Song => {
          :id => "Song",
          :properties => {
            :id => {
              :type => "integer",
              :required => true
            },
            :title => {
              :type => "string",
              :required => true
            },
            :track => {
              :type => "integer",
              :required => true
            },
            :length => {
              :type => "integer",
              :required => true
            },
            :artist => {
              :type => "string",
              :required => true
            },
            :album => {
              :type => "string",
              :required => true
            },
            :genre => {
              :type => "string",
              :required => true
            }
          }
        },
        :PaginationObject => {
          :id => "PaginationObject",
          :properties => {
            :page => {
              :type => "integer",
              :required => true
            },
            :total_entries => {
              :type => "integer",
              :required => true
            },
            :total_pages => {
              :type => "integer",
              :required => true
            },
            :total_entries => {
              :type => "integer",
              :required => true
            }
          }
        },
        :PaginatedSongs => {
          :id => "PaginatedSongs",
          :properties => {
            :page => {
              :type => "PaginationObject",
              :required => true,
            },
            :songs => {
              :type => "Array",
              :items => {
                "$ref" => "Song"
              },
              :required => true
            }
          }
        }
      }
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
