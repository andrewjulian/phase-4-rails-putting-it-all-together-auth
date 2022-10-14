class RecipesController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  def index
    recipes = Recipe.all
    render json: recipes, include: :user
  end

  def create
    user = User.find_by(id: session[:user_id])
    recipe = user.recipes.create!(recipe_params)
    render json: recipe, include: :user, status: :created
  end

  private

  def recipe_params
    params.permit(:id, :title, :instructions, :minutes_to_complete)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: ["Invalid Data"] }, status: :unprocessable_entity
  end

end
