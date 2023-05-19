class BranchesController < ApplicationController
  before_action :authenticate_user!#, except: %i[ index show ]
  before_action :check_admin, only: %i[ edit update destroy new ]
  before_action :set_branch, only: %i[ show edit update destroy ]
  before_action :set_users, only: %i[ new edit create]

  # GET /branches or /branches.json
  def index
    if current_user.role == 'admin'
      @branches = Branch.all
    else
      @branches = Branch.where(user_id: current_user.id)
    end

    @branches = @branches.order(updated_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /branches/1 or /branches/1.json
  def show
  end

  # GET /branches/new
  def new
    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
  end

  # POST /branches or /branches.json
  def create
    @branch = Branch.new(branch_params)

    respond_to do |format|
      if @branch.save
        format.html { redirect_to branch_url(@branch), notice: t('flash.actions.create.notice', resource_name: t('branch.one')) }
        format.json { render :show, status: :created, location: @branch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1 or /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to branch_url(@branch), notice: t('flash.actions.update.notice', resource_name: t('branch.one')) }
        format.json { render :show, status: :ok, location: @branch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1 or /branches/1.json
  def destroy
    @branch.destroy

    respond_to do |format|
      format.html { redirect_to branches_url, notice: t('flash.actions.destroy.notice', resource_name: t('branch.one')) }
      format.json { head :no_content }
    end
  end

  private

    def check_admin
      raise unless current_user.role == 'admin'
    rescue StandardError => _e
      respond_to do |format|
        format.html { redirect_to branches_url, alert: "You do not have permissions for this action" }
        format.json { head :no_content }
      end
    end

    def set_branch
      if current_user.role == 'admin'
        @branch = Branch.find(params[:id])
      else
        @branch = current_user.branches.find_by(id: params[:id])
      end
      redirect_to branches_path, notice: t('errors.not_authorized') if @branch.nil?
    rescue StandardError => e
      respond_to do |format|
        format.html { redirect_to branches_url, alert: t('message.not_found', attribute: t('branch.one')) }
        format.json { head :no_content }
      end
    end

    def set_users
      @users = User.all.pluck(:email, :id)
    end

    def branch_params
      params.require(:branch).permit(:id, :fridge, :temperature, :user_id)
    end
end
