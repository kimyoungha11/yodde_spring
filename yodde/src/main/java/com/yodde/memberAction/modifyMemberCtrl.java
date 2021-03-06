package com.yodde.memberAction;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.yodde.memberModel.MemberDao;
import com.yodde.memberModel.MemberDto;
import com.yodde.relationModel.RelationDao;
import com.yodde.reviewModel.ReviewDao;
import com.yodde.reviewModel.ReviewDto;
import com.yodde.storeModel.StoreDao;
import com.yodde.storeModel.StoreDto;

@Component
@Controller
public class modifyMemberCtrl {
	@Autowired //해당 변수타입과 일치하는 빈을 찾아서 주입
	private MemberDao memberDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private RelationDao relationDao;
    @Autowired
    private StoreDao storeDao;
	
	@RequestMapping(value = "/info/memberMypage", method=RequestMethod.GET)
	   public ModelAndView memberMypage(@ModelAttribute MemberDto memberDto, HttpServletRequest request,
	         HttpServletResponse response) throws Exception {
	      
	      String email=request.getParameter("email");
	      //System.out.println(email);
	      
	      MemberDto member = memberDao.selectMember(email);
	      int reviewCnt = reviewDao.getReviewCnt(email);
	      int followingCnt = relationDao.getFollowingCnt(email);
	      int followerCnt = relationDao.getFollowerCnt(email);
	      int followingStoreCnt = relationDao.getfollowingStoreCnt(email);
	      List<ReviewDto> rateList;
	      rateList=reviewDao.selectRecentReviewRate(email);
	      List<StoreDto> nameList;
	      nameList=storeDao.selectRecentReviewName(email);
	      
	      //System.out.println(Arrays.toString(nameList));
	      ModelAndView mav = new ModelAndView();
	      mav.addObject("member", member);
	      mav.addObject("reviewCnt", reviewCnt);
	      mav.addObject("followingCnt", followingCnt);
	      mav.addObject("followerCnt", followerCnt);
	      mav.addObject("followingStoreCnt", followingStoreCnt);
	      
	      mav.addObject("selectRecentReviewRate", rateList);
	      mav.addObject("selectRecentReviewName", nameList);
	      
	      mav.setViewName("/member/memberMyPage");
	      return mav;
	}
	
	@RequestMapping(value = "/info/modifyMember", method=RequestMethod.GET)
	public ModelAndView modifyMember(@ModelAttribute MemberDto memberDto, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String email=request.getParameter("email");
		if (email == "") {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/common/login");
			return mav;
		}
		memberDto=memberDao.selectMember(email);
		
		String zip1=memberDto.getZipcode().substring(0, 3);
		String zip2=memberDto.getZipcode().substring(4, 7);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("zip1", zip1);
		mav.addObject("zip2", zip2);
		mav.addObject("memberDto", memberDto);
		mav.setViewName("/member/modifyMember");
		return mav;
	}
	
	@RequestMapping(value = "/info/modifyMember", method=RequestMethod.POST)
	public ModelAndView modifyMemberOk(@ModelAttribute MemberDto memberDto, 
			MultipartHttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception {
		
		String zipcode = request.getParameter("zip1") + "-" + request.getParameter("zip2");
		String password=request.getParameter("password");
		
		memberDto.setZipcode(zipcode);
		memberDto.setPassword(password);
		
		String filename = null;
		String profilePath = "/Users/Min/git/yodde_spring/yodde/src/main/webapp";
		MultipartFile uploadfile = memberDto.getUploadfile();
		
		//file upload
		if (uploadfile.getOriginalFilename().length() > 0) {
			// 프로필 사진 변경시 
			//System.out.println("file not null" + uploadfile.getOriginalFilename());
			String ext = uploadfile.getOriginalFilename();
			ext = ext.substring(ext.length() - 4);
			//System.out.println(ext);
			//filename = "c:/upload/" + memberDto.getEmail() + ext;
			//C:\Users\Lake\git\yodde_spring\yodde\src\main\java\com\yodde\memberAction
			//System.out.println(session.getServletContext().getRealPath("/upload/"));
			
			filename = "/resources/images/profile/" + memberDto.getEmail() + ext;
			File file = new File(profilePath + filename);
			
			uploadfile.transferTo(file);
			
			memberDto.setProfilePic(filename);
			memberDao.updateMemberFile(memberDto);
		} else {
			//프로필 사진 변경 안할시
			int check=memberDao.updateMember(memberDto);
			//System.out.println(check);
		}
		
		MemberDto member = memberDao.selectMember(memberDto.getEmail());
		
		int reviewCnt = reviewDao.getReviewCnt(memberDto.getEmail());
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("reviewCnt", reviewCnt);
		mav.addObject("member", member);
		mav.setViewName("/member/memberMyPage");
		return mav;
	}
}
