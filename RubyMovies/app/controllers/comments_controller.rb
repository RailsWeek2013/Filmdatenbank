class CommentsController < ApplicationController
  authorize_resource

  def new
  	@comment = Comment.new
    @film = Film.find(params[:film_id])
  end

  def create
  	@film = Film.find(params[:film_id])
  	@comment = Comment.new(comment_params)
  	@comment.film = @film
  	@comment.user = current_user
  	if @comment.save
      redirect_to film_url(@film),
      notice: "Kommentar wurde gespeichert!"
  	else
  		redirect_to film_url(@film),
      notice: "Es ist ein Problem beim Speichern des Kommentars aufgetreten!"
  	end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @film = @comment.film
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to film_url(@film) }
      format.json { head :no_content }
    end
  end

  private
  def comment_params
  	params.require(:comment).permit(:text)
  end
end
