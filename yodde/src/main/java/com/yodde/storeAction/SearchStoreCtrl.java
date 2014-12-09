package com.yodde.storeAction;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.yodde.evaluationModel.EvaluationDao;
import com.yodde.evaluationModel.EvaluationDto;
import com.yodde.pictureModel.PictureDao;
import com.yodde.pictureModel.PictureDto;
import com.yodde.reviewModel.Review;
import com.yodde.reviewModel.ReviewDao;
import com.yodde.storeModel.StoreAndStoreInfoDto;
import com.yodde.storeModel.StoreDao;
import com.yodde.storeModel.StoreDto;
import com.yodde.storeModel.StoreInfoDto;

@Component
@Controller
public class SearchStoreCtrl {
	@Autowired
	// 해당 변수타입과 일치하는 빈을 찾아서 주입
	private StoreDao storeDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private PictureDao pictureDao;
	@Autowired
	private EvaluationDao evaluationDao;

	@RequestMapping(value = "/getStoreInfo", method = RequestMethod.GET)
	public ModelAndView getStoreInfo(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// create response
		ModelAndView mav = new ModelAndView();
		// parse request
		String title = request.getParameter("title");
		// title tag delete
		title = title.replaceAll("<b>", "");
		title = title.replaceAll("</b>", "");
		String email = request.getParameter("email");

		// category tokenize
		StringTokenizer st = new StringTokenizer(
				request.getParameter("category"), ">");

		String[] arrCategory = new String[] { "", "", "" };

		for (int i = 0; i < 3; i++) {
			arrCategory[i] = st.nextToken();
			// System.out.println(arrCategory[i]);
			if (!st.hasMoreTokens())
				break;
		}

		// create dto
		StoreDto storeDto = new StoreDto();
		storeDto.setStoreName(title);
		storeDto.setCategory1(arrCategory[0]);
		storeDto.setCategory2(arrCategory[1]);
		storeDto.setCategory3(arrCategory[2]);
		storeDto.setPhoneNum(request.getParameter("telephone"));
		storeDto.setAddress(request.getParameter("address"));
		storeDto.setStreetAddr(request.getParameter("roadAddress"));
		storeDto.setLatitude(Double.parseDouble(request.getParameter("mapx")));
		storeDto.setLongitude(Double.parseDouble(request.getParameter("mapy")));

		String date = "0000-00-00";
		DateFormat transDay = new SimpleDateFormat("yyyy-MM-dd");
		Date openDay = transDay.parse(date);

		storeDto.setOpenDate(openDay);

		// 선택한 스토어가 데이터베이스에 있는지 확인
		int storeId = storeDao.isExistStore(storeDto);
		int check = 0;

		if (storeId == 0) {
			// insert store
			check = storeDao.insertStore(storeDto);
			storeId = storeDao.isExistStore(storeDto);
			storeDao.insertStoreInfo(storeId);
		} else {
			check = 2;
		}
		// System.out.println(check + "," + storeId);
		storeDto = storeDao.selectStoreByStoreId(storeId);

		// select review : 원래 스토어가 있을때만 리뷰검색 : 사진검색
		List<Review> reviewList = null;
		List<PictureDto> pictureList = null;
		int eval = 0;
		List<EvaluationDto> evalDto = null;

		if (check == 2) {
			reviewList = reviewDao.getReviewsByStoreId(storeDto.getStoreId());
			if (email != null && email.length() > 0) {
				for (Review review : reviewList) {
					eval = evaluationDao.evaluationCheck(email,
							review.getReviewId());
					review.setEval(eval);
					evalDto = evaluationDao.selectList(email,
							review.getReviewId());
				}
			}
			pictureList = pictureDao.select7Picture(storeDto.getStoreId());
		}

		StoreInfoDto storeInfo = new StoreInfoDto();
		storeInfo = storeDao.selectStoreInfo(storeId);

		// set response value
		mav.addObject("eval", evalDto);
		mav.addObject("storeInfo", storeInfo);
		mav.addObject("reviewList", reviewList);
		mav.addObject("pictureList", pictureList);
		mav.addObject("storeDto", storeDto);
		mav.addObject("check", check);
		mav.setViewName("/store/storeInfo");

		return mav;
	}

	@RequestMapping(value = "/searchStore", method = RequestMethod.GET)
	public ModelAndView searchStore(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String query = request.getParameter("query");

		ModelAndView mav = new ModelAndView();
		mav.addObject("query", query);
		mav.setViewName("/search/findStore");

		return mav;
	}

	@RequestMapping(value = "/searchStoreByStoreInfo", method = RequestMethod.GET)
	public ModelAndView searchStoreByStoreInfo(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String query = request.getParameter("query");
		StringTokenizer store = new StringTokenizer(
				request.getParameter("storeInfo"), " ");

		// 넘어온 애들만 배열에 1을 집어 넣는다
		int[] storeInfo = new int[12];
		String[] infoChecked = new String[store.countTokens()];
		for (int i = 0; i < storeInfo.length; i++) {
			storeInfo[i] = 2;
		}
		String token = "";
		int j = 0;
		while (store.hasMoreTokens()) {
			token = store.nextToken();
			infoChecked[j] = token;
			if (token.equalsIgnoreCase("reservation")) {
				storeInfo[0] = 1;
			} else if (token.equalsIgnoreCase("delivery")) {
				storeInfo[1] = 1;
			} else if (token.equalsIgnoreCase("takeout")) {
				storeInfo[2] = 1;
			} else if (token.equalsIgnoreCase("card")) {
				storeInfo[3] = 1;
			} else if (token.equalsIgnoreCase("parking")) {
				storeInfo[4] = 1;
			} else if (token.equalsIgnoreCase("group")) {
				storeInfo[5] = 1;
			} else if (token.equalsIgnoreCase("toilet")) {
				storeInfo[6] = 1;
			} else if (token.equalsIgnoreCase("wifi")) {
				storeInfo[7] = 1;
			} else if (token.equalsIgnoreCase("tv")) {
				storeInfo[8] = 1;
			} else if (token.equalsIgnoreCase("seating")) {
				storeInfo[9] = 1;
			} else if (token.equalsIgnoreCase("kids")) {
				storeInfo[10] = 1;
			} else if (token.equalsIgnoreCase("drive_through")) {
				storeInfo[11] = 1;
			}
			j++;
		}

		// System.out.println(Arrays.toString(storeInfo));
		List<StoreAndStoreInfoDto> info = null;
		info = storeDao.selectStoreByStoreInfo(query, infoChecked);

		ModelAndView mav = new ModelAndView();
		mav.addObject("storeInfo", info);
		mav.setViewName("/search/searchByStoreInfo");

		return mav;
	}

	@RequestMapping(value = "/proxy", method = RequestMethod.GET)
	public ModelAndView proxy(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/store/api_proxy");
		return mav;
	}

	@RequestMapping(value = "/getLocalStore", method = RequestMethod.GET)
	public ModelAndView getLocalStore(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String address = request.getParameter("address");
		// System.out.println("address = " + address);
		List<StoreDto> list = storeDao.selectStoreByAddress(address);

		ModelAndView mav = new ModelAndView();
		mav.addObject("storeList", list);
		mav.setViewName("/main/region");
		return mav;
	}
	
	@RequestMapping(value = "/getStorePic", method = RequestMethod.GET)
	   public ModelAndView getStorePic(HttpServletRequest request,
	         HttpServletResponse response) throws Exception {
	      String query = request.getParameter("query");
	      //System.out.println(query);
	      
	      List<StoreDto> list=null;
	      list=storeDao.selectStoreByQuery(query);
	      //System.out.println(list.size());
	      
	      
	      ModelAndView mav = new ModelAndView();
	      mav.addObject("list", list);
	      mav.setViewName("jsonView");

	      return mav;
	   }

}