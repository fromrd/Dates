class ReviewsController < ApplicationController
  def new
    @review = Review.new
    # @plan_id = params[:plan_id] 
    # @review.plan_id = params[:format]
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    # @review.plan_id = @plan.id
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
