class CronController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_filter :require_login
  def process(origin)
    if params['cron_password'] == $APP_CONFIG['cron_password']
      result = "Libraries:\n"
      result += scan_libraries() + "\n"
      result += "Podcasts:\n"
      result += update_podcasts() + "\n"

      render :text => result + "OK!\n"
    else
      render :text => "unauthorized", :status => 401
    end
  end

  def scan_libraries
    result = ""
    Library.all.each do |library|
      LibraryWorker.perform_async(library.id)
      result += "\tQueued: #{library.name} - #{library.data_file.path}\n"
    end
    return result
  end

  def update_podcasts
    result = ""
    Podcast.all.each do |podcast|
      PodcastWorker.perform_async(podcast.id)
      result += "\tQueued: #{podcast.name} - #{podcast.data_file.path}\n"
    end
    return result
  end
end