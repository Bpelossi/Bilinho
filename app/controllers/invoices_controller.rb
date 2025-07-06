class InvoicesController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  def index
    @invoices = Invoice.all

    if params[:id].present?
      @invoices = @invoices.where("id LIKE ?", "%#{params[:id]}%")
    end

    if params[:invoice_price].present?
      @invoices = @invoices.where("invoice_price LIKE ?", "%#{params[:invoice_price]}%")
    end

    if params[:invoice_due_date].present?
      @invoices = @invoices.where("invoice_due_date LIKE ?", "%#{params[:invoice_due_date]}%")
    end

    if params[:status].present?
      @invoices = @invoices.where(status: params[:status])
    end

    respond_to do |format|
      format.html
      format.json { render json: @invoices }
    end
  end


  def show
    @invoice = Invoice.find(params[:id])
    @enrollment = @invoice.enrollment
    @parcel_number = @enrollment.invoices.order(:invoice_due_date).pluck(:id).index(@invoice.id) + 1
    @total_parcels = @enrollment.number_of_installments

    respond_to do |format|
      format.html
      format.json do
        render json: {
          invoice: @invoice,
          enrollment: @enrollment,
          parcel_number: @parcel_number,
          total_parcels: @total_parcels
        }
      end
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update(invoice_params)
      respond_to do |format|
        format.html { redirect_to @invoice, notice: "Fatura atualizada com sucesso!" }
        format.json { render json: @invoice }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @invoice.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.update(status: "disabled")
      respond_to do |format|
        format.html { redirect_to @invoice, notice: "Fatura desabilitada com sucesso!" }
        format.json { render json: { message: "Invoice desativado com sucesso." }, status: :ok }
      end 
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @invoice.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:invoice_price, :invoice_due_date, :status, :enrollment_id)
  end
end
