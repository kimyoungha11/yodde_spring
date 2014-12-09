package com.yodde.reviewModel;

import java.util.List;

public interface ReviewDao {
	public List<Review> 	getReviewsByStoreId(int storeId);
	public int				insertReview(ReviewDto review);	
	public int 				getReviewCnt(String email);
	public List<ReviewDto>   selectRecentReviewRate(String email);
	public double averageRate(String email);
	public List<Review> getReviewByWriter(String email, int startNumb, int endNumb);
	public int deleteReveiw(int reviewId, int storeId);
	public int insertReviewEval(int storeId);
	public int getReviewTotal(String email);
	public int updateReview(int reviewId, String updatedContent, int rate);
}
