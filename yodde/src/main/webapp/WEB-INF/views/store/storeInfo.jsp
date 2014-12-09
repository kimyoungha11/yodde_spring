<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>요때</title>
      <c:set var="root" value="${pageContext.request.contextPath}" />
      <c:set var="email" value="${sessionScope.email}" />
      
      <link rel="stylesheet" type="text/css" href="${root}/resources/css/commons/common.css" />       <!-- footer, title css -->
      <link rel="stylesheet" type="text/css" href="${root}/resources/css/commons/category.css" />    <!-- category css -->
      <link rel="stylesheet" type="text/css" href="${root}/resources/css/main/main.css" />          <!-- main css -->
      <link rel="stylesheet" type="text/css" href="${root}/resources/css/store/store.css" />
      
      <script type="text/javascript" src="${root}/resources/scripts/jquery-2.1.1.js"></script>
      <script type="text/javascript" src="${root}/resources/scripts/jquery.raty.js"></script>
      <script type="text/javascript">                                    /* 리뷰 작성 */
         function writeReview() {   
            alert("write");
         }
         function showReviewEditor(email) {
            if (email == "") {
               alert("로그인 후 이용하세요.");
               return;
            }
            var historyCheck = document.getElementById("historyCheck").value;
            if(historyCheck==1){
               alert("이미 리뷰를 남기셨습니다.");
               return;
            }
            
            var obj = document.getElementById("reviewEditorDiv");
            if (obj.style.display == "")
               obj.style.display = "none";
            else
               obj.style.display = "";
         }
      </script>
      
      <script type="text/javascript">                                    /* 수정버튼 요청 함수 */
         function showUpdateEditor(email, content, reviewId){   
            //alert("showupdate/email : " + email + ", content : " + content + ", reviewId : " + reviewId);
         
             /*기존에 있던 공간들*/
            var originalDiv = document.getElementById("originalDiv");
            var hide = document.getElementById("hide");
            var updateBtn = document.getElementById("updateBtn");
            var delBtn = document.getElementById("delBtn");
            
            originalDiv.style.display="none";
            hide.style.display="none";
            updateBtn.style.display="none";
            delBtn.style.display="none";
            
            /*새로 만들 공간들*/
            var updateEditorDiv = document.getElementById("updateEditorDiv");
            var update_rate = document.getElementById("update_rate");
            var okBtn2 = document.getElementById("okBtn2");
            var canBtn = document.getElementById("canBtn");
            var updateValue = document.getElementById("updateValue");

            updateValue.value=content;
            updateEditorDiv.style.display="";
            update_rate.style.display="";
            okBtn2.style.display="";
            canBtn.style.display="";
            
            $("#okBtn2").click(function(){
               var rate = document.getElementById("update_rate").value;
               //alert("rate = " + rate);
                var url="updateReivewAction?reviewId=" + reviewId + "&updatedContent=" + updateValue.value + "&rate=" + rate;
                //alert("okBtn clicked url: " + url);
                $(document).ready(function(){   
                   $.ajax({
                     url:url,
                     type:"get",
                     contentType:"text/xml; charset=utf-8", 
                     dataType: "text",
                     error: function(xhr, status, error) { alert("error : " +status); },
                     success: function(data){
                        //alert("OK");
                        location.reload();
                     }
                  });
               });
            });
         }
         
         function returnUpdateEditer(){                              /* 수정취소버튼 요청 함수 */
            var original = document.getElementById("originalDiv");
            var hide = document.getElementById("hide");
            var updateBtn = document.getElementById("updateBtn");
            var delBtn = document.getElementById("delBtn");
            var updateValue = document.getElementById("updateValue");
            
            original.style.display="";
            hide.style.display="";
            updateBtn.style.display="";
            delBtn.style.display="";
            updateValue.innerHTML="";
            
            var obj = document.getElementById("updateEditorDiv");
            var update_rate = document.getElementById("update_rate");
            var okBtn2 = document.getElementById("okBtn2");
            var canBtn = document.getElementById("canBtn");
            
            obj.style.display="none";
            //obj.document = content;
            update_rate.style.display="none";
            okBtn2.style.display="none";
            canBtn.style.display="none";
         }
      </script>
      
      <script>
         function loginFollow(){
            alert("로그인을 해주세요.");
         }
         
         function followCheck(){
            var mail="${email}";
            var store="${storeDto.storeId}";
            var url="followStore?email=" + mail + "&storeId=" + store;
            
            $.ajax({
               url:url,
               type:"get",
               contentType:"text/xml; charset=utf-8", 
               dataType: "text",
               error: function(xhr, status, error) { alert("error : " +status); },
               success: function(data){
                  //alert(data);
                  if(data ==1){
                     $("#follow").attr("src", "${root}/resources/images/images/follow.png");   
                  }else{
                     $("#follow").attr("src", "${root}/resources/images/images/notfollow.png");
                  }
               }
            }); // Ajax 호출 및 이벤트 핸들러 함수 정의
         }
      </script>
      <script type="text/javascript">               /* 썸네일 팝업 함수 */
               function open_win(src){
                  window.open(src,"사진 크게보기",
                   "width=500,height=500,toolbar=no, status=no, menubar=no,scrollbars=no,resizeable=no,left=300,top=150");
               }
      </script>
      <script type="text/javascript">             /* 리뷰 사진올리기 */
         function readURL(input) {
            if (input.files && input.files[0]) {
               var reader = new FileReader();
               reader.onload = function(e) {
                  $("#writePic1").attr("src", e.target.result);
               }
               reader.readAsDataURL(input.files[0]);
            }
            if (input.files && input.files[1]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                   $("#writePic2").attr("src", e.target.result);
                }
                reader.readAsDataURL(input.files[1]);
             }
            if (input.files && input.files[2]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                   $("#writePic3").attr("src", e.target.result);
                }
                reader.readAsDataURL(input.files[2]);
             }
            if (input.files && input.files[3]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                   $("#writePic4").attr("src", e.target.result);
                }
                reader.readAsDataURL(input.files[3]);
             }
            if (input.files && input.files[4]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                   $("#writePic5").attr("src", e.target.result);
                }
                reader.readAsDataURL(input.files[4]);
             }
         }
      </script>
      <script type="text/javascript">               /* 리뷰 삭제 */
         function del(reviewId, storeId){
            var reviewId = reviewId;
            var storeId = storeId;
            var deleteCheck=0;
            
            var url="deleteReview?reviewId="+reviewId+"&storeId="+storeId;
            //alert("del(reviewId) : " + url);
            
            if(!confirm("삭제하시겠습니까?")){
               return;
            }else{
               $.ajax({
                  url:url,
                  type:"get",
                  contentType:"text/xml; charset=utf-8", 
                  dataType: "text",
                  error: function(xhr, status, error) { alert("error : " +status); },
                  success: function(data){
                     //alert(data);
                     if(data ==1){
                        alert("삭제가 완료되었습니다.");
                        location.href=location.href;
                     }else{
                        alert("다시 시도해 주세요.");
                     }
                  }
               }); // Ajax 호출 및 이벤트 핸들러 함수 정의
            }
         }
      </script>
      <script type="text/javascript">               /* like unlike */
         function checkEval(eval, reviewId, likeNum, evalInfo, reviewEmail){
            var email = "${email}";
            var evaluator = "${eval[0].evaluator}";
            var evalInfo = evalInfo;
            //alert(evalInfo + ", " + eval);      //evalInfo : 기존정보, eval : 이번 정보
            
            if(email==reviewEmail){
               alert("본인의 리뷰는 평가할 수 없습니다.");
            }else{
               if(evalInfo==eval || evalInfo=="" ||  evalInfo==0){
                  evaluation(eval, reviewId, likeNum);
               }else{
                  alert("님 반대쪽에 투표했잖아염");
               }
            }
         }
      
         function evaluation(eval, reviewId, likeNum, reviewEmail) {
            var email="${email}";
            var url="evaluation?email=" + email + "&reviewId=" + reviewId + "&eval=" + eval;
            //alert("evaluation function / eval : "+ eval + "\treviewId : " + reviewId + "likeNum" + likeNum);
            var likeNum=likeNum;
         
            if (email == "") {
               alert("로그인 후 이용하세요.");
                  return;
            }
            else{
               $(document).ready(function(){
                  $.ajax({
                     url:url,
                     type:"post",
                     contentType:"text/xml; charset=utf-8", 
                     dataType: "text",
                     error: function(xhr, status, error) { alert("error : " +status); },
                     success: function(data){
                        //alert("ready function " + data);
                        $("#upNumber").text(likeNum);
                        location.reload();
                     }
                  });
               })
            }
         }
      </script>
   </head>
   <body>
      <div>
         <jsp:include page="../common/title.jsp" />    <!-- title -->
      </div>

      <div class="content">
         <div class="storeInfo_content">
            <div class="result_img">
               <!-- result title -->
               <img src="${root}/resources/images/images/about.png" height="30" />
               <span class="result_value"> <!-- 검색해서 넘어온 가게 이름 -->
                  ${storeDto.storeName}
               </span>
            </div>
            <div>
               <span class="category_position">
                  <span class="category_txt">
                  <!-- store의 category 값을 받아와서 txt로 띄움 --> 
                     <c:choose>
                        <c:when test="${storeDto.category3 != ''}">
                           ${storeDto.category1}>${storeDto.category2}>${storeDto.category3}   
                              </c:when>
                        <c:otherwise>
                           ${storeDto.category1}>${storeDto.category2}
                              </c:otherwise>
                     </c:choose>
                  </span>
               </span>
               <span class="status_position"> 
                  <span class="status">
                     <!-- store의 status 값을 받아와서 open / close 중 하나를 띄움 --> 
                     <c:choose>
                        <c:when test="${storeDto.status == 0}">
                           <img src="${root}/resources/images/images/close.png" height="30"/>
                        </c:when>
                        <c:otherwise>
                           <img src="${root}/resources/images/images/open.png" height="30"/>
                        </c:otherwise>
                     </c:choose>
                  </span>
               </span>
            </div>
   
            <div class="first_box">
               <ul class="storeInfo_ul">
                  <li class="storeInfo_box">
                     <div class="star rate">             <!-- 별점표시  -->
                             <span class="rate_title"><img src="${root}/resources/images/images/rate_title.png" height="35"></span> 
                              <span id="averageRate" class="input"></span>
   
                            <script>
                           $.fn.raty.defaults.path = '${root}/resources/images/images';
                           $('#averageRate').raty({
                              round : { down: .26, full: .6, up: .76 },
                              halfShow : true,
                              readOnly: true,
                              starOff : 'review_btnOff.png',
                              starOn  : 'review_btnOn.png',
                              starHalf: 'review_half.png',
                              score: '${storeDto.rate}'
                           });
                        </script>
                                ${storeDto.rate}
                     </div>
                     <div class="txt">                   <!-- 스토어 정보 -->
                        영업시간 : ${storeDto.serviceTime}<br/>         <!-- service Time -->
                        주소 : ${storeDto.address}<br/>            <!-- Address -->
                        개업일 : <fmt:formatDate value="${storeDto.openDate}" type="date" pattern="yyyy-MM-dd"/> <br/>
                        홈페이지 : ${storeDto.homepage}<br/>         <!-- homepage Address -->
                        연락처 : ${storeDto.phoneNum}<br/>            <!-- phone Number -->
                     </div>
   
                     <div style="position: absolute;">
                        <div class="request_btn">
                           <a href=""> <img src="${root}/resources/images/images/update_reqpuest.png" height="20"></a>
                        </div>
   
                        <!-- 스토어 위치 -->
                        <div class="map">
                           <div id="scholes"
                              style="border: 2px solid #DCDCDF; width: 490px; height: 200px; margin: 5px;"></div>
                        </div>
                        <div class="follow_btn">                <!-- 팔로우 한 스토어와 안 한 스토어를 구별 -->
                           <c:choose>
                                      <c:when test="${email != ''}">
                                         <script type="text/javascript">
                                            $(document).ready(function(){
                                               //alert("asdf");
                                                var mail="${email}";
                                                var store="${storeDto.storeId}";
                                                var url="followStoreCheck?email=" + mail + "&storeId=" + store;
                                                $.ajax({
                                                   url:url,
                                                   type:"get",
                                                   contentType:"text/xml; charset=utf-8", 
                                                   dataType: "text",
                                                   error: function(xhr, status, error) { alert("error : " +status); },
                                                   success: function(data){
                                                      //alert(data);
                                                      if(data ==1){
                                                         $("#follow").attr("src", "${root}/resources/images/images/follow.png");   
                                                      }else{
                                                         $("#follow").attr("src", "${root}/resources/images/images/notfollow.png");
                                                      }
                                                   } }); // Ajax 호출 및 이벤트 핸들러 함수 정의
                                            });
                                         </script>
                                         <a href="javascript:followCheck()"><img src="${root}/resources/images/images/follow.png" height="35" id="follow"></a>
                                      </c:when>
                                      <c:otherwise>
                                         <a href="javascript:loginFollow()"><img src="${root}/resources/images/images/notfollow.png" height="30"></a>
                                      </c:otherwise>
                                </c:choose>
                        </div>
                     </div>
                  </li>
   
                  <li class="store_pic">
                     <c:choose>
                        <c:when test="${storeDto.profilePic != null}">
                           <img src="${root}${storeDto.profilePic}" width="300" height="300">
                        </c:when>
                        <c:otherwise>
                           <img src='${root}/resources/images/images/ex1.jpg' height='300'>
                        </c:otherwise>
                     </c:choose>
                  </li>
   
                  <li class="store_icon">
                     <!-- 스토어 info -->
                     <c:if test="${storeInfo.reservation==1}">
                        <img src="${root}/resources/images/images_store_info/reservation.png" width="45" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.delivery==1}">
                        <img src="${root}/resources/images/images_store_info/delivery.png" width="45" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.takeOut==1}">
                        <img src="${root}/resources/images/images_store_info/takeout.png" width="55" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.creditCard==1}">
                        <img src="${root}/resources/images/images_store_info/card.png" width="55" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.parking==1}">
                        <img src="${root}/resources/images/images_store_info/parking.png" width="55" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.group1==1}">
                        <img src="${root}/resources/images/images_store_info/group.png" width="55" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.toilet==1}">
                        <img src="${root}/resources/images/images_store_info/toilet.png" width="45" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.wifi==1}">
                        <img src="${root}/resources/images/images_store_info/wifi.png" width="50" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.tv==1}">
                        <img src="${root}/resources/images/images_store_info/tv.png" width="55" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.seating==1}">
                        <img src="${root}/resources/images/images_store_info/seating.png" width="55" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.kids==1}">
                        <img src="${root}/resources/images/images_store_info/kids.png" width="55" style="margin-right: 10px;">
                     </c:if>
                     <c:if test="${storeInfo.driveThrough==1}">
                        <img src="${root}/resources/images/images_store_info/drive_through.png" width="55" style="margin-right: 10px;">
                     </c:if>
                  </li>
               </ul>
            </div>
   
            <div class="img_collection">                      <!-- 모아보기 -->
               <div class="review_title">
                  <div style="background-color: white;">
<%--                      ${pictureList.size()==0} --%>
                     <img src="${root}/resources/images/images/review_pic.png" height="30">
                  </div>
               </div>
               <div class="reviewImg_box">
                  <c:choose>
                     <c:when test="${pictureList.size()==0}">
                        <div style="text-align:center; padding-top: 15px;">리뷰로 첫 사진을 등록해보세요!</div>
                     </c:when>
                     <c:otherwise>
                        <c:forEach var="itemPicture" items="${pictureList}">
                           <span class="review_img"> 
                              <img src="${root}${itemPicture.path}" style="max-width:118px;max-height:118px;height:expression(this.height > 118 ? 118: true); width:auto">
                           </span>
                        </c:forEach>
                        <span class="review_img"> 
                           <a href="morePicture?storeId=${storeDto.storeId}&storeName=${storeDto.storeName}">
                              <img src="${root}/resources/images/images/pic_more.png" height="118">
                           </a>
                        </span>
                     </c:otherwise>
                  </c:choose>
               </div>
            </div>
   
            <div class="write_box">
               <!-- 리뷰쓰기 창 -->
               <div class="review_title">
                  <span style="text-align: left; background-color: white;">
                     <img src="${root}/resources/images/images/review_title.png" height="30">
                  </span>
   
                  <div class="write_btn">
                     <a href="javascript:showReviewEditor('${email}')">
                        <img src="${root}/resources/images/images/write.png" height="25">
                     </a>
                  </div>
               </div>

               <!-- 작성 버튼을 누르면 나타나는 작성 창 -->
               <div id="reviewEditorDiv" style="display: none;" class="review_write">
                  <form action="writeReivew" method="post" enctype="multipart/form-data">
                     <!--요때점수 입력창-->
                     <div id="">
                        <span id="targetText"></span>
                        <span id="targetText-hint" class="input hint"></span>
                        <script>
                                 $.fn.raty.defaults.path = '${root}/resources/images/images';
                                 $(function() {
                                    $('#targetText').raty({
                                       target : '#targetText-hint',
                                       targetKeep: true,
                                       click: function(score, evt){
                                       $('#rate').val(score);
                                       /*별점 넘겨줘야됨 */
                                       }
                                    });
                                 });
                              </script>
                     </div>
   
                     <textarea name="content" cols=120 rows=5></textarea>
                     <span class="review_photo_position"> <!-- 리뷰에 첨부할 사진들 --> 
                        <a href=""><img src="${root}/resources/images/images/pic1.png" height="40" id="writePic1" onclick="open_win(src); return false;"></a> 
                        <a href=""><img   src="${root}/resources/images/images/pic2.png" height="40" id="writePic2" onclick="open_win(src); return false;"></a>
                        <a href=""><img   src="${root}/resources/images/images/pic3.png" height="40" id="writePic3" onclick="open_win(src); return false;"></a>
                        <a href=""><img   src="${root}/resources/images/images/pic4.png" height="40" id="writePic4" onclick="open_win(src); return false;"></a>
                        <a href=""><img   src="${root}/resources/images/images/pic1.png" height="40" id="writePic5" onclick="open_win(src); return false;"></a>
                     </span>
                     <input type="hidden" name="rate" id="rate"> 
                     <input type="hidden" name="writer" value="${email}"> 
                     <input type="hidden" name="storeId" value="${storeDto.storeId}">
                     <input align="right" type="file" name="files" onchange="readURL(this);" multiple="">
                     <input align="right" type="IMAGE" class="review_write" src="${root}/resources/images/images/ok.png" height="25" name="Submit" value="Submit">
                  </form>
               </div>
               <br/><br/>
   
               <div class="review_board">
                  <!-- 리뷰 보드 -->
                  <c:set var="historyCheck" value="0"/>
                  <c:forEach var="itemReview" items="${reviewList}">
                        <c:if test="${itemReview.writer_email==email}">
                           <input type="hidden" value="1" id="historyCheck"/>
                        </c:if>
                     <div class="review">
                        <!-- DB에서 리뷰 받아와서 뿌려줌 -->
                        <span class="reviewer_profile"> 
                           <span class="review_content">             <!-- 리뷰 내용 -->
                              <span id="hide">
                                 <span id="user_rate">
                                    <c:if test="${itemReview.rate==1}">
                                       <img src="${root}/resources/images/images/rate_1.png">
                                    </c:if>
                                    <c:if test="${itemReview.rate==2}">
                                       <img src="${root}/resources/images/images/rate_2.png">
                                    </c:if>
                                    <c:if test="${itemReview.rate==3}">
                                       <img src="${root}/resources/images/images/rate_3.png">
                                    </c:if>
                                    <c:if test="${itemReview.rate==4}">
                                       <img src="${root}/resources/images/images/rate_4.png">
                                    </c:if>
                                    <c:if test="${itemReview.rate==5}">
                                       <img src="${root}/resources/images/images/rate_5.png">
                                    </c:if>
                                 </span>
                                 <!-- 리뷰 찬반 -->
                                 <span class="updown_position"> 
                                    <!-- Like -->
                                    <a href="javascript:checkEval(1,'${itemReview.reviewId}', '${itemReview.like1}','${eval[0].eval}', '${itemReview.writer_email}')">
                                       <img src="${root}/resources/images/images/up.png" height="25">
                                    </a>
                                    <span id="upNumber">${itemReview.like1}</span>
                                    
                                    <!-- Unlike -->
                                    <a href="javascript:checkEval(2,'${itemReview.reviewId}', '${itemReview.unlike}', '${eval[0].eval}', '${itemReview.writer_email}')">
                                       <img src="${root}/resources/images/images/down.png" height="25">
                                    </a>
                                    <span id="downNumber">${itemReview.unlike}</span>
                                    <span id="itemReview_eval">
                                       
                                    </span>
                                 </span>
                              </span>
                              
                                 <span id="update_rate" style="display:none;">
                                    <span id="update"></span>
                                    <span id="edit-hint" class="input hint"></span>
                                    <script>
                                             $.fn.raty.defaults.path = '${root}/resources/images/images';
                                             $(function() {
                                                $('#update').raty({
                                                   target : '#edit-hint',
                                                   targetKeep: true,
                                                   click: function(score, evt){
                                                      $('#update_rate').val(score);
                                                      /*별점 넘겨줘야됨 */
                                                   }
                                                });
                                             });
                                          </script>
                                    </span>
      
                                 <p class="scroll_tag" id="originalDiv">${itemReview.content}</p>
                                 <p class="scroll_tag" id="updateEditorDiv" style="display: none;" class="review_write">
                                       <textarea id="updateValue" name="content" cols=103 rows=5 style="border:0px; background-color:#DCDCDF; resize: none;"></textarea>
                                    </p>
                                    
                                    <input type="hidden" name="rate" id="update_rate"> 
                                 <input type="hidden" name="writer" value="${email}">
                                 <input type="hidden" name="storeId" value="${storeDto.storeId}">
                                 <input id="canBtn" style="display:none;" align="right" type="IMAGE" src="${root}/resources/images/images/cancel.png" onclick="javascript:returnUpdateEditer(); return false;" height="25">      <!-- 수정 취소 버튼 -->
                                 <input id="okBtn" style="display:none;" align="right" type="IMAGE" class="review_write" src="${root}/resources/images/images/ok.png" height="25" name="Submit" value="Submit">
                                 <input id="okBtn2" style="display:none;" align="right" type="IMAGE" class="review_write" src="${root}/resources/images/images/ok.png" height="25">
                              <span> 
                                 <span class="review_photo_position">             <!-- 리뷰에 첨부된 사진들 --> 
                                    <c:forEach var="filepath" items="${itemReview.picPath}">
                                       <a href="">
                                          <img src="${root}${filepath}" height="40" onclick="open_win(src); return false;">
                                       </a>
                                    </c:forEach>
                                 </span>
                              </span>
                                 
                              <span class="content_btn">                         
                                       <span class="btn_position">
                                          <c:if test="${email == itemReview.writer_email}">   <!-- 본인댓글일 경우  수정 /삭제 -->
                                                <a href="javascript:showUpdateEditor('${email}','${itemReview.content}', '${itemReview.reviewId}')">
                                                   <img id="updateBtn" src="${root}/resources/images/images/update.png" height="25"></a>
                                       <a href="javascript:del('${itemReview.reviewId}', '${itemReview.storeId}')">
                                                   <img id="delBtn" src="${root}/resources/images/images/delete.png" height="25"></a>
                                                <%-- 
                                                <span id="okBtn" style="display:none;">         <!-- 수정 완료 버튼 -->
                                                   <a href="">
                                                      <img src="${root}/resources/images/images/ok.png" height="25"></a>
                                                </span>
                                                <span id="canBtn" style="display:none;">      <!-- 수정 취소 버튼 -->
                                                   <a href="javascript:returnUpdateEditer()">
                                                      <img src="${root}/resources/images/images/cancel.png" height="25"></a>
                                                </span>
                                                --%>
                                          </c:if>
                                          <c:if test="${email != itemReview.writer_email}">   <!-- 타인댓글일 경우  신고 -->
                                             <a href="reportReview?writer=${itemReview.writer}&content=${itemReview.content}" onclick="window.open(this.href,'_blank','width=750, height=700');return false" >
                                                <img src="${root}/resources/images/images/report.png" height="25" ></a>
                                          </c:if>
                                       </span> 
                                    </span>
                           </span> 
                           <span class="profile">       <!-- 리뷰어 프로필사진 --> 
                              <img src="${root}${itemReview.profilePic}" style="max-width:75px;width:expression(this.width > 75 ? 75: true); heigth:auto;border-radius: 75px;">
                              <!--<img src="${root}${itemReview.profilePic}" height="100"> -->
                           </span> 
                           <span class="reviewer_NICK"> <!-- 리뷰어 닉네임 -->
                              ${itemReview.writer}
                           </span>
                        </span>
                     </div>
                  </c:forEach>
   
                  <div class="review_more">             <!-- 더 많은 리뷰 보는 버튼-->
                     <a href=""><img src="${root}/resources/images/images/review_more.png" height="25"></a>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div>                                        <!-- footer -->
         <jsp:include page="../common/footer.jsp" />
      </div>
      <script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=1d8bf9910c14069fe8e8c0cfc135cb55&coord=latlng"></script>
         <script type="text/javascript">
         nhn.api.map.setDefaultPoint('LatLng');
         //var latitude = ${storeDto.latitude};
         var oMap = new nhn.api.map.Map(document.getElementById('scholes'), {  
               point : new nhn.api.map.LatLng(${storeDto.longitude},${storeDto.latitude}),         //아까 구한 위도, 경도   
               zoom : 11,                                                                        
               enableWheelZoom : true,                                                  
               enableDragPan : true,                                                      
               enableDblClickZoom : false,                                            
               mapMode : 0,                                                               
               activateTrafficMap : false,                                              
               activateBicycleMap : false,                                            
               minMaxLevel : [ 5, 13 ],                                                  
               size : new nhn.api.map.Size(490, 200)  
         });  
          
         var oSlider = new nhn.api.map.ZoomControl();
         oMap.addControl(oSlider);
         oSlider.setPosition({
               top : 10,
               left : 10
         });
           
         var oSize = new nhn.api.map.Size(20, 28);
         var oOffset = new nhn.api.map.Size(20, 20);
         var oPoint = new nhn.api.map.LatLng(${storeDto.longitude},${storeDto.latitude});
         var oIcon = new nhn.api.map.Icon('${root}/resources/images/images/pin2.png', oSize, oOffset); 
         var oMarker = new nhn.api.map.Marker(oIcon, {
               point:oPoint,
               zIndex:1,
               title: '${storeDto.storeName}'
         });
             
         var oLabel = new nhn.api.map.MarkerLabel();
         oMap.addOverlay(oLabel); 
         oMap.addOverlay(oMarker);
         oLabel.setVisible(true,oMarker);
           
         oMap.attach('mouseenter',function(oCustomEvent){    //마우스엔터,휠,클릭 등 api에서 제공하는 것 중에 골라서
               var oTarget = oCustomEvent.target;
               if(oTarget instanceof nhn.api.map.Marker){
                     var oMarker = oTarget;
                     oLabel.setVisible(true,oMarker);
               }
           });
         </script>
   </body>
</html>