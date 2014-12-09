package com.yodde.storeModel;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StoreDaoImp implements StoreDao {
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	private SqlSession session;

	@Override
	public int insertStore(StoreDto store) {
		int value = 0;

		try {
			session = sqlSessionFactory.openSession();
			value = session.insert("insertStore", store);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Store Insert Error.");
		} finally {
			session.close();
		}

		return value;
	}

	@Override
	public int isExistStore(StoreDto store) {
		String id = null;

		try {
			session = sqlSessionFactory.openSession();
			id = session.selectOne("isExistStore", store);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("isExistStore Error.");
		} finally {
			session.close();
		}

		if (id == null)
			return 0;

		return Integer.parseInt(id);
	}

	@Override
	public StoreDto selectStoreByStoreId(int storeId) {
		StoreDto store = null;
		try {
			session = sqlSessionFactory.openSession();
			store = session.selectOne("selectStoreByStoreId", storeId);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("selectStoreByStoreId Error.");
		} finally {
			session.close();
		}

		return store;
	}

	@Override
	public int insertStoreInfo(int storeId) {
		int value = 0;

		try {
			session = sqlSessionFactory.openSession();
			value = session.insert("storeInfo", storeId);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Insert Store Error.");
		} finally {
			session.close();
		}

		return value;
	}

	@Override
	public int updateStoreFile(StoreDto storeDto) {
		int value = 0;

		try {
			session = sqlSessionFactory.openSession();
			value = session.update("storeUpdateFile", storeDto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("StoreFile Update Error.");
		} finally {
			session.close();
		}

		return value;
	}

	@Override
	public StoreInfoDto selectStoreInfo(int storeId) {
		StoreInfoDto storeInfo = null;

		try {
			session = sqlSessionFactory.openSession();
			storeInfo = session.selectOne("storeInfoSelect", storeId);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("StoreInfo Select Error");
		} finally {
			session.close();
		}
		return storeInfo;
	}

	@Override
	public int updateStoreInfo(StoreInfoDto storeInfo) {
		int value = 0;

		try {
			session = sqlSessionFactory.openSession();
			value = session.update("storeInfoUpdate", storeInfo);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("StoreInfo Select Error");
		} finally {
			session.close();
		}
		return value;
	}

	@Override
	public int updateStore(StoreDto storeDto) {
		int value = 0;

		try {
			session = sqlSessionFactory.openSession();
			value = session.update("storeUpdate", storeDto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Store Update Error.");
		} finally {
			session.close();
		}
		return value;
	}

	@Override
	public List<StoreDto> selectRecentReviewName(String email) {
		List<StoreDto> list = null;
		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("selectRecentReviewName", email);
			// System.out.println("list="+list);
		} catch (Exception e) {
			System.out.println("selectRecentReviewName Error");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<StoreDto> selectStoreByCategory(String category) {
		List<StoreDto> list = null;
		// System.out.println("StoreDaoImp "+category);

		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("selectStoreByCategory",
					'%' + category + '%');
			// System.out.println(list.get(0).getStoreName());
		} catch (Exception e) {
			System.out.println("StoreDaoImp > selectStoreByCategory error");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<StoreAndStoreInfoDto> selectStoreByStoreInfo(String query,
			String[] infoChecked) {
		List<StoreAndStoreInfoDto> list = null;
		query = query.toUpperCase();

		HashMap<String, String> hMap = new HashMap<String, String>();
		String storeInfo = "";

		// query를 stroreInfo에 담아주고 hashMap에 value 값으로 너어준다

		storeInfo = "i." + infoChecked[0] + " ";
		for (int i = 1; i < infoChecked.length; i++) {
			storeInfo += "+ i." + infoChecked[i] + " ";
		}
		hMap.put("query", "%" + query + "%");

		hMap.put("storeInfo", storeInfo);
		// System.out.println(storeInfo);
		// System.out.println("hashMap.get(storeInfo)="+hMap.get("storeInfo"));

		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("selectStoreByStoreInfo", hMap);
			// System.out.println("StoreDaoImp  ="+list.size());
		} catch (Exception e) {
			System.out.println("StoreDaoImp > selectStoreByStoreInfo Error");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<StoreDto> selectStoreByCategory(String categoryLevel,
			String category) {
		List<StoreDto> list = null;

		HashMap<String, String> hMap = new HashMap<String, String>();
		hMap.put("categoryLevel", categoryLevel);
		hMap.put("query", '%' + category + '%');

		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("selectStoreByCategory", hMap);
		} catch (Exception e) {
			System.out.println("StoreDaoImp > selectStoreByCategory error");
			e.printStackTrace();
		} finally {
			session.close();
		}
		System.out.println(list);
		return list;
	}

	@Override
	public List<StoreDto> selectNewOpen() {
		List<StoreDto> list = null;

		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("newOpen");
		} catch (Exception e) {
			System.out.println("NewOpen Store Error");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<StoreDto> selectHotPlace() {
		List<StoreDto> list = null;

		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("hotPlace");
		} catch (Exception e) {
			System.out.println("HotPlace Store Error");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<LikeDto> selectLike() {
		List<LikeDto> list = null;

		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("upLike");
		} catch (Exception e) {
			System.out.println("upLike Store Error");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<FollowReview> selectFollowReview(String email) {
		List<FollowReview> list = null;

		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("followReview", email);
		} catch (Exception e) {
			System.out.println("followReview Select Error");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<FollowStore> selectFollowStoreReview(String email) {
		List<FollowStore> list = null;

		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("followStoreReview", email);
		} catch (Exception e) {
			System.out.println("followStore Select Error");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<StoreDto> selectStoreByAddress(String query) {
		List<StoreDto> list = null;

		try {
			session = sqlSessionFactory.openSession();
			list = session.selectList("selectStoreByAddress", '%' + query + '%');

		} catch (Exception e) {
			System.out.println("selectStoreByAddress");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}
	
	@Override
	   public List<StoreDto> selectStoreByQuery(String query) {
	      List<StoreDto> list = null;

	      try {
	         session = sqlSessionFactory.openSession();
	         list = session.selectList("selectStoreByQuery", '%' + query + '%');

	      } catch (Exception e) {
	         System.out.println("selectStoreByAddress");
	         e.printStackTrace();
	      } finally {
	         session.close();
	      }

	      return list;
	   }
}