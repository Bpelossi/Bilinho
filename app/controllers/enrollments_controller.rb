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

    if params[:status].present? && params[:status] == "disabled"
      @enrollments = @enrollments.where(status: params[:status])
    elsif params[:status].present? && params[:status] == "enabled" || !params[:status].present?
      @enrollments = @enrollments.where(status: "enabled")
    else
      @enrollments
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
    if @enrollment.update(status: "disabled")
      @enrollment.invoices.where(status: "open").update_all(status: "disabled")
      redirect_to @enrollment, notice: "Matrícula atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:full_price, :number_of_installments, :due_day, :course_name, :institution_id, :student_id)
  end
end
