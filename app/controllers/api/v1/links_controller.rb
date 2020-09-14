class Api::V1::LinksController < ApplicationController
  before_action :set_link, except: :create
  protect_from_forgery with: :null_session

  def show
    if @link.password.eql?(params[:password])
      @link.update(quantity_visit: @link.quantity_visit + 1)
      render :show, status: :ok
    else
      render json: { msg: "Incorrect password" }, status: :forbidden
    end
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
    if @link.password.eql?(params[:password])
      if @link.update(link_params)
        render :show, status: :ok
      else
        render json: { msg: "Invalid format" }, status: :unprocessable_entity
      end
    else
      render json: { msg: "Incorrect password" }, status: :forbidden
    end
  end

  def destroy
    if @link.password.eql?(params[:password])
      @link.destroy
      render json: { msg: "Link deleted" }, status: :ok
    else
      render json: { msg: "Incorrect password" }, status: :forbidden
    end
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

    def link_params
      params.permit(:full_name)
    end
end
