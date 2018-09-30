class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:new, :edit, :show, :destroy, :index]
  before_action :log_in, only: [:new, :edit, :destroy]
  
  def top
    @plans = Plan.where(sample_flag: 1).last(3)
  end
  
  def index
    @plans = Plan.all
    @search = Plan.ransack(params[:q])
    @plans = @search.result
    render 'index'
  end

  def new
    if params[:back]
      @plan = Plan.new(plan_params)
    else
      @plan = Plan.new
    end
  end
    
  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    if @plan.save
      # ContactMailer.contact_mail(@plan).deliver
      redirect_to plans_path, notice: '新規作成しました！'
    else
      render 'new'
    end
  end
  
  def show
    @plan = Plan.find_by(id: @plan.id)
    @reviews = Review.where(plan_id: @plan.id)
    if logged_in?
      @favorite = current_user.favorites.find_by(plan_id: @plan.id)
    end
  end
  
  def edit
    @plan.image.cache! unless @plan.image.blank?
  end
  
  def update
    if @plan.update(plan_params)
      redirect_to plans_path, notice:'編集しました！'
    else
      render 'edit'
    end
  end
  
  def destroy
    @plan.destroy
      redirect_to plans_path, notice:'削除しました！'
  end
  
  def confirm
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id
    render 'new'if @plan.invalid?
  end
  
  def log_in
    if @current_user.nil?
      redirect_to new_session_path
    end
  end  
    
  private
  
  def plan_params
    params.require(:plan).permit(:title, :content, :sample_flag, :image, :image_cache)
  end
    
  def set_plan
    @plan = Plan.find(params[:id])
  end
end