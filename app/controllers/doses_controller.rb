class DosesController < ApplicationController
  before_action :dose_params, only: [:create]
  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def create
    @dose = Dose.new(dose_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = @cocktail
    @dose.ingredient = Ingredient.find(dose_params[:ingredient_id])

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])
    @dose.destroy

    redirect_to cocktail_path(@cocktail)
  end
  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id, :cocktail_id, :photo, :photo_cache)
  end
end

