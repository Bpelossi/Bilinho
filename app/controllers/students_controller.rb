class StudentsController < ApplicationController
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
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params.merge(status: "enabled"))
    if @student.save
      redirect_to @student, notice: "Instituição criada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to @student, notice: "Instituição atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student = Student.find(params[:id])
    if @student.update(status: "disabled")
      redirect_to @student, notice: "Instituição atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    query = params[:q].to_s.downcase
    students = Student.where("lower(name) LIKE ?", "%#{query}%").limit(20).select(:id, :name)
    render json: students
  end

  private

  def student_params
    params.require(:student).permit(:name, :cpf, :birthday, :phone, :gender, :payment_method)
  end
end
