package com.yodde.reviewModel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ReviewDaoImp implements ReviewDao {
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	private SqlSession session;
		
	@Override
	public List<Review> getReviewsByStoreId(int storeId) {		
		List<Review> list=null;
	  
		try{
			session=sqlSessionFactory.openSession();
			list=session.selectList("selectReviewByStoreId", storeId);
			if (list != null) {
				for (Review review:list){
					List<String>files = new ArrayList<String>();
					for (int i = 0; i < 5; i++) {
						//System.out.println(review.getPic(i));
						String path = session.selectOne("getFilePath", review.getPic(i));
						files.add(i, path);
						//System.out.println(path);
					}
					review.setPicPath(files);
				}
			}
		}catch(Exception e){
			System.out.println("selectlist review by storeid Error");
			e.printStackTrace();
		}finally{
			session.close();
		}
		
		return list;
	}

	@Override
	public int insertReview(ReviewDto review) {
		int value=0;
		int storeId = review.getStoreId();
		try{
			session=sqlSessionFactory.openSession();
			value=session.insert("writeReview", review);
			value=session.update("averageRate", storeId);
			session.commit();
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("writeReview Error");
			session.rollback(); // 내가 추가한 부
		}finally{
			session.close();
		}
		
		return value;
	}

	@Override
	public int getReviewCnt(String email) {
		// TODO Auto-generated method stub
		int cnt=0;
		
		try{
			session=sqlSessionFactory.openSession();
			cnt=session.selectOne("reviewCount", email);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("getReviewCnt Error");
		}finally{
			session.close();
		}
		
		return cnt;
	}	
	
	@Override
	   public List<ReviewDto> selectRecentReviewRate(String email) {
	      List<ReviewDto> list=null;
	      
	      try{
	         session=sqlSessionFactory.openSession();
	         list=session.selectList("selectRecentReviewRate", email);
	      }catch(Exception e){
	         System.out.println("selectRecentReview Error");
	         e.printStackTrace();
	      }finally{
	         session.close();
	      }
	      
	      return list;
	   }   
	
	@Override
	public double averageRate(String email) {
		double average=0.0;
		
		try{
			session = sqlSessionFactory.openSession();
			average = session.selectOne("getAverage", email);
			
		}catch(Exception e){
			System.out.println("ReviewDaoImp> averageRate error");
			e.printStackTrace();
		}finally{
			session.close();
		}
		
		return average;
	}

	@Override
	public List<Review> getReviewByWriter(String email, int startNumb, int endNumb) {
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		
		List<Review> list=null;
		hMap.put("email", email);
		hMap.put("startNumb", startNumb);
		hMap.put("endNumb", endNumb);
		
		//System.out.println("ReviewDaoImp > getReviewByWriter"+ "\nemail = "+ email+"\n startNumb = " + startNumb + "\n endNumb = "+endNumb);
		
		try{
			session = sqlSessionFactory.openSession();
			list = session.selectList("selectReviewByWriter", hMap);
			//System.out.println("ReviewDaoImp list="+list);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("ReviewDaoImp > getReviewByWriter error");
		}finally{
			session.close();
		}
		
		return list;
	}
	@Override
	   public int deleteReveiw(int reviewId, int storeId) {
	      int check=0;
	      //System.out.println("deleteReveiw : " + reviewId);
	      
	      try{
	         session=sqlSessionFactory.openSession();
	         check=session.delete("deleteReveiw", reviewId);
	         check=session.update("averageRate", storeId);
	         //System.out.println("deleteReveiw check : " + check);
	      }catch(Exception e){
	         System.out.println("deleteReveiw");
	         e.printStackTrace();
	      }finally{
	         session.close();
	      }
	      
	      return check;
	   }
	
	@Override
	   public int insertReviewEval(int storeId) {
	      int check=0;
	         //매퍼까지 연결 안된 상태
	      return check;
	   }

	@Override
	public int getReviewTotal(String email) {
		int total =0;
		
		try{
			session = sqlSessionFactory.openSession();
			total = session.selectOne("getReviewTotal", email);
		}catch(Exception e){
			System.out.println("getReviewTotal Error");
			e.printStackTrace();
		}finally{
			session.close();
		}
		
		return total;
	}
	
	@Override
	   public int updateReview(int reviewId, String updatedContent, int rate) {
	      HashMap<String, Object> hMap=new HashMap<String, Object>();
	      hMap.put("reviewId", reviewId);
	      hMap.put("updatedContent", updatedContent);
	      hMap.put("rate", rate);
	      //System.out.println("updateReview/reviewId : " + reviewId + ", updatedContent : " + updatedContent);
	      
	      int check=0;
	      
	      try{
	         session=sqlSessionFactory.openSession();
	         check=session.update("updateReview", hMap);
	         //System.out.println("updateReview check : " + check);
	         session.commit();
	      }catch(Exception e){
	         System.out.println("updateReview error");
	         e.printStackTrace();
	         session.rollback();
	      }finally{
	         session.close();
	      }
	      
	      return check;
	   }
	
}
