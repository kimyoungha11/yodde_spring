<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>요때</title>
   <c:set var="root" value="${pageContext.request.contextPath}"/>
   <link rel="stylesheet" type="text/css" href="${root}/resources/css/commons/common.css"/>      <!-- footer, title css -->
   <link rel="stylesheet" type="text/css" href="${root}/resources/css/commons/category.css" />      <!-- category css -->
   <link rel="stylesheet" type="text/css" href="${root}/resources/css/main/main.css"/>               <!-- main css -->
   <link rel="stylesheet" type="text/css" href="${root}/resources/css/search/search.css"/>               <!-- main css -->
</head>
<script type="text/javascript" src="${root}/resources/scripts/jquery-2.1.1.js"></script>
<script>

   var startNumb = 1;
   var pageNumb = 2;
   var getStorePic="query=" + "${query}";
   function callOpenAPI(query, start) {
      var params = {"target" : "local", "query" : "", "display":10 , "start": start } // OpenAPI 요청변수 정의
      params.query = encodeURIComponent(query);
      var q = $.param(params);
      var ajax_url = "/home/proxy?" + q; // OpenAPI 요청 URL 구성
      $.ajax({ type: "get", url: ajax_url,
         contentType: "text/xml; charset=utf-8", dataType: "xml",
         error: function(xhr, status, error) { alert("error : " +status); },
         success: showResult }); // Ajax 호출 및 이벤트 핸들러 함수 정의
   }
   function showResult(xml) {// Ajax 호출 성공시 실행되는 함수
      var totalCount = $(xml).find("total").text(); // <total>값 추출
      var start = 0;
      var totalPage = Math.ceil(totalCount/10);   //총 생성되야 할 페이지 개
      //var pageNumb = 2;
      
      if(totalPage>=10) totalPage = 10;   //페이지개수가 10개가 넘으면 페이지개수는 10으로 고
      
      if(pageNumb!=totalPage){
         //$("#result").empty();
         $("#pageNumb").empty();
      }
      $("#resultCount").text(totalCount + "건 검색"); // <total>값 표시
      $(xml).find("rss").find("channel").find("item").each(function(idx) {
         var title = $(this).find("title").text(); // <title>값 추출
         var category = $(this).find("category").text();
         var telephone = $(this).find("telephone").text();
         var address = $(this).find("address").text();
         var roadAddress = $(this).find("roadAddress").text();
         var mapx = $(this).find("mapx").text();
         var mapy = $(this).find("mapy").text();
         var email = "${email}";

         //var item = "title="+ title + "&category="+ category + "&telephone=" + telephone + "&address=" + address + "&roadAddress=" + roadAddress;
         var item = "title="+ title + "&category="+ category + "&telephone=" + telephone + "&address=" + address + "&roadAddress=" + roadAddress + "&email=" + email;
         
         var info = "<br/>" + "<div class='result_stores'>"
         info += "<input type='hidden' id='getStorePic' value='" + address + "'/>"
         info += "<div class='recommend' style='float:left'><a href='javascript:insertStore(\""+item+"\",\""+mapx+"\",\""+mapy+"\")'>" + "<img src='${root}/resources/images/images/ex1.jpg' height='180' width='180'></a></div>"
         info += "<div style='float:left; padding-left:20px;'><a href='javascript:insertStore(\""+item+"\",\""+mapx+"\",\""+mapy+"\")'>" + title + "</a>" + "</br>" + category + "</br>" + telephone + "</br>" + address + "</br>" + roadAddress +"</div></div>";
         $("#result").append(info); // <title>값 표시
         start++;
      });
      
      $.ajax({
          url:"getStorePic?" + getStorePic,
          type:"get",
          dataType:"json",
          error: function(xhr, status, error) { alert("error : " +status); },
          success: function(data){
             store=data.list;
             //alert(store[0].address);
             
             
                for(var i=0;i<store.length;i++){
                   //alert(store[i].address);
                   $(".result_stores").find("input:hidden").each(function (idx){
                     if($(this).val()==store[i].address){
                        if(store[i].profilePic != ''){
                           $(this).next().find("img").attr("src", "${root}"+store[i].profilePic);
                        }
                       }
                   });
                }
          }
      });
      
      
      
      if(pageNumb <= totalPage && totalPage < 11){
         if(totalCount>=10){
            //for(pageNumb; pageNumb<= totalPage; pageNumb++){
            if(start % 10==0 || pageNumb == totalPage){
               if(pageNumb==1) {
                  startPage = 1;
               }else {
                  startNumb = (pageNumb-1) * 10 + 1;
               }
               
               var page = "<a href='javascript:callOpenAPI(\"${query}\",\""+startNumb+"\")'><img src='${root}/resources/images/images/review_more.png' height='30px'></a>";
               $("#pageNumb").append(page);
               pageNumb++;
            }
            //}
         }
         
         
      }
   }
   function insertStore(item, mapx, mapy){   
      $(document).ready(function() {
         jQuery.ajax({            
               type:"GET",
               url:"http://apis.daum.net/local/geo/transcoord",
               data:"apikey=aea5d21e8e375ed8d2aa0c5d97a6b62af132a0ce&x="+mapx+"&y="+mapy+"&fromCoord=KTM&toCoord=WGS84&output=json",
               dataType:"jsonp", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
               jsonp:"callback",
               success : function(data) {
                  item +="&mapx="+data.x+"&mapy="+data.y;
                   $(location).attr("href", "/home/getStoreInfo?" + item);
               //alert("item="+item+"\n mapx= "+data.x+", mapy= "+data.y);
               }
         })
      });

   }
</script>
   <body onload="javascript:callOpenAPI('${query}','1')">
      <div>
         <jsp:include page="../common/title.jsp"/>         <!— title —>
      </div>
      
      <div>
         <jsp:include page="../main/searchBar.jsp"/>               <!— searchBar —>
      </div>
      
      <script type="text/javascript" src="${root}/resources/scripts/jQueryWeb.js"></script> 
      <script type="text/javascript" src="${root}/resources/scripts/jQueryWeb2.js"></script>
      
      <div class="content">                           <!— content —>
         <div class="result_content">
            <div class="result_img">                  <!— result title —>
               <img src="${root}/resources/images/images/about.png" height="55">
               ${query}
            </div>
            <div id="resultCount" class = "resultCount"></div>
            <div id="result"></div>
            
            <input type="hidden" id="startNumb">
            <div id="pageNumb" style="text-align:center;"></div>
            
             <div class="request_Btn">            <!-- 스토어 등록요청 메일보내기 -->
               <a href="${root}/requestRegStore" onclick="window.open(this.href,'_blank',width=650, height=500);return false" ><img src="${root}/resources/images/images/request.png" height="20"></a>
            </div>
         </div>
      </div>
      
      <div>
         <jsp:include page="../common/footer.jsp"/>      <!— footer —>
      </div>
      
      
   </body>
</html>