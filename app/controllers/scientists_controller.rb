class ScientistsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        scientists = Scientist.all
        render json: scientists, status: 200
    end

    def show
        render json: find_scientist, status: 200
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: 201
    end

    def update
        find_scientist.update!(scientist_params)
        render json: find_scientist, status: 202
    end

    def destroy
        find_scientist.destroy
        head :no_content
    end

    private

    def find_scientist
        Scientist.find(params[:id])
    end

    def render_not_found
        render json: { error: "Scientist not found" }, status: 404
    end

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end
end
