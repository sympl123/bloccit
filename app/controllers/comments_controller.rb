class CommentsController < ApplicationController

  def new 
      @comment = Comment.new 
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    
    authorize @comment 
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to @comment
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end

   def destroy
     @topic = Topic.find(params[:topic_id])
     @post = @topic.posts.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
 
     authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
       redirect_to [@topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       redirect_to [@topic, @post]
     end
   end

end
