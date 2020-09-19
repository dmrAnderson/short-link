class Api::V1::LinksController < ApplicationController
  before_action :set_link, except: :create
  before_action :check_password, except: :create
  protect_from_forgery with: :null_session

  def show
    @link.update(quantity_visit: @link.quantity_visit + 1)
    render :show, status: :ok
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      render :show, status: :created
    else
      render json: { msg: "Invalid format" }, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      render :show, status: :ok
    else
      render json: { msg: "Invalid format" }, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
    render json: { msg: "Link deleted" }, status: :ok
  end

  private

    def set_link
      if !(@link = Link.find_by(short_name: params[:short_name])).nil?
        @link
      else
        render json: { status: "ERROR", message: "Not found" },
                     status: :not_found
      end
    end

    def check_password
      unless @link.password.eql?(params[:password])
        render json: { msg: "Incorrect password" },
                     status: :forbidden and return
      end
    end

    def link_params
      params.permit(:full_name)
    end
end
