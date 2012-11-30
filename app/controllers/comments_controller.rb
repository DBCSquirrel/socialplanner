class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    render :partial => 'form'
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      render :partial => 'comment'
    else
      render :partial => 'form'
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    redirect_to events_path
  end
end
