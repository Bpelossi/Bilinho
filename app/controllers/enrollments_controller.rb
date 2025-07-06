class EnrollmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

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

    respond_to do |format|
      format.html
      format.json { render json: @enrollments }
    end
  end

  def show
    @enrollment = Enrollment.find(params[:id])
    @invoices = @enrollment.invoices.order(:invoice_due_date)

    respond_to do |format|
      format.html
      format.json { render json: { enrollment: @enrollment, invoices: @invoices } }
    end    
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      respond_to do |format|
        format.html { redirect_to @enrollment, notice: "Matrícula criada com sucesso!" }
        format.json { render json: @enrollment, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @enrollment.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @enrollment = Enrollment.find(params[:id])
  end

  def update
    @enrollment = Enrollment.find(params[:id])
    if @enrollment.update(enrollment_params)
      respond_to do |format|
        format.html { redirect_to @enrollment, notice: "Matrícula atualizada com sucesso!" }
        format.json { render json: @enrollment }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @enrollment.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    if @enrollment.update(status: "disabled")
      @enrollment.invoices.where(status: "open").update_all(status: "disabled")
      respond_to do |format|
        format.html { redirect_to @enrollment, notice: "Matrícula desativada com sucesso!" }
        format.json { render json: { message: "Matrícula desativado com sucesso." }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @enrollment.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:full_price, :number_of_installments, :due_day, :course_name, :institution_id, :student_id)
  end
end
