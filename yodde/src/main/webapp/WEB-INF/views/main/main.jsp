<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>요때</title>
      <c:choose>
           <c:when test="${email==''}">
               <c:set var="email" value="" scope="session"/>
               <c:set var="nick" value="" scope="session"/>
               <c:set var="profilePic" value="" scope="session"/>
               <c:set var="status" value="" scope="session"/>
           </c:when>
           <c:otherwise>
               <c:set var="email" value="${email}" scope="session"/>
               <c:set var="nick" value="${nick}" scope="session"/>
               <c:set var="profilePic" value="${profilePic}" scope="session"/>
            <c:set var="status" value="${status}" scope="session"/>
           </c:otherwise>
       </c:choose>
      <c:set var="root" value="${pageContext.request.contextPath}"/>
      <link rel="stylesheet" type="text/css" href="${root}/resources/css/commons/common.css"/>      <!-- footer, title css -->
      <link rel="stylesheet" type="text/css" href="${root}/resources/css/commons/category.css" />      <!-- category css -->
      <link rel="stylesheet" type="text/css" href="${root}/resources/css/main/main.css"/>         <!-- main css -->
      
      <link rel="stylesheet" type="text/css" href="${root}/resources/css/main/demo.css" />
      <link rel="stylesheet" type="text/css" href="${root}/resources/css/main/elastislide.css" />
      <script src="${root}/resources/scripts/modernizr.custom.17475.js"></script>
      <script type="text/javascript" src="${root}/resources/scripts/jquery-2.1.1.js"></script>
      <script type="text/javascript">
         $(document).ready(function(){
            var email="${email}";
            //alert(email);
            var param="email=" + email;
            $.ajax({
               url:"MainAjax?" + param,
               type:"get",
               dataType:"json",
               error: function(xhr, status, error) { alert("error : " +status); },
               success: function(data){
                  //alert(data);
                  var openDay=data.openDay;
                  var newStore=data.newStoreList;
                  var hotStore=data.hotplaceList;
                  var likeReview=data.likeList;
                  var followReview=data.followReview;
                  var followStore=data.followStoreList;
                  //alert(followReview[0].nickName);   
                  var i = 1;
                  
                  var newStoreid= "#newStoreTit1";
                  var newStoreadd = "#newStoreAdd1";
                  var newStorepic = "#newStorePic1";
                  var newStorehrf = "#newStoreHrf1";
                  
                  var hotStoreid= "#hotPlaceTit1";
                  var hotStoreadd = "#hotPlaceAdd1";
                  var hotStorepic = "#hotPlacePic1";
                  var hotStorehrf = "#hotPlaceHrf1";
                  
                  var reviewNick= "#reviewNick1";
                  var reviewStore = "#reviewStore1";
                  var reviewPic = "#reviewPic1";
                  var reviewHrf = "#reviewHrf1";
                  
                  var followReviewNick= "#followReviewNick1";
                  var followReviewStoreName = "#followReviewStoreName1";
                  var followReviewPic = "#followReviewPic1";
                  var followReviewHrf = "#followReviewHrf1";
                  
                  var followStoreNick= "#followStoreNick1";
                  var followStoreStoreName = "#followStoreStoreName1";
                  var followStorePic = "#followStorePic1";
                  var followStoreHrf = "#followStoreHrf1";
                  
                  
                  for(i; i <=6;){
                     //alert(likeReview[i].storeName);
                     //alert("id"+id);
                     //alert(newStore[0].profilePic);
                     //var profilePic=newStore[i-1].profilePic;
                     //alert(profilePic);
                     
                     // 새로 오픈한 스토어 ajax 적용
                     $(newStoreid).text(openDay[i-1]+"일");
                     $(newStoreadd).text(newStore[i-1].storeName);
                     if(newStore[i-1].profilePic != null){
                        $(newStorepic).css("background", "url(\""+ "${root}" + newStore[i-1].profilePic +"\")");   
                     }else{
                        $(newStorepic).css("background", "url('/home/resources/images/images/ex4.jpg')");
                     }
                     $(newStorepic).css("background-size", "100% 100%");
                     var item="&storeId="+newStore[i-1].storeId;
                     $(newStorehrf).attr("href","/home/AjaxStore?"+ item);
                     
                     // 핫플레이스 ajax 적용
                     $(hotStoreid).text("평점:" + hotStore[i-1].rate);
                     $(hotStoreadd).text(hotStore[i-1].storeName);
                     if(hotStore[i-1].profilePic != ''){
                        $(hotStorepic).css("background", "url(\""+ "${root}" + hotStore[i-1].profilePic +"\")");   
                     }else{
                        $(hotStorepic).css("background", "url('/home/resources/images/images/ex4.jpg')");
                     }
                     $(hotStorepic).css("background-size", "100% 100%");
                     var item="&storeId="+hotStore[i-1].storeId;
                     $(hotStorehrf).attr("href","/home/AjaxStore?"+ item);
                     
                     //좋아요 리뷰 ajax 적용
                     $(reviewNick).text(likeReview[i-1].nickName);
                     $(reviewStore).text(likeReview[i-1].storeName);
                     if(likeReview[i-1].profilePic != ''){
                        $(reviewPic).css("background", "url(\""+ "${root}" + likeReview[i-1].profilePic +"\")");   
                     }else{
                        $(reviewPic).css("background", "url('/home/resources/images/images/ex4.jpg')");
                     }
                     $(reviewPic).css("background-size", "100% 100%");
                     var item="&storeId="+likeReview[i-1].storeId;
                     $(reviewHrf).attr("href","/home/AjaxStore?"+ item);
                     
                     if(followReview != ''){
                        //followMember 리뷰 ajax 적용
                        $(followReviewNick).text(followReview[i-1].nickName);
                        $(followReviewStoreName).text(followReview[i-1].storeName);
                        if(followReview[i-1].profilePic != ''){
                           $(followReviewPic).css("background", "url(\""+ "${root}" + followReview[i-1].profilePic +"\")");   
                        }else{
                           $(followReviewPic).css("background", "url('/home/resources/images/images/ex4.jpg')");
                        }
                        $(followReviewPic).css("background-size", "100% 100%");
                        var item="&storeId="+followReview[i-1].storeId;
                        $(followReviewHrf).attr("href","/home/AjaxStore?"+ item);
                        
                        //followStore 리뷰 ajax 적용
                        $(followStoreNick).text(followStore[i-1].nickName);
                        $(followStoreStoreName).text(followStore[i-1].storeName);
                        if(followStore[i-1].profilePic != ''){
                           $(followStorePic).css("background", "url(\""+ "${root}" + followStore[i-1].profilePic +"\")");   
                        }else{
                           $(followStorePic).css("background", "url('/home/resources/images/images/ex4.jpg')");
                        }
                        $(followStorePic).css("background-size", "100% 100%");
                        var item="&storeId="+followStore[i-1].storeId;
                        $(followStoreHrf).attr("href","/home/AjaxStore?"+ item);
                     }
                     
                     
                     //id값 초기화
                     newStoreid = "#newStoreTit";
                     newStoreadd= "#newStoreAdd";
                     newStorepic= "#newStorePic";
                     newStorehrf= "#newStoreHrf";
                     
                     hotStoreid= "#hotPlaceTit";
                     hotStoreadd = "#hotPlaceAdd";
                     hotStorepic = "#hotPlacePic";
                     hotStorehrf = "#hotPlaceHrf";
                     
                     reviewNick= "#reviewNick";
                     reviewStore = "#reviewStore";
                     reviewPic = "#reviewPic";
                     reviewHrf = "#reviewHrf";
                     
                     followReviewNick= "#followReviewNick";
                     followReviewStoreName = "#followReviewStoreName";
                     followReviewPic = "#followReviewPic";
                     followReviewHrf = "#followReviewHrf";
                     
                     followStoreNick= "#followStoreNick";
                     followStoreStoreName = "#followStoreStoreName";
                     followStorePic = "#followStorePic";
                     followStoreHrf = "#followStoreHrf";
                     
                     //id값에 +1씩
                     i++;
                     
                     newStoreid+=i;
                     newStoreadd+=i;
                     newStorepic+=i;
                     newStorehrf+=i;
                     
                     hotStoreid+=i;
                     hotStoreadd+=i;
                     hotStorepic+=i;
                     hotStorehrf+=i;
                     
                     reviewNick+=i;
                     reviewStore+=i;
                     reviewPic+=i;
                     reviewHrf+=i;
                     
                     followReviewNick+=i;
                     followReviewStoreName+=i;
                     followReviewPic+=i;
                     followReviewHrf+=i;
                     
                     followStoreNick+=i;
                     followStoreStoreName+=i;
                     followStorePic+=i;
                     followStoreHrf+=i;
                  }
               }
            });
         });
      </script>
      <script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=true"></script>
      <script type="text/javascript">
      // Note that using Google Gears requires loading the Javascript
      // at http://code.google.com/apis/gears/gears_init.js
            
        var initialLocation;
        var siberia = new google.maps.LatLng(60, 105);
        var newyork = new google.maps.LatLng(50.69847032728747, -73.9514422416687);
        var browserSupportFlag = new Boolean();
        
        function initialize(){
            // Try W3C Geolocation (Preferred)
            if (navigator.geolocation) {
                browserSupportFlag = true;                    
                navigator.geolocation.getCurrentPosition(function(position){
                   GoogleMap.initialize(position.coords.latitude, position.coords.longitude);
                }, function(){
                    handleNoGeolocation(browserSupportFlag);
                });
                // Try Google Gears Geolocation
            }            
         else {
             browserSupportFlag = false;
             handleNoGeolocation(browserSupportFlag);
         }
            
            GoogleMap = {initialize : function(latitude, logitude) {
               var geocoder = new google.maps.Geocoder();
               geocoder.geocode({'latLng': new google.maps.LatLng(latitude, logitude)},
               function(result, status) {
                  var address = result[2].formatted_address;
                  var addressArray = address.split(" ");
                  var addr = addressArray[1] + " " + addressArray[2];
                  //var index = address.indexOf(" ");
                  //var addr = address.substring(index+1, address.length);
                    $.ajax({
                       type:"get",
                        url:"${root}/getLocalStore/",
                        data:"address=" + addr,
                        contentType:"text/xml; charset=utf-8", 
                        dataType:"html",
                        error: function(xhr, status, error) { alert("error : " +status); },
                        success: function(data){
                          //alert(data);
                           var divRegion = document.getElementById("region");
                           divRegion.innerHTML = data;                 
                        } 
                 }); // Ajax 호출 및 이벤트 핸들러 함수 정의
               });
               }
            }
            
            function handleNoGeolocation(errorFlag){
                if (errorFlag == true) {
                   document.getElementById("address").value = "";   
                }
                else {
                   document.getElementById("address").value = "";
                }
            }           
        }
      </script>
   </head>
   <body onload="initialize()" al>
      <div>
         <jsp:include page="../common/title.jsp"/>      <!-- title -->
      </div>
      <div>
         <jsp:include page="searchBar.jsp"/>            <!-- searchBar -->
      </div>
      
      <div class="content">
         <div class="main_content">
         
            <div class="store_box">
               <div class="store_box_title">
                  <img src="${root}/resources/images/images/1_HOT2.png" height="30">
               </div>
               <div class="stores" id="pic_slide">
                  <div class="slide_title">
                     <ul id="carousel1" class="elastislide-list">
                        <c:forEach begin="1" end="6" varStatus="s">
                           <li class="main_recommend" id="hotPlace">
                              <a href="#" id="hotPlaceHrf${s.count}">
                                 <div id="hotPlacePic${s.count}" class="pic1" style="background: url(/home/resources/images/images/ex1.jpg); background-size: 250px;">
                                    <div class="text">
                                       <span id="hotPlaceTit${s.count}" class="tit">7Train</span><br/>
                                       <span id="hotPlaceAdd${s.count}" class="add">강남역 11번 출구</span>
                                    </div>
                                 </div>
                              </a>
                           </li>
                        </c:forEach>
                     </ul>
                  </div>
               </div>
            </div>
            
            <div class="store_box">
               <div class="store_box_title">
                  <img src="${root}/resources/images/images/2_REGION2.png" height="30">
               </div>
               <div class="stores" id="pic_slide">
                  <div class="slide_title" id="region">
                     
                  </div>
               </div>
            </div>
            
            <div class="store_box">
               <div class="store_box_title">
                  <img src="${root}/resources/images/images/3_LIKES2.png" height="30">
               </div>
               <div class="stores" id="pic_slide">
                  <div class="slide_title">
                     <ul id="carousel3" class="elastislide-list">
                        <c:forEach begin="1" end="6" varStatus="s">
                           <li class="main_recommend" id="likeReview">
                              <a href="#" id="reviewHrf${s.count}">
                                 <div id="reviewPic${s.count}" class="pic1" style="background: url(/home/resources/images/images/ex1.jpg); background-size: 250px;">
                                    <div class="text">
                                       <span id="reviewNick${s.count}" class="tit">7Train</span><br/>
                                       <span id="reviewStore${s.count}" class="add">강남역 11번 출구</span>
                                    </div>
                                 </div>
                              </a>
                           </li>
                        </c:forEach>
                     </ul>
                  </div>
               </div>
            </div>
            
            <div class="store_box">
               <div class="store_box_title">
                  <img src="${root}/resources/images/images/4_NEW2.png" height="30">
               </div>
               <div class="stores" id="pic_slide">
                  <div class="slide_title">
                     <ul id="carousel4" class="elastislide-list">
                     <c:forEach begin="1" end="6" varStatus="s">
                        <li class="main_recommend" id="newOpen">
                           <a href="#" id="newStoreHrf${s.count}">
                              <div id="newStorePic${s.count}"class="pic1" style="background: url(/home/resources/images/images/ex1.jpg); background-size: 250px;">
                                 <div class="text">
                                    <span id="newStoreTit${s.count}" class="tit">7Train</span><br/>
                                    <span id="newStoreAdd${s.count}" class="add">강남역 11번 출구</span>
                                 </div>
                              </div>
                           </a>
                        </li>
                     </c:forEach>
                     </ul>
                  </div>
               </div>
            </div>
            
            <c:if test="${status == 'member'}">
               <div class="store_box">
                  <div class="store_box_title">
                     <img src="${root}/resources/images/images/4_NEW2.png" height="30">
                  </div>
                  <div class="stores" id="pic_slide">
                     <div class="slide_title">
                        <ul id="carousel5" class="elastislide-list">
                           <c:forEach begin="1" end="6" varStatus="s">
                              <li class="main_recommend" id="followReview">
                                 <a href="#" id="followReviewHrf${s.count}">
                                    <div id="followReviewPic${s.count}" class="pic1" style="background: url(/home/resources/images/images/ex1.jpg); background-size: 250px;">
                                       <div class="text">
                                          <span id="followReviewNick${s.count}" class="tit">7Train</span><br/>
                                          <span id="followReviewStoreName${s.count}" class="add">강남역 11번 출구</span>
                                       </div>
                                    </div>
                                 </a>
                              </li>
                           </c:forEach>
                        </ul>
                     </div>
                  </div>
               </div>
            
               <div class="store_box">
                  <div class="store_box_title">
                     <img src="${root}/resources/images/images/4_NEW2.png" height="30">
                  </div>
                  <div class="stores" id="pic_slide">
                     <div class="slide_title">
                        <ul id="carousel6" class="elastislide-list">
                           <c:forEach begin="1" end="6" varStatus="s">
                              <li class="main_recommend" id="followStore">
                                 <a href="#" id="followStoreHrf${s.count}">
                                    <div id="followStorePic${s.count}" class="pic1" style="background: url(/home/resources/images/images/ex1.jpg); background-size: 250px;">
                                       <div class="text">
                                          <span id="followStoreNick${s.count}" class="tit">7Train</span><br/>
                                          <span id="followStoreStoreName${s.count}" class="add">강남역 11번 출구</span>
                                       </div>
                                    </div>
                                 </a>
                              </li>
                           </c:forEach>
                           
                        </ul>
                     </div>
                  </div>
               </div>
            </c:if>
            
            <script type="text/javascript" src="${root}/resources/scripts/jquery.min.js"></script>
            <script type="text/javascript" src="${root}/resources/scripts/jquerypp.custom.js"></script>
            <script type="text/javascript" src="${root}/resources/scripts/jquery.elastislide.js"></script>
            <script type="text/javascript">
               $('#carousel1').elastislide();
               $('#carousel2').elastislide();
               $('#carousel3').elastislide();
               $('#carousel4').elastislide();
               $('#carousel5').elastislide();
               $('#carousel6').elastislide();
            </script>
            <script type="text/javascript"> 
               $.fn.getLeft = function() { 
                  var element = $(this).get(0); 
                  var x = 0; 
                  for ( var e = element; e; e = e.offsetParent) { 
                     x += e.offsetLeft; 
                  } 
                  return x; 
               }; 
               $.fn.getTop = function() { 
                  var element = $(this).get(0); 
                  var y = 0; 
                  for ( var e = element; e; e = e.offsetParent) { 
                     y += e.offsetTop; 
                  } 
                  return y; 
               }; 
               $(document).ready(function(){ 
                  $(".target").mouseenter(function(){ 
                     var left = $(this).getLeft();
                     var top = $(this).getTop(); 
                     var width = $(this).width(); 
                     var height = $(this).height(); 
                     var text = $(this).attr("text"); 
                     var overlay = $("<div id='overlay_"+$(this).index()+"' class='overlay'></div>"); 
                     overlay.css({ 
                        "left":left+"px", 
                        "top":top+"px", 
                        "width":width+"px", 
                        "height":height+"px", 
                        "line-height":height+"px", 
                        "display":"none" 
                        }).text(text).mouseleave(function(){ 
                        $(".overlay").fadeOut(function(){ 
                           $(this).remove(); 
                        }); 
                     }).appendTo($("body")).fadeIn(); 
                  }); 
                  $("#images").css({ 
                     "width":($(".target").eq(0).width()*3)+"px", 
                     "margin-left":Math.max(($(window).width()/2-($(".target").eq(0).width()*3)/2),0)+"px", 
                     "margin-top":Math.max(($(window).height()/2 -($(".target").eq(0).height()*(Math.ceil($(".target").size()/3)))/2),0)+"px" 
                  }); 
                  $(window).resize(function(){ 
                     $(".overlay").remove(); 
                     setResize(); 
                  }); 
               }); 
               var setResize = function(){ 
                  $("#images").css({ 
                     "margin-left":Math.max(($(window).width()/2-($(".target").eq(0).width()*3)/2),0)+"px", 
                     "margin-top":Math.max(($(window).height()/2 -($(".target").eq(0).height()*(Math.ceil($(".target").size()/3)))/2),0)+"px" 
                  }); 
               } 
            </script>
            
            <script type="text/javascript" src="${root}/resources/scripts/jQueryWeb.js"></script> 
            <script type="text/javascript" src="${root}/resources/scripts/jQueryWeb2.js"></script>
         </div>
      </div>
      
      <div>
         <jsp:include page="../common/footer.jsp"/>         <!-- footer -->
      </div>
   </body>
</html>