require 'flickr'

class StaticPageController < ApplicationController
  FLICKR = Flickr.new
  EXTRAS = 'date_upload, url_m'

  def index
    if params[:commit]
      begin
        @user = query_user(flickr_params[:user_id])
        @photos = query_photos(flickr_params[:user_id])
        @photos_by_year = photos_by_year(@photos)
        @size = flickr_params[:size]
      rescue Flickr::FailedResponse
        redirect_to root_path, status: :see_other, alert: 'Unable to find a user with the provided user id.'
      end
    end
  end

  private

  def flickr_params
    params.permit(:user_id, :size, :commit)
  end

  def query_user(user_id)
    FLICKR.people.getInfo(user_id: user_id)
  end

  def user_photos(user_id)
    FLICKR.people.getPublicPhotos(user_id: user_id, extras: EXTRAS, per_page: 500)
  end

  def recent_photos
    FLICKR.photos.getRecent(extras: EXTRAS, per_page: 500)
  end

  def photos_by_year(photos)
    photos.each_with_object(Hash.new { |h, k| h[k] = [] }) do |photo, hash|
      upload_year = Time.at(photo['dateupload'].to_i).year
      hash[upload_year] << photo
    end
  end
end
