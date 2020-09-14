class LinksController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "admin"
  before_action :set_link, only: %i[show destroy]

  def index
    links = Link.all.paginate(page: params[:page], per_page: 6)
    @links =
      if !params[:commit].equal?("Search")
        search_link = Link.where(short_name: params[:short_name])
        search_link.present? ? search_link : links
      else
        links
      end
  end

  def show
    @link.update(quantity_visit: @link.quantity_visit + 1)
    redirect_to @link.full_name
  end

  def destroy
    @link.destroy
    redirect_to links_url
  end

  private

    def set_link
      if !(@link = Link.find_by(short_name: params[:short_name])).nil?
        @link
      else
        redirect_to :root
      end
    end
end
