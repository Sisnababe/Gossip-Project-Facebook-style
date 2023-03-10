class CommentsController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        @comment.user_id = 33  #car on est pas connecté donc pas de current_user id (@comment.user = current_user)
      if @comment.save
      redirect_to article_path(@article), notice: "Comment was successfully created."
     else
        redirect_to article_path(@article), alert: "Comment was not created."
    end
    
    def destroy
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article), status: :see_other, notice: "Comment was successfully destroyed." 
    end

    private
        def comment_params
          params.require(:comment).permit(:commenter, :body)
        end
end