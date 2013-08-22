class QuestionsController < ApplicationController
  authorize_resource

  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def active
    q = Question.find(params[:id])
    q.active = true
    q.save
    redirect_to questions_url
  end

  def quiz
    quiz = Quiz.quiz
    quiz.save
    @q = quiz
    @quiz = getquiz quiz
  end

  def solve
    @quiz = Quiz.find(params[:quiz].to_i)
    @q = @quiz
    @quiz = getquiz @quiz
    unless params[:answer].nil?
      if params[:answer] == Question.find(params[:id]).solution.to_s
        @solution = "Die Antwort ist richtig"
      else
        if params[:answer] == "0"
          @solution = ""
        else
          @solution = "Die Antwort ist falsch"
        end
      end
    end
    render action: "quiz"
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :answer1, :answer2, :answer3, :answer4, :solution, :active)
    end

    def getquiz quiz
      @quiz = Array.new
      @quiz.push quiz.q1 unless quiz.q1.nil?
      @quiz.push quiz.q2 unless quiz.q2.nil?
      @quiz.push quiz.q3 unless quiz.q3.nil?
      @quiz.push quiz.q4 unless quiz.q4.nil?
      @quiz.push quiz.q5 unless quiz.q5.nil?
      @quiz = Kaminari.paginate_array(@quiz).page(params[:page]).per(1)
    end
  end
