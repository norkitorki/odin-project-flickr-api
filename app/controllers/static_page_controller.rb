require 'flickr'

class StaticPageController < ApplicationController
  FLICKR = Flickr.new

  def index
    if params[:commit]

  private

  def flickr_params
    params.permit(:user_id, :size, :commit)
  end

  def query_user(user_id)
    FLICKR.people.getInfo(user_id: user_id)
  end

  def query_photos(user_id)
    FLICKR.people.getPublicPhotos(user_id: user_id, extras: 'date_upload', per_page: 500)
  end

  def photos_by_year(photos)
    photos.each_with_object(Hash.new { |h, k| h[k] = [] }) do |photo, hash|
      upload_year = Time.at(photo['dateupload'].to_i).year
      hash[upload_year] << photo
    end
  end
end
