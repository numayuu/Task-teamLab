class MoviesController < ApplicationController

  def new
    @movie = Movie.new
  end

  def show
    @newmovie = Movie.new
    @movie = Movie.find(params[:id])
  end

  def index
    @user = current_user
    @movie = Movie.new
    @movies = Movie.all.order(updated_at: :desc)
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice]="Memoを作成しました。"
      redirect_to movies_path(@movie)
    else
      @user = current_user
      @movies = Movie.all
      render :index
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:notice]="Memoを更新しました。"
      redirect_to movies_path(@movie.id)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      flash[:notice]="Memoを削除しました。"
      redirect_to movies_path
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :body)
  end

end
