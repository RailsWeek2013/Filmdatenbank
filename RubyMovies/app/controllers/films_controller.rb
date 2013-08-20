class FilmsController < ApplicationController
  authorize_resource
  
  before_action :set_film, only: [:show, :edit, :update, :destroy]

  # GET /films
  # GET /films.json
  def index
    if params[:tag]
      @active_films = Film.tagged_with(params[:tag]) 
    else
       @active_films = Film.where(active: true)
    end
  end

  # GET /films/suggested
  def suggested
    @films = Film.where(active: false)
  end

  # GET /films/1
  # GET /films/1.json
  def show
    @film = Film.find(params[:id])
    @comments = Comment.where(film: @film)
  end

  # GET /films/new
  def new
    @film = Film.new
  end

  # GET /films/1/edit
  def edit
  end

  # POST /films
  # POST /films.json
  def create
    @film = Film.new(film_params)

    respond_to do |format|
      if @film.save
        format.html { redirect_to @film, notice: 'Film was successfully created.' }
        format.json { render action: 'show', status: :created, location: @film }
      else
        format.html { render action: 'new' }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /films/1
  # PATCH/PUT /films/1.json
  def update
    respond_to do |format|
      if @film.update(film_params)
        format.html { redirect_to @film, notice: 'Film was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /films/1
  # DELETE /films/1.json
  def destroy
    @film.destroy
    respond_to do |format|
      format.html { redirect_to films_url }
      format.json { head :no_content }
    end
  end

  def review
    f = Film.find(params[:fid])
    r = Review.new
    r.note = params[:rid]
    r.film = f
    r.user = current_user
    if r.save
      update_average f
      redirect_to film_url(f)
      #notice: "Bewertung wurde gespeichert!"
    else
      redirect_to film_url(f),
      notice: "Bewertung wurde nicht gespeichert!"
    end
  end

  def top
    @active_films = Film.where(active: true).order('average DESC')
  end

  def active
    f = Film.find(params[:id])
    f.active = true
    f.save
    redirect_to suggested_films_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film
      @film = Film.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def film_params
      params.require(:film).permit(:title, :tag_list, :picture, :description, :link, :active)
    end

    def update_average film
      count = film.reviews.size
      summe = 0.0
      film.reviews.each do |r|
        summe = summe + r.note
      end
      film.average = (summe  / count).round(2)
      film.save
    end
end
