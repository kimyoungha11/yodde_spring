<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="${root}/resources/css/commons/common.css"/>		<!-- footer, title css -->
		<link rel="stylesheet" type="text/css" href="${root}/resources/css/commons/category.css" />		<!-- category css -->
		<link rel="stylesheet" type="text/css" href="${root}/resources/css/main/main.css"/>				<!-- main css -->
		<link rel="stylesheet" type="text/css" href="${root}/resources/css/follow/follow.css"/>
		
		<script type="text/javascript" src="${root}/resources/scripts/jquery-2.1.1.js"></script>
		
		<!-- 팔로잉 버튼 누르면 오는 곳 -->
		<script type="text/javascript">
			function followCheck(follower, following, index){
				var following=following;
				var email=follower;
				var index = index;
				var url="followMemberMyPage?email=" + email + "&following=" + following;

				$.ajax({
					url:url,
					type:"get",
					contentType:"text/xml; charset=utf-8", 
					dataType: "text",
					error: function(xhr, status, error) { alert("error : " +status); },
					success: function(data){
						//alert(data);
						if(data ==1){
							//alert("팔로우"+"following "+following+", email "+email);
							$(".follow").children().eq(index).attr("src", "${root}/resources/images/images/follow_list.png");

						}else{
							//alert("해제"+"following "+following+", email "+email);
							$(".follow").children().eq(index).attr("src", "${root}/resources/images/images/notfollow_list.png");
						}
					}
				}); // Ajax 호출 및 이벤트 핸들러 함수 정의
			}
		</script>
	</head>
	<body style="min-width:1260px;">
		<div>
			<jsp:include page="../common/title.jsp"/>			<!-- title -->
		</div>
		
		<div class="content">									<!-- content -->
			<div class="followerList_content">
				<div class="followerList_box">
					<div class="result_title">					<!-- login title -->
						<img src="${root}/resources/images/images/following.png" height="45">
					</div>
					
					<!-- 처음 페이지 로드되면 가는 곳 -->
					<script type="text/javascript">
          				$(document).ready(function(){
          					var email="${email}";
          					var following="${memList.email}";
          					var url="followMemberCheckMyPage?email=" + email + "&following=" + following;
              				$.ajax({
              					url:url,
              					type:"get",
              					contentType:"text/xml; charset=utf-8", 
              					dataType: "text",
              					error: function(xhr, status, error) { alert("error : " +status); },
              					success: function(data){
              						//alert(data);
              						if(data ==1){
              							$("#follow").attr("src", "${root}/resources/images/images/follow_list.png");	
              						}
              					}
              				}); // Ajax 호출 및 이벤트 핸들러 함수 정의
          				});
          			</script>
          			
					<ul class="content_box">
						<c:choose>
							<c:when test="${empty selectFollowingMember}">
								<div class="none"> 새로운 멤버를 팔로잉 해보세요!</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="memList" begin="0" varStatus="status" end="${fn:length(selectFollowingMember)}" items="${selectFollowingMember}">
									<li class="myProfile">
										<div class="myPhoto" style="padding-top:20px">
											<a href="${root}/member/memberMyPage?email=${memList.email}"><img src="${root}/resources/images/images/profile.png" width="130px"></a>
										</div>
										<div class="follower_nickname">
											${memList.nickName}	
										</div>
										<a href="javascript:followCheck('${email}', '${memList.email}','${status.count-1}')" class="follow"><img src="${root}/resources/images/images/follow_list.png" height="20" id="follow"></a> 
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</ul>
					
					<div class="more">							<!-- 더보기 버튼 -->
						<a href=""><img src="${root}/resources/images/images/review_more.png" height="25"></a>
					</div>
				</div>
			</div>
		</div>
		
		<div>
			<jsp:include page="../common/footer.jsp"/>			<!-- footer -->
		</div>
	</body>
</html>