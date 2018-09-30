class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    
    if @review.save
      # ContactMailer.contact_mail(@plan).deliver
      redirect_to plans_path, notice: 'レビューの投稿が完了しました！'
    else
      redirect_to plans_path, notice: 'レビューの投稿ができませんでした。'
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:comment, :plan_id)
  end
end
