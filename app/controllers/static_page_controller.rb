require 'flickr'

class StaticPageController < ApplicationController
  FLICKR = Flickr.new

  def index
    if params[:commit]

  private

  def flickr_params
    params.permit(:user_id, :size, :commit)
  end
    end
  end
end
