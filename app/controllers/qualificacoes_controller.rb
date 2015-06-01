class QualificacoesController < ApplicationController
  before_action :set_qualificacao, only: [:show, :edit, :update, :destroy]

  def index
    @qualificacoes = Qualificacao.all
  end

  def show
  end

  def new
    preparar_form
    @qualificacao = Qualificacao.new
    
    if params[:cliente]
      @qualificacao.cliente = Cliente.find(params[:cliente]) 
    end
    if params[:restaurante]
      @qualificacao.restaurante = Restaurante.find(params[:restaurante])
    end

    respond_to do |format|
      format.html
      format.xml { render :xml => @qualificacao }
    end
  end

  def edit
    preparar_form
  end

  def create
    @qualificacao = Qualificacao.new(qualificacao_params)

    respond_to do |format|
      if @qualificacao.save
        format.html { redirect_to @qualificacao, notice: 'Qualificacao was successfully created.' }
        format.json { render :show, status: :created, location: @qualificacao }
      else
        preparar_form
        format.html { render :new }
        format.json { render json: @qualificacao.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @qualificacao.update(qualificacao_params)
        format.html { redirect_to @qualificacao, notice: 'Qualificacao was successfully updated.' }
        format.json { render :show, status: :ok, location: @qualificacao }
      else
        preparar_form
        format.html { render :edit }
        format.json { render json: @qualificacao.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @qualificacao.destroy
    respond_to do |format|
      format.html { redirect_to qualificacoes_url, notice: 'Qualificacao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_qualificacao
      @qualificacao = Qualificacao.find(params[:id])
    end

    def qualificacao_params
      params.require(:qualificacao).permit(:cliente_id, :restaurante_id, :nota, :valor_gasto)
    end

    def preparar_form
      @clientes = Cliente.order(:nome)
      @restaurantes = Restaurante.order(:nome)      
    end
end