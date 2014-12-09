<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true"%>
<html>
   <head>
      <c:set var="root" value="${pageContext.request.contextPath}"/>
      <c:set var="email" value="${sessionScope.email}"/>
      <c:set var="profilePic" value="${profilePic}" scope="session"/>   
      <c:set var="status" value="${status}" scope="session"/>      
      <script type="text/javascript">
         function logout() {
            alert("bye~");
         }
      </script>
      <!--
      <script>
          $(document).ready(function() {
             if ('${email}' == "") return;
               var email = '${email}';
             jQuery.ajax({            
                type:"GET",
                url:"profilePic",
                data:"email="+ email,
                success : function(data) {
                      //alert(data);            
                        $("#profilePic").attr("src", '${root}'+data)
                },
                complete : function(data) {
                      // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
                      // TOD
                },
                error : function(xhr, status, error) {
                      alert("에러발생");
                }
             });
          });
       </script>
       -->
   </head>
   <body style="min-width:1260px;">
      <div class="title_box">
         <!-- 타이틀 왼쪽 버튼 -->
         <span class="title_left">
            <span class="title_btn1">      <!-- 슬라이드 메뉴 버튼 -->   
               <span id="pageslide" style="right: auto; left: -300; display: none;">
                  <span id="slideNav" class="panel"> 
                     <a href="javascript:jQuery.pageslide.close()" class="closeBtn"></a> 
                     <span id="mainNav"> 
                        <span class="title_btn2">      <!-- 프로필 버튼 -->
                           <c:choose>
                              <c:when test="${status == 'member'}">
                                 <a href="${root}/info/memberMypage?email=${email}">
                                    <c:choose>
                                       <c:when test="${profilePic != null}">
                                          <img id="profilePic" src="${root}${profilePic}" height="90" style="border-radius: 75px;">
                                       </c:when>
                                       <c:otherwise>
                                          <img id="profilePic" src="${root}/resources/images/images/profile.png" height="90" style="border-radius: 75px;">
                                       </c:otherwise>
                                    </c:choose>
                                 </a>
                              </c:when>
                              <c:when test="${status == 'owner'}">
                                 <a href="${root}/info/ownerMyPage?email=${email}">
                                    <c:choose>
                                       <c:when test="${profilePic != null}">
                                          <img id="profilePic" src="${root}${profilePic}" height="90" style="border-radius: 75px;">
                                       </c:when>
                                       <c:otherwise>
                                          <img id="profilePic" src="${root}/resources/images/images/profile.png" height="90" style="border-radius: 75px;">
                                       </c:otherwise>
                                    </c:choose>
                                 </a>
                              </c:when>
                              <c:otherwise>
                                 <a href="${root}/info/modifyMember?email=${email}">
                                    <img id="profilePic" src="${root}/resources/images/images/profile.png" height="90" style="border-radius: 75px;">
                                 </a>
                              </c:otherwise>
                           </c:choose>
                        </span>
                     <span id="categoryMenu" class="menu-menu-1-container">
                                 <ul class="category" style="margin-left:0px">
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=공공,사회기관">공공기관</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=교육,학문">교육</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=금융">금융서비스 </a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=서비스,산업">렌탈</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=쇼핑,유통">마트</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=건강,의료">병원</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=생활,편의">생활서비스</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=숙박">숙박</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=문화,예술">영화/공연</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=스포츠,오락">오락서비스</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=식">음식</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=교통,운수">자동차</a></li>
                                    <li class="category_li" id=""><a href="${root}/categorySearch?categoryLevel=category1&category=카페,디저트">카페/제과</a></li>
                                 </ul>
                              </span>
                              <span id="memberMenu" class="menu-menu-1-container">
                                 <ul class="category" style="margin-left:0px">
                             <li class="category_li" id=""><a href="${root}/info/passwordConfirm?email=${email}">회원정보수정</a></li>
                                    <li class="category_li" id=""><a href="${root}/info/followerList?email=${email}">팔로워리스트</a></li>
                                    <li class="category_li" id=""><a href="${root}/info/followingList?email=${email}">팔로잉리스트 </a></li>
                                    <li class="category_li" id=""><a href="${root}/info/storeFollowingList?email=${email}">스토어 팔로잉리스트</a></li>
                                    <li class="category_li" id=""><a href="${root}/info/memHistory?email=${email}">나의 리뷰</a></li>
                                    <li class="category_li" id=""><a href="${root}/info/deleteMember?email=${email}">회원탈퇴</a></li>                                   
                                 </ul>
                              </span>
                              <span id="ownerMenu" class="menu-menu-1-container">
                                 <ul class="category" style="margin-left:0px">
                                     <li class="category_li" id=""><a href="${root}/info/OwPasswordConfirm?email=${email}">회원정보수정</a></li>
                                    <li class="category_li" id=""><a href="${root}/info/modifyOwner?email=${email}">회원정보수정</a></li>
                                    <li class="category_li" id=""><a href="${root}/info/modifyStore?email=${email}">스토어정보수정</a></li>
                                    <li class="category_li" id=""><a href="${root}/info/storeFollowerList?email=${email}">팔로워리스트</a></li>
                                    <li class="category_li" id=""><a href="${root}/info/deleteOwner?email=${email}">회원탈퇴</a></li>                                   
                                    
                                 </ul>
                              </span>
                     </span>
                  </span>
               </span> 
            <span id="container"> 
               <span id="header"> 
                  <span class="inside clearfix"> 
                     <a href="#slideNav" class="menuToggle"></a>
                  </span>
               </span>
            </span> 
            

            </span>
         </span>
         
         <!-- 센터 로고 -->
         <span class="title_center">
            <a href="/home" class="title_logo">
               <img src="${root}/resources/images/images/logo.png" height="43">
            </a>
         </span>
         
         <!-- 타이틀 오른쪽 버튼 -->
         <span class="title_right">
            <c:if test="${fn:length(email) < 3}">
               <a href="/home/login" onclick="" style="padding-right:8px;">
                  <img src="${root}/resources/images/images/login2.png" height="18">
               </a>
            </c:if>
            <c:if test="${fn:length(email) > 3 }">
               <a href="/home/signout" onclick="javascript:logout()" style="padding-right:8px;">
                  <img src="${root}/resources/images/images/logout.png" height="18">
               </a>
            </c:if>
            
            <a href="" onclick="">
               <img src="${root}/resources/images/images/about us.png" height="18">
            </a>
         </span>
      </div>      
      <script type="text/javascript" src="${root}/resources/scripts/jQueryWeb.js"></script> 
      <script type="text/javascript" src="${root}/resources/scripts/jQueryWeb2.js"></script>
      <script type="text/javascript">
         var url = location.href;
         var search = url.search("/info/");         
         if(search == -1){
            //category
            var category = document.getElementById("categoryMenu");
            var memberMenu = document.getElementById("memberMenu");
            var ownerMenu = document.getElementById("ownerMenu");
            
               category.style.display = "";
               memberMenu.style.display = "none";
               ownerMenu.style.display = "none";
         }
         else {
            var category = document.getElementById("categoryMenu");
            var memberMenu = document.getElementById("memberMenu");
            var ownerMenu = document.getElementById("ownerMenu");
            var status = "${status}";
               if (status == "member") {
                  category.style.display = "none";
                  memberMenu.style.display = "";
                  ownerMenu.style.display = "none";
               } else if(status == "owner") {
                  category.style.display = "none";
                  memberMenu.style.display = "none";
                  ownerMenu.style.display = "";
               } else {
                  category.style.display = "";
                  memberMenu.style.display = "none";
                  ownerMenu.style.display = "none";
               }               
         }         
      </script>
   </body>
</html>