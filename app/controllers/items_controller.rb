class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
      render json: items
    else 
      items = Item.all
      render json: items, include: :user
    end
  rescue ActiveRecord::RecordNotFound => e
    render status: :not_found
  end

  def show
    item = Item.find(params[:id])
    render json: item, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render status: :not_found
  end

  def create
    user = User.find(params[:user_id])
    # item = Item.create(params_valid)
    # user.items << item
    item = user.items.create(params_valid)
    render json: item, status: 201
  end

  private

  def params_valid
    params.permit(:name, :description, :price)
  end

end
