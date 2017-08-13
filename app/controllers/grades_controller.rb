class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]

  # GET /grades
  # GET /grades.json
  def index
    @grades = Grade.all
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
    @homework = @grade.homework
    @assignment = @homework.assignment

    @page = trova_home
  end

  # GET /grades/new
  def new
    @homework = Homework.find(params[:homework_id])
    @assignment = @homework.assignment

    @grade = Grade.new
    @grade.homework = @homework

    @page = trova_home
  end

  # GET /grades/1/edit
  def edit
    @homework = @grade.homework
    @assignment = @homework.assignment

    @page = trova_home
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)
    @grade.user = current_user

    @homework = @grade.homework
    @assignment = @homework.assignment

    respond_to do |format|
      if @grade.save
        format.html { redirect_to "/assignments/#{ @assignment.key }", notice: 'La tua valutazione è stata salvata, grazie!' }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    @homework = @grade.homework
    @assignment = @homework.assignment

    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to "/assignments/#{ @assignment.key }", notice: 'La tua valutazione è stata modificata, grazie!' }
        format.json { render :show, status: :ok, location: @grade }
      else
        format.html { render :edit }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to grades_url, notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:homework_id, :user_id, :p1, :p2, :p3, :p4, :p5, :p6, :p7, :p8, :p9, :p10, :note, :voto)
    end
end
