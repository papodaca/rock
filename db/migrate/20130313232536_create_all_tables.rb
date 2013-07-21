class CreateAllTables < ActiveRecord::Migration
  def change

    create_table :albums do |t|
      t.string :name
      t.references :art
      t.references :artist

      t.timestamps
    end

    create_table :artists do |t|
      t.string :name
      t.references :art

      t.timestamps
    end

    create_table :arts do |t|
      t.references :data_file

      t.timestamps
    end

    create_table :data_files do |t|
      t.string :path

      t.references :media_type

      t.timestamps
    end

    create_table :genres do |t|
      t.string :name

      t.timestamps
    end

    create_table :libraries do |t|
      t.string :name
      t.integer :progress

      t.references :data_file

      t.timestamps
    end

    create_table :media_types do |t|
      t.string :mime_type
      t.string :extension
      t.boolean :audio
      t.boolean :image
      t.boolean :feed

      t.timestamps
    end

    create_table :playlist_elements do |t|
      t.integer :order

      t.references :playlist
      t.references :song

      t.timestamps
    end

    create_table :playlists do |t|
      t.string :name

      t.timestamps
    end

    create_table :podcast_episodes do |t|
      t.references :podcast
      t.references :song

      t.timestamps
    end

    create_table :podcasts do |t|
      t.string :name

      t.references :data_file

      t.timestamps
    end

    create_table :roles do |t|
      t.string :name
      t.integer :level

      t.timestamps
    end

    create_table :sessions do |t|
      t.string :session_key

      t.references :user

      t.timestamps
    end

    add_index :sessions, :session_key

    create_table :songs do |t|
      t.string :title
      t.integer :track
      t.integer :disk
      t.integer :length

      t.references :album
      t.references :genre
      t.references :artist
      t.references :data_file
      t.references :library

      t.timestamps
    end

    create_table :user_podcast_episodes do |t|
      t.integer :location
      t.boolean :played

      t.references :user
      t.references :podcast_eposode

      t.timestamps
    end

    create_table :user_podcast_subscriptions do |t|
      t.references :user
      t.references :podcast

      t.timestamps
    end

    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :password_salt
      
      t.references :role

      t.timestamps
    end

    add_index :users, :email, :unique => true

  end
end
