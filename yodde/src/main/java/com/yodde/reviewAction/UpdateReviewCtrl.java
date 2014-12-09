package com.yodde.reviewAction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.yodde.reviewModel.ReviewDao;

@Component
@Controller
public class UpdateReviewCtrl {
   @Autowired //해당 변수타입과 일치하는 빈을 찾아서 주입
   ReviewDao reviewDao;

   @RequestMapping(value = "/updateReivewAction", method=RequestMethod.GET)
   public ModelAndView updateReview(HttpServletRequest request,
         HttpServletResponse response) throws Exception {

      int reviewId = Integer.parseInt(request.getParameter("reviewId"));
      int rate = Integer.parseInt(request.getParameter("rate"));
      String updatedContent = request.getParameter("updatedContent");
      //System.out.println("updateReviewCtrl/update reviewId : " + reviewId + ", updatedContent : " + updatedContent);
      
      int check = reviewDao.updateReview(reviewId, updatedContent, rate);
      //System.out.println("UpdateReviewCtrl/update check : " + check);
      
      ModelAndView mav=new ModelAndView();
      mav.addObject("result", check);
      mav.setViewName("/result");
      
      return mav;
   }
}