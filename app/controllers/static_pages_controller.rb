class StaticPagesController < ApplicationController
  def home
  	render layout: 'home_layout'
  end

  def help
  end

  def about

  end

  def tutorial
  	render "static_pages/tutorial_page_#{params[:id]}", layout: "home_layout"
  end
end
