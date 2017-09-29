class CommentsController < ApplicationController
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end
  
  def edit
  end
  
  def destroy
    #binding.pry
    #@comment = current_user.comments
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments
    #@comment = @blog.comments.build
    #@comments = @blog.comments
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      #@Comment = Comment.find(params[:id])
      #@blog = Blog.find(@Comment.blog_id)
      if Comment.find(params[:id]).destroy
        format.html { redirect_to blog_path(@blog), notice: 'コメントを削除しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
end