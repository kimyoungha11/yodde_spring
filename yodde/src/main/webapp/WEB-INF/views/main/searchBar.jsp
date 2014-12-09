<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<script type="text/javascript" src="${root}/resources/scripts/jquery-2.1.1.js"></script>
<script type="text/javascript">
function search(checked){
	var storeInfo = checked;
	//alert(checked);
	var query=$("#query").val();
	//alert(query);
	if(query.length==0){
	 alert("검색어를 입력하세요");
	 $('.check').attr('checked', false);
	}else if(query.match("@")){
	   query=query.substring(1, query.length);
	   $(location).attr("href", "${root}/searchMember?query=" + query);
	}else if(query.match("#")){
	   query=query.substring(1, query.length);
	   $(location).attr("href", "${root}/searchTag?query=" + query);
	}else if(checked.length>0 && query.length>0){
		$(location).attr("href", "${root}/searchStoreByStoreInfo?query="+query+"&storeInfo="+storeInfo);
		//alert("query="+query+"\n"+storeInfo);
	}else if(checked.length==0 && query.length>0){
	   $(location).attr("href", "${root}/searchStore?query=" + query);
	} 
}
</script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script> 
   $(document).ready(function(){
      $("#flip").click(function(){
         $("#panel").slideToggle("slow");
      });
   });
</script>
<style> 
   #panel{
      text-align:center;
      border:solid 2px #c3c3c3;
      padding:10px;
      display:none;
      position: fixed;
      background-color:white;
   }
</style>
<body>
      <div style="width:100%;">
      
         <ul class="search_bar">
            <li class="option_btn">
               <a href="#" style="font-size: 20px;" id="flip">
                  ▼ 
               </a>
    
               <div id="panel" >
                  <script>
                     var option = ["creditcard", "delivery", "drivethrough", "group1", "kids", "parking",
                                   "reservation", "seating", "takeout", "toilet", "tv", "wifi"];
                     var optionUrl = [];
                     var j=0;
                     var k=0;
                     var url = "";
                     
                     for (i=0; i<option.length; i++){
                        optionUrl.push("${root}/resources/images/store_info_img/"+option[i]+".png");
                     }
                     
                     for(var i=0; i<option.length*2; i++){
                         $(document).ready(function() {
 							if(j%2!=0){
 								$("#img").children().eq(j-1).attr("value", option[k]);
 								$("#img").children().eq(j).attr("title", option[k]);
 								$("#img").children().eq(j).css({
 									"background-image":"url("+optionUrl[k]+")",
 									"background-size" : "36px 72px" 
 								});
 								k++
 							}
 							j++;
 					    }); 
                     }
                     
                     function check(){
                    	 var checked="";
                    	   $("input[name='icon']:checked").each(function (){
                    		  checked+=$(this).val()+" ";
                    	   });
                    	//alert(checked);
						search(checked);
                     }
                   </script>
               		<div id="img">
               			<c:forEach begin="0" end="11" varStatus="s">
               				<input type="checkbox" name="icon" id="icon${s.count}" class="css-checkbox check" >
               				<label id ="icon${s.count}" for="icon${s.count}" class="css-label"></label>
               			</c:forEach>
                  	</div>
               </div>
            </li>
            <li id="search" class="search">
               <input type="text" id="query" class="input_text" tabindex="5" style="ime-mode: active;"
                  placeholder=" STORE/#TAG/@NICKNAME" onfocus="this.placeholder=''" 
                  onblur="this.placeholder=' STORE/#TAG/@NICKNAME'" autocomplete="off"
                  onkeydown="if(event.keyCode==13){javascript:check();}"/>
            </li>
            <li class="enter_btn">
				<input type="IMAGE" class="review_write" src="${root}/resources/images/images/search4.png" height="40" name="Submit" value="Submit" onclick="javascript:check()">
				
            </li>
         </ul>
      </div>
</body>
</html>