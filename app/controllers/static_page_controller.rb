require 'flickr'

class StaticPageController < ApplicationController
  FLICKR = Flickr.new

  def index
    if params[:commit]
      @photos = @flickr.photos.search(format: :json, user_id: params[:user_id], per_page: 500)
    end
  end
end
