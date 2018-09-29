class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(plan_id: params[:plan_id])
    redirect_to plans_url, notice: "#{favorite.plan.user.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to plans_url, notice: "#{favorite.plan.user.name}さんの投稿をお気に入り解除しました"
  end
end
