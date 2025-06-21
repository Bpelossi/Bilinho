class InstitutionsController < ApplicationController
  def index
    @institutions = Institution.all
  end

  def show
    @institution = Institution.find(params[:id])
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      redirect_to @institution, notice: "Instituição criada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @institution = Institution.find(params[:id])
  end

  def update
    @institution = Institution.find(params[:id])
    if @institution.update(institution_params)
      redirect_to @institution, notice: "Instituição atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @institution = Institution.find(params[:id])
    @institution.destroy
    redirect_to institutions_path, notice: "Instituição removida!"
  end

  private

  def institution_params
    params.require(:institution).permit(:name, :cnpj, :institution_type)
  end
end
