class InvoicesController < ApplicationController
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
  end


  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: "Instituição atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.update(status: "disabled")
      redirect_to @invoice, notice: "Instituição desabilitada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:invoice_price, :invoice_due_date, :status, :enrollment_id)
  end
end
