class ContractorsController < ApplicationController
  before_action :set_contractor, only: [:show, :update, :destroy]

  # GET /contractors
  def index
    @contractors = Contractor.all

    render json: {
      contractors: @contractors.map do |contractor|
        {
          id: contractor.id,
          first_name: contractor.first_name,
          last_name: contractor.last_name,
          address: contractor.address,
          background_check: contractor.background_check,
          contractor_image: contractor.contractor_image.url,
          ratings: contractor.ratings.map do |rating|
            {
              id: rating.id,
              value: rating.value,
              review_text: rating.review_text
            }
          end
        }
      end
    }
  end

  # GET /contractors/1
  def show
    render json: {
      contractor: {
        id: @contractor.id,
        first_name: @contractor.first_name,
        last_name: @contractor.last_name,
        address: @contractor.address,
        background_check: @contractor.background_check,
        contractor_image: @contractor.contractor_image.url,
        ratings: @contractor.ratings.map do |rating|
          {
            id: rating.id,
            value: rating.value,
            review_text: rating.review_text
          }
        end
      }
    }
  end

  # POST /contractors
  def create
    @contractor = Contractor.new(contractor_params)

    if @contractor.save
      render json: @contractor, status: :created, location: @contractor
    else
      render json: @contractor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contractors/1
  def update
    if @contractor.update(contractor_params)
      render json: @contractor
    else
      render json: @contractor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contractors/1
  def destroy
    @contractor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contractor
      @contractor = Contractor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contractor_params
      params.require(:contractor).permit(:first_name, :last_name, :background_check)
    end
end
