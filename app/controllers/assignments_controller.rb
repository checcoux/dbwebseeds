class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
    @page = trova_home
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = Assignment.find_by! key: params[:id]
    @homework = Homework.find_by user_id: current_user.id, assignment_id: @assignment.id

    # troviamo un elaborato da correggere
    if @assignment.stato == 2
      # seleziono gli homework che non sono dell'utente, li riordino casualmente e tolgo quelli per i quali ha già fatto una valutazione
      @dacorreggere = Homework.where("assignment_id = ? AND homeworks.user_id != ?", @assignment.id, current_user.id).shuffle - Homework.joins(:grades).where("grades.user_id = ?", current_user.id)
      @dacorreggere = @dacorreggere.first
    end

    @grades = Grade.where(user_id: current_user.id)

    @page = trova_home
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
    @assignment.key = rand(36**6).to_s(36).upcase
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.user_id = current_user.id if user_signed_in?

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to assignments_url }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to assignments_url }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:titolo, :key, :descrizione, :user_id, :criterio1, :criterio2, :criterio3, :criterio4, :criterio5, :criterio6, :criterio7, :criterio8, :criterio9, :criterio10, :stato)
    end
end
