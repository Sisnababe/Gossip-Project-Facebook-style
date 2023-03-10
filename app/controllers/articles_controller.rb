class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = 33 #car on est pas connecté donc pas de current_user id
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article was successfully update."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    
  end
  
  def set_article
    @article=Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end
  
end