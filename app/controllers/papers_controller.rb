class PapersController < ApplicationController
  before_action :set_paper, only: [:show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.search(params[:search])
    @newest_papers = Paper.find(:all, :order => "created_at DESC", :limit => 3)
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
    @paper = Paper.find(params[:id])
  end

  # GET /papers/new
  def new
    @paper = Paper.new
  end

  # GET /papers/1/edit
  def edit
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = Paper.new(paper_params)

    respond_to do |format|
      if @paper.save
        format.html { redirect_to @paper, notice: 'Paper was successfully created.' }
        format.json { render action: 'show', status: :created, location: @paper }
      else
        format.html { render action: 'new' }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /papers/1
  # PATCH/PUT /papers/1.json
  def update
    respond_to do |format|
      if @paper.update(paper_params)
        format.html { redirect_to @paper, notice: 'Paper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper.destroy
    respond_to do |format|
      format.html { redirect_to papers_url }
      format.json { head :no_content }
    end
  end
  
  def browse
    @subjects = Subject.find(:all, :order => "name ASC") #find by paper subject
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = Paper.find(params[:id])
    end
    
    def correct_user
      @paper = current_user.papers.find_by(id: params[:id])
      if @paper.nil?
        redirect_to root_url 
        flash[:error] = "You have no permission to edit that paper"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit(:title, :url, :user_id, :subject_field)
    end
end
