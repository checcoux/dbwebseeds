class HomeworksController < ApplicationController
  before_action :set_homework, only: [:show, :edit, :update, :destroy]

  # GET /homeworks
  # GET /homeworks.json
  def index
    @homeworks = Homework.where(user_id: current_user)

    @page = trova_home
  end

  # GET /homeworks/1
  # GET /homeworks/1.json
  def show
    @page = trova_home
  end

  # GET /homeworks/new
  def new
    @assignment = Assignment.find_by! key: params[:key]

    @page = trova_home

    if @assignment.stato == 1
      @homework = Homework.new
      @homework.assignment = @assignment
    else
      redirect_to "/assignments/#{ @assignment.key }", notice: 'La fase di consegna di questo compito è conclusa.'
    end

  end

  # GET /homeworks/1/edit
  def edit
    @page = trova_home
  end

  # POST /homeworks
  # POST /homeworks.json
  def create
    @homework = Homework.new(homework_params)
    @homework.user = current_user
    @assignment = @homework.assignment

    respond_to do |format|
      if @homework.save
        format.html { redirect_to "/assignments/#{ @assignment.key }", notice: 'Il tuo elaborato è stato consegnato, ora attendi la valutazione.' }
        format.json { render :show, status: :created, location: @homework }
      else
        format.html { render :new }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homeworks/1
  # PATCH/PUT /homeworks/1.json
  def update
    @assignment = @homework.assignment

    respond_to do |format|
      if @homework.update(homework_params)
        format.html { redirect_to "/assignments/#{ @assignment.key }", notice: 'Le tue modifiche sono state salvate, ora attendi la valutazione.' }
        format.json { render :show, status: :ok, location: @homework }
      else
        format.html { render :edit }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homeworks/1
  # DELETE /homeworks/1.json
  def destroy
    @homework.destroy
    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: 'Homework was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homework
      @homework = Homework.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def homework_params
      params.require(:homework).permit(:assignment_id, :user_id, :url, :note, :voto, :key)
    end
end
