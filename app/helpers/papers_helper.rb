module PapersHelper
  def comment_user?(comment)
    comment.user == current_user
  end
  
  def paper_user?(paper)
    paper.user == current_user
  end
  
  def review_user?(review)
    review.user == current_user
  end
end
