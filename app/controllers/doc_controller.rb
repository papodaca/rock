class DocController < ApplicationController
  skip_before_filter :require_login
  @tab = "&nbsp;&nbsp;"

  def getApiSpec
    {
      :apiVersion => "1.0",
      :swaggerVersion => "1.1",
      :basePath => "#{request.protocol}#{request.host_with_port}/api",
    }
  end

  def getNotFound(model)
    {
      :code => 404,
      :reason => "#{model} not found"
    }
  end

  def getInvalidSession
    {
      :code => 401,
      :reason => "Invalid session_key."
    }
  end

  def getSessionParameter
    {
      :name => "session_key",
      :description => "A session key",
      :paramType => "header",
      :required => true,
      :allowMultiple => false,
      :dataType => "string"
    }
  end

  def getIdParameter(model)
    {
      :name => "id",
      :description => "A #{model} id",
      :paramType => "path",
      :required => true,
      :allowMultiple => false,
      :dataType => "integer"
    }
  end

  def getPageParameter
    {
      :name => "page",
      :description => "page in the array",
      :paramType => "query",
      :required => false,
      :allowMultiple => false,
      :dataType => "integer"
    }
  end

  def getPerPageParameter
    {
      :name => "per_page",
      :description => "count per page",
      :paramType => "query",
      :required => false,
      :allowMultiple => false,
      :dataType => "integer"
    }
  end

  def getPaginationModel
    {
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
    }
  end

  def getPaginatedArray(model)
    {
      :id => "Paginated#{model}s",
      :properties => {
        :page => {
          :type => "PaginationObject",
          :required => true,
        },
        :songs => {
          :type => "Array",
          :items => {
            "$ref" => "#{model}"
          },
          :required => true
        }
      }
    }
  end

  def getSongModel
    {
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
    }
  end

  def getAlbumModel
    getAlbumModelDetail(nil,nil)
  end

  def getAlbumModelDetail(key, value)
    r = {
      :id => "Album",
      :properties => {
        :id => {
          :type => "integer",
          :required => true
        },
        :name => {
          :type => "sting",
          :required => true
        },
        :length => {
          :type => "integer",
          :required => true
        },
        :tracks => {
          :type => "integer",
          :required => true
        },
        :art => {
          :type => "string",
          :required => true
        },
        :artists => {
          :type => "string",
          :required => true
        }
      }
    }
    r[:properties][key] = value if key != nil and value != nil
    r
  end

  def getPlaylistModel(key, value)
    r = {
      :id => "Playlist",
      :properties => {
        :id => {
          :type => "integer",
          :required => true
        },
        :name => {
          :type => "string",
          :required => true
        },
        :length => {
          :type => "integer",
          :required => true
        }
      }
    }
    r[:properties][key] = value
    r
  end

  def getPaginationExplination
    "The actual results will be slightly different from what is shown here, try this out to see what it looks like! eg:</br>" +
    "<div class='model-signature'>" +
      "<div class='description'>" +
        "<span class='strong'>PaginatedItems [</span>" +
        "<div>" +
          "<span class='propType'>PaginationObject</span>,</br>" +
          "[<span class='propType'>Items</span>]" +
        "</div>" +
        "<span class='strong'>]</span>" +
      "</div>" +
    "</div>"
  end

  def index
    apiSpec = getApiSpec()
    apiSpec[:apis] = [
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
    render :json => apiSpec
  end

  def sessions
    apiSpec = getApiSpec()
    apiSpec[:resourcePath] = "/sessions"
    apiSpec[:apis] = [
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
    ]
    apiSpec[:models] = {
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
    render :json => apiSpec
  end

  def users
    apiSpec = getApiSpec()
    apiSpec[:resourcePath] = "/users"
    apiSpec[:apis] = [
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
    ]
    apiSpec[:models] = {
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
    render :json => apiSpec
  end

  def libraries
    apiSpec = getApiSpec()
    apiSpec[:resourcePath] = "/libraries"
    apiSpec[:apis] = [
      {
        :path => "/libraries",
        :description => "Libraries of songs",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "Current list of libraries",
            :responseClass => "List[Library]",
            :nickname => "listLibraries",
            :parameters => [ getSessionParameter ],
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
              getSessionParameter,
              {
                :description => "A Library Prototype",
                :paramType => "body",
                :required => true,
                :allowMultiple => false,
                :dataType => "LibraryPrototype"
              }
            ],
            :errorResponses => [ getInvalidSession ]
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
            :parameters => [ getSessionParameter, getIdParameter('library') ],
            :errorResponses => [ getInvalidSession, getNotFound('Library') ]
          },
          {
            :httpMethod => "put",
            :summary => "Update a library",
            :responseClass => "Library",
            :nickname => "updateLibrary",
            :parameters => [ getSessionParameter, getIdParameter('library'),
              {
                :description => "A Library Prototype",
                :paramType => "body",
                :required => true,
                :allowMultiple => false,
                :dataType => "LibraryPrototype"
              }
            ],
            :errorResponses => [ getInvalidSession, getNotFound('Library') ]
          },
          {
            :httpMethod => "delete",
            :summary => "Delete a library",
            :responseClass => "void",
            :nickname => "deleteLibrary",
            :parameters => [ getSessionParameter, getIdParameter('library') ],
            :errorResponses => [ getInvalidSession, getNotFound('Library') ]
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
            :parameters => [ getSessionParameter, getIdParameter('library') ],
            :errorResponses => [ getInvalidSession, getNotFound('Library') ]
          }
        ]
      }
    ]
    apiSpec[:models] = {
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
    render :json => apiSpec
  end

  def songs
    apiSpec = getApiSpec()
    apiSpec[:resourcePath] = "/songs"
    apiSpec[:apis] = [
      {
        :path => "/songs",
        :description => "paginated list of songs",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "paginated list of songs",
            :responseClass => "PaginatedSongs",
            :notes => getPaginationExplination,
            :nickname => "listSongs",
            :parameters => [ getSessionParameter, getPageParameter, getPerPageParameter ],
            :errorResponses => [ getInvalidSession ]
          }
        ]
      },
      {
        :path => "/songs/{id}",
        :description => "a song",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "a single song",
            :responseClass => "Song",
            :nickname => "song",
            :parameters => [ getSessionParameter, getIdParameter('song') ],
            :errorResponses => [ getInvalidSession, getNotFound('Song') ]
          }
        ]
      },
      {
        :path => "/songs/{id}/stream",
        :notes => "Attempting to use this from within swagger ui will lock up the page!",
        :description => "stream a song",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "stream a song",
            :responseClass => "inline audio file",
            :nickname => "streamSong",
            :parameters => [ getSessionParameter, getIdParameter('song') ],
            :errorResponses => [ getInvalidSession, getNotFound('Song') ]
          }
        ]
      }
    ]
    apiSpec[:models] = {
      :Song => getSongModel,
      :PaginationObject => getPaginationModel,
      :PaginatedSongs => getPaginatedArray('Song')
    }
    render :json => apiSpec
  end

  def albums
    apiSpec = getApiSpec
    apiSpec[:resourcePath] = "/albums"
    apiSpec[:apis] = [
      {
        :path => "/albums",
        :description => "paginated list of albums",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "paginated list of albums",
            :responseClass => "PaginatedAlbums",
            :notes => getPaginationExplination,
            :nickname => "listSongs",
            :parameters => [ getSessionParameter, getPageParameter, getPerPageParameter ],
            :errorResponses => [ getInvalidSession ]
          }
        ]
      },
      {
        :path => "/albums/{id}",
        :description => "a album",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "a single album",
            :responseClass => "AlbumDetail",
            :nickname => "song",
            :parameters => [ getSessionParameter, getIdParameter('Album') ],
            :errorResponses => [ getInvalidSession, getNotFound('Album') ]
          }
        ]
      }
    ]
    apiSpec[:models] = {
      :Album => getAlbumModel,
      :AlbumDetail => getAlbumModelDetail(
        :songs, {
          :type => "Array",
          :items => {
            "$ref" => "Song"
          },
          :required => true
        }
      ),
      :Song => getSongModel,
      :PaginationObject => getPaginationModel,
      :PaginatedAlbums => getPaginatedArray('Album')
    }
    render :json => apiSpec
  end

  def genres
    apiSpec = getApiSpec
    apiSpec[:resourcePath] = "/genres"
    apiSpec[:apis] = [
      {
        :path => "/genres",
        :description => "a list of genres",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "a list of genres",
            :responseClass => "List[Genre]",
            :nickname => "listGenres",
            :parameters => [ getSessionParameter ],
            :errorResponses => [ getInvalidSession ]
          }
        ]
      },
      {
        :path => "/genres/{id}/songs",
        :description => "a list of songs in a genre",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "a list of songs in a genre",
            :responseClass => "PaginatedSongs",
            :notes => getPaginationExplination,
            :nickname => "listGenres",
            :parameters => [ getSessionParameter, getIdParameter('genre') ],
            :errorResponses => [ getInvalidSession, getNotFound('genre') ]
          }
        ]
      }
    ]
    apiSpec[:models] = {
      :Genre => {
        :id => "Genre",
        :properties => {
          :id => {
            :type => "integer",
            :required => true
          },
          :name => {
            :type => "string",
            :required => true
          },
          :songs => {
            :type => "integer",
            :required => true
          }
        }
      },
      :Song => getSongModel,
      :PaginationObject => getPaginationModel,
      :PaginatedSongs => getPaginatedArray('Song')
    }
    render :json => apiSpec
  end

  def playlists
    apiSpec = getApiSpec
    apiSpec[:resourcePath] = "/playlists"
    apiSpec[:apis] = [
      {
        :path => "/playlists",
        :description => "a list playlists",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "a list playlists",
            :responseClass => "List[Playlist]",
            :nickname => "listPlaylists",
            :parameters => [ getSessionParameter ],
            :errorResponses => [ getInvalidSession ]
          }
        ]
      },
      {
        :path => "/playlists/{id}",
        :description => "a detailed playlist",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "a detailed playlist",
            :responseClass => "PlaylistDetail",
            :nickname => "playlistDetail",
            :parameters => [ getSessionParameter, getIdParameter('playlist') ],
            :errorResponses => [ getInvalidSession, getNotFound('playlist') ]
          }
        ]
      }
    ]
    apiSpec[:models] = {
      :Playlist => getPlaylistModel(
        :songs, {
          :type => "integer",
          :required => true
        }
      ),
      :PlaylistDetail => getPlaylistModel(
        :songs, {
          :type => "Array",
          :required => true,
          :items => {
            "$ref" => "Song"
          }
        }
      ),
      :Song => getSongModel
    }
    render :json => apiSpec
  end

  def artists
    apiSpec = getApiSpec
    apiSpec[:resourcePath] = "/artists"
    apiSpec[:apis] = [
      {
        :path => "/artists",
        :description => "a list artists",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "a list artists",
            :responseClass => "PaginatedArtists",
            :notes => getPaginationExplination,
            :nickname => "listArtists",
            :parameters => [ getSessionParameter ],
            :errorResponses => [ getInvalidSession ]
          }
        ]
      },
      {
        :path => "/artists/{id}/albums",
        :description => "a paginated list of artists' albmus",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "a paginated list of artists' albmus",
            :responseClass => "PaginatedAlbums",
            :notes => getPaginationExplination,
            :nickname => "artistAlbums",
            :parameters => [ getSessionParameter, getIdParameter('artists') ],
            :errorResponses => [ getInvalidSession, getNotFound('artists') ]
          }
        ]
      },
      {
        :path => "/artists/{id}/songs",
        :description => "a paginated list of artists' songs",
        :operations => [
          {
            :httpMethod => "get",
            :summary => "a paginated list of artists' songs",
            :responseClass => "PaginatedSongs",
            :notes => getPaginationExplination,
            :nickname => "artistSongs",
            :parameters => [ getSessionParameter, getIdParameter('artists') ],
            :errorResponses => [ getInvalidSession, getNotFound('artists') ]
          }
        ]
      }
    ]
    apiSpec[:models] = {
      :Artist => {
        :id => "Artist",
        :properties => {
          :id => {
            :type => "integer",
            :required => true
          },
          :name => {
            :type => "string",
            :required => true
          },
          :songs => {
            :type => "integer",
            :required => true
          },
          :albums => {
            :type => "integer",
            :required => true
          },
          :art => {
            :type => "string",
            :required => true
          }
        }
      },
      :Album => getAlbumModel,
      :Song => getSongModel,
      :PaginationObject => getPaginationModel,
      :PaginatedAlbums => getPaginatedArray('Album'),
      :PaginatedSongs => getPaginatedArray('Song'),
      :PaginatedArtists => getPaginatedArray('Artist')
    }
    render :json => apiSpec
  end
end
