class InstitutionsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  def index
    @institutions = Institution.all

    if params[:id].present?
      @institutions = @institutions.where("id LIKE ?", "%#{params[:id]}%")
    end

    if params[:name].present?
      @institutions = @institutions.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%")
    end

    if params[:cnpj].present?
      @institutions = @institutions.where("cnpj LIKE ?", "%#{params[:cnpj]}%")
    end

    if params[:institution_type].present?
      @institutions = @institutions.where(institution_type: params[:institution_type])
    end

    if params[:status].present? && params[:status] == "disabled"
      @institutions = @institutions.where(status: params[:status])
    elsif params[:status].present? && params[:status] == "enabled" || !params[:status].present?
      @institutions = @institutions.where(status: "enabled")
    else
      @institutions
    end

    respond_to do |format|
      format.html
      format.json { render json: @institutions }
    end
  end


  def show
    @institution = Institution.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @institution }
    end
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params.merge(status: "enabled"))
    if @institution.save
      respond_to do |format|
        format.html { redirect_to @institution, notice: "Instituição criada com sucesso!" }
        format.json { render json: @institution, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @institution.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @institution = Institution.find(params[:id])
  end

  def update
    @institution = Institution.find(params[:id])
    if @institution.update(institution_params)
      respond_to do |format|
        format.html { redirect_to @institution, notice: "Instituição atualizada com sucesso!" }
        format.json { render json: @institution }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @institution.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @institution = Institution.find(params[:id])
    if @institution.update(status: "disabled")
      respond_to do |format|
        format.html { redirect_to @institution, notice: "Instituição atualizada com sucesso!" }
        format.json { render json: { message: "Instituição desativado com sucesso." }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @institution.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def search
    query = params[:q].to_s.downcase
    institutions = Institution.where("lower(name) LIKE ?", "%#{query}%").limit(20).select(:id, :name)
    render json: institutions
  end

  private

  def institution_params
    params.require(:institution).permit(:name, :cnpj, :institution_type)
  end
end
