class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  def index
    @students = Student.all

    if params[:id].present?
      @students = @students.where("id LIKE ?", "%#{params[:id]}%")
    end

    if params[:name].present?
      @students = @students.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%")
    end

    if params[:cpf].present?
      @students = @students.where("cpf LIKE ?", "%#{params[:cpf]}%")
    end

    if params[:gender].present?
      @students = @students.where(gender: params[:gender])
    end

    if params[:status].present? && params[:status] == "disabled"
      @students = @students.where(status: params[:status])
    elsif params[:status].present? && params[:status] == "enabled" || !params[:status].present?
      @students = @students.where(status: "enabled")
    else
      @students
    end

    respond_to do |format|
      format.html
      format.json { render json: @students }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @student }
    end
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params.merge(status: "enabled"))
    if @student.save
      respond_to do |format|
        format.html { redirect_to @student, notice: "Aluno criado com sucesso!" }
        format.json { render json: @student, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit;  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      respond_to do |format|
        format.html { redirect_to @student, notice: "Aluno atualizado com sucesso!" }
        format.json { render json: @student }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student = Student.find(params[:id])
    if @student.update(status: "disabled")
      respond_to do |format|
        format.html { redirect_to students_path, notice: "Aluno desativado com sucesso!" }
        format.json { render json: { message: "Aluno desativado com sucesso." }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to @student, alert: "Não foi possível desativar o aluno." }
        format.json { render json: @student.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def search
    query = params[:q].to_s.downcase
    students = Student.where("lower(name) LIKE ?", "%#{query}%").limit(20).select(:id, :name)
    render json: students
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :cpf, :birthday, :phone, :gender, :payment_method)
  end
end
