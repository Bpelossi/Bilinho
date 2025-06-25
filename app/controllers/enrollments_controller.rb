class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all

    if params[:id].present?
      @enrollments = @enrollments.where("id LIKE ?", "%#{params[:id]}%")
    end

    if params[:student_id].present?
      @enrollments = @enrollments.where("student_id LIKE ?", "%#{params[:student_id]}%")
    end

    if params[:institution_id].present?
      @enrollments = @enrollments.where("institution_id LIKE ?", "%#{params[:institution_id]}%")
    end

    if params[:course_name].present?
      @enrollments = @enrollments.where("LOWER(course_name) LIKE ?", "%#{params[:course_name].downcase}")
    end
  end

  def show
    @enrollment = Enrollment.find(params[:id])
    @invoices = @enrollment.invoices.order(:invoice_due_date)
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      redirect_to @enrollment, notice: "Matrícula criada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @enrollment = Enrollment.find(params[:id])
  end

  def update
    @enrollment = Enrollment.find(params[:id])
    if @enrollment.update(student_params)
      redirect_to @enrollment, notice: "Matrícula atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    @enrollment.destroy
    redirect_to enrollment_path, notice: "Matrícula removido!"
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:full_price, :number_of_installments, :due_day, :course_name, :institution_id, :student_id)
  end
end
