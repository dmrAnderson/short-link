class Api::V1::LinksController < ApplicationController
  before_action :set_link, except: :create

  def show
    if @link.password.eql?(params[:password])
      @link.update(quantity_visit: @link.quantity_visit + 1)
      render json: { status: "SUCCESS",
                    message: "Loaded link",
                    full_link: @link.full_name }, status: :ok
    else
      render json: { status: "ERROR", message: "Incorrect password" },
                   status: :unprocessable_entity
    end
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      render json: {
        status: "SUCCESS", message: "Saved link",
        data: @link.as_json(only: %i[full_name short_name password])
      }, status: :created
    else
      render json: { status: "ERROR", message: "Link not saved" },
                   status: :unprocessable_entity
    end
  end

  def destroy
    if @link.password.eql?(params[:password])
      @link.destroy
      render json: { status: "SUCCESS", message: "Deleted link" },
                   status: :ok
    else
      render json: { status: "ERROR", message: "Incorrect password" },
                   status: :unprocessable_entity
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
      params.require(:link).permit(:full_name)
    end
end
