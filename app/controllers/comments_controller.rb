class CommentsController < ApplicationController
  def create
    @user ||= User.find(session[:user_id]) if session[:user_id]
    if params[:comment] == nil

      flash[:alert] = "Please leave a comment"
      redirect_to :back
    else
    @comment = Comment.create(comment_params)
      @comment.user_id = @user.id
      @comment.save
      flash[:notice] = "Successfully added a comment"
      redirect_to user_path(@user)
    end
  end

  def new
    @user = User.find(params[:user_id])
    @comment = Comment.create({user_id: params[:comment][:user_id], photo_id: params[:comment][:photo_id], content: params[:comment][:content]})
  end


  private
  def comment_params
    params.require(:comment).permit(:user_id,:photo_id,:content)
  end
end
