class StaticPagesController < ApplicationController
  before_action :logged_in_user, except: [:signup]

  def home
    @photos = Photo.all.reverse
  end

  def help
  end

  def about

  end

  def tutorial
  	render "static_pages/tutorial_page_#{params[:id]}", layout: "home_layout"
  end

  def signup
    render layout: 'home_layout'
  end
end
