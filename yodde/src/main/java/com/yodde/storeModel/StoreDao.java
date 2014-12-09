package com.yodde.storeModel;

import java.util.List;

public interface StoreDao {
	public int isExistStore(StoreDto store);
	public StoreDto selectStoreByStoreId(int storeId);
	public int insertStore(StoreDto store);
	public int insertStoreInfo(int storeId);
	public int updateStoreFile(StoreDto storeDto);
	public StoreInfoDto selectStoreInfo(int storeId);
	public int updateStoreInfo(StoreInfoDto storeInfo);
	public int updateStore(StoreDto storeDto);
	public List<StoreDto> selectRecentReviewName(String email);
	public List<StoreDto> selectStoreByCategory(String category);
	public List<StoreAndStoreInfoDto> selectStoreByStoreInfo(String query, String[] infoChecked);
	public List<StoreDto> selectStoreByCategory(String categoryLevel, String category);
	public List<StoreDto> selectNewOpen();
   public List<StoreDto> selectHotPlace();
   public List<StoreDto> selectStoreByAddress(String query);
   public List<LikeDto> selectLike();
   public List<FollowReview> selectFollowReview(String email);
   public List<FollowStore> selectFollowStoreReview(String email);
   public List<StoreDto> selectStoreByQuery(String query);
   
}
