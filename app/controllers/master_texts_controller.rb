class MasterTextsController < ApplicationController
  before_action :set_master_text, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_master_texts_section

  # GET /master_texts
  # GET /master_texts.json
  def index
    @master_texts = MasterText.all
  end

  # GET /master_texts/1
  # GET /master_texts/1.json
  def show
  end

  # GET /master_texts/new
  def new
    @master_text = MasterText.new
  end

  # GET /master_texts/1/edit
  def edit
  end

  # POST /master_texts
  # POST /master_texts.json
  def create
    @master_text = MasterText.new(master_text_params)
    respond_to do |format|
      if LocalizedTextEnforcer::MasterTextCrudder.new(@master_text).save
        format.html { redirect_to master_texts_path, notice: 'Master text was successfully created.' }
        format.json { render action: 'show', status: :created, location: @master_text }
      else
        format.html { render action: 'new' }
        format.json { render json: @master_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_texts/1
  # PATCH/PUT /master_texts/1.json
  def update
    respond_to do |format|
      if LocalizedTextEnforcer::MasterTextCrudder.new(@master_text).update(master_text_params)
        format.html { redirect_to master_texts_path, notice: 'Master text was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @master_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_texts/1
  # DELETE /master_texts/1.json
  def destroy
    @master_text.destroy
    respond_to do |format|
      format.html { redirect_to master_texts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_text
      @master_text = MasterText.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_text_params
      params.require(:master_text).permit(:key, :one, :other, :text, :comment, :pluralizable)
    end
end
