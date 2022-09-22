require 'flickr'

class StaticPageController < ApplicationController
  before_action { @flickr = Flickr.new }

  def index
    if params[:commit]
      @photos = @flickr.photos.search(format: :json, user_id: params[:user_id], per_page: 500)
    end
  end
end
