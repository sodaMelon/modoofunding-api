<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../admin/sub_menu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
table {
	width: 800px;
}

#fundedlist{
	padding: 50px;
	border-collapse: collapse;
	margin:auto;
}
#fundedlist tr{
	border-bottom : 2px solid lightgray;
}
#fundedlist td{
	width: 200px;
	padding: 20px;
}
#fundedlist th{
	padding: 20px;
	font-size: 15px;
}
</style>

<script type="text/javascript" >

function go_reqcomm() {
		document.frm.action = "adminProjectReq=" + ${comment.pnum};
		document.frm.method = "post";
		document.frm.submit();
	}
	function go_list() {
		document.frm.action = "/doofun/adminProject";
		document.frm.submit();

	}
	function confirm() {
		document.frm.action = "adminProjectConfirm=" + ${comment.pnum};
		document.frm.method = "post";
		document.frm.submit();
	}
	function reject() {
		document.frm.action = "adminProjectReject=" + ${comment.pnum};
		document.frm.method = "post";
		document.frm.submit();
	}
	 function changeStatus1() {
	      document.frm.action = "adminChangeStatus1=" + ${project.pnum};
	      document.frm.method = "post";
	      document.frm.submit();

	   }
	   function changeStatus2() {
	      document.frm.action = "adminChangeStatus2=" + ${project.pnum};
	      document.frm.method = "post";
	      document.frm.submit();

	   }
	   function changeStatus3() {
	      document.frm.action = "adminChangeStatus3=" + ${project.pnum};
	      document.frm.method = "post";
	      document.frm.submit();

	   }
		function pick(){
			document.form.action = "adminProjectPick=" + ${project.pnum};
			document.form.submit();			
		}

	window.onload=function(){
		var year = Number(document.getElementById('year').value);
		var month = Number(document.getElementById('month').value);
		var day = Number(document.getElementById('day').value);
		toDay = new Date();
		var dDay = new Date(year, month - 1, day);

		var n = Math.floor((dDay.getTime() - toDay.getTime()) / 86400000) + 1;
		document.getElementById('input_dday').innerHTML = n + "???";
		
		var percent = document.getElementById('percent').value;
		
		if(percent > 100){
			document.getElementById('Percent').style.width = 100 + "%";
		} else {
			document.getElementById('Percent').style.width = percent + "%";
		}
	}
	function modify(){
		document.getElementById('story1').style.visibility = 'hidden';
		document.getElementById('story2').style.visibility = 'visible';
	}

	function modify_story(){
		var contents = CKEDITOR.instances.contents.getData();
		var update = document.getElementById('contents_hidden').innerHTML;
		update = contents;
		alert(update);

		var pnum = document.getElementById('pnum').value
		document.form.action = "modify_story" + pnum;
		document.form.method = "POST";
		document.form.submit();
	}
</script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
<meta charset="UTF-8">
<link href="css/detailproject.css" rel="stylesheet">
<title>???????????? ??????</title>
</head>
<body>
	<div>
		<form name="frm" method="post">
			<article>
				<div id=lb>
					<h1>#???????????? ??????</h1>
				</div>
				<br>

				<div>
					<h3>???????????? ?????????</h3>
					<c:choose>
						<c:when test='${comment.status == "1"}'>
							<input type="text" id=comment name="feedback" value="${comment.feedback}" />
						</c:when>
						<c:otherwise>
							<p id=comment>${comment.feedback}</p>
						</c:otherwise>
					</c:choose>
				</div>			
				<br>	
				<div id=btn>
					<input type=button class=btn_confirm value="??????" onclick="confirm()">
					&nbsp; <input type=button class=btn_reject value="??????" onclick="reject()">
				</div>
				<br><br>
				<hr id=hr>
				<h3>?????? ?????? ??????</h3>
				<c:choose>
					<c:when test='${pj.c_status != "0"}'>
						<div id=btn>
							<input type=button class=btn_ing value="??????"onclick="changeStatus1()"> 
							&nbsp; <input type=button class=btn_over value="??????" onclick="changeStatus2()">
							&nbsp; <input type=button class=btn_stop value="??????" onclick="changeStatus3()">
						</div>
					</c:when>
					<c:when test='${pj.c_status == "0"}'>
						<p id=comment>????????????.</p>
					</c:when>
				</c:choose>
				<br><br>
				<hr id=hr>
				<h3>???????????? ??????</h3>
				<div>
					<c:choose>
						<c:when test='${req.req_status == "0"}'>
							<p id=comment>????????????.</p>
						</c:when>
						<c:when test='${req.req_status == "1"}'>
							<p id=comment><b>????????????:</b> ${req.req_content}</p>
							<input type="text" id=comment name="req_comm" value="${req.req_comm}" />
							&nbsp;<input type=button class=btn_sub value="??????" onclick="go_reqcomm()" />
						</c:when>
						<c:when test='${req.req_status == "2"}'>
							<p id=comment><b>????????????:</b> ${req.req_content}</p>
							<p id=comment><b>?????????:</b> ${req.req_comm}</p>
						</c:when>
						<c:otherwise>  						
						</c:otherwise>
					</c:choose>
				</div>
				<br><br>
				<hr id=hr>
				<br>

				<div id=btn>
					<input type=button class=btn_list value="??????" onclick="go_list()">
				</div>
			</article>
		</form>
		</div>
		<br>
		<h2 style="padding-left: 38%;">???????????? ?????? ??????</h2>
<div id="con">
		<form name="form" id="detail" method="post">
			<input type="hidden" id="pnum" value="${project.pnum}">
			<input type="hidden" id="percent" value="${dday.percent}">
			<input type="hidden" id="year" value="${dday.year}">
			<input type="hidden" id="month" value="${dday.month}">
			<input type="hidden" id="day" value="${dday.day}">
			<input type="hidden" id="min_price1" value="${project.min_price1}">
			<input type="hidden" id="min_price2" value="${project.min_price2}">
			<input type="hidden" id="min_price3" value="${project.min_price3}">
			
			 <div id="fade" class="black_overlay"></div>         
         <a href="#" id="category">${project.pj_cate}</a><br><br>
         <div>
         <img src="upload/${project.pj_img}" width="620px" alt="project_img"><br>
			
        <c:choose>
			<c:when test="${project.c_status == 1}">				
						<input type="button" class="funding1" value="???????????? ????????????" onclick="go_funding()">
       					<input type="button" class="share" value="????????????" onclick="share()">					
			</c:when>
			<c:when test="${project.c_status == 2 or project.c_status == 4}">
				<input type="button" class="funding2" value="??????????????? ?????????????????????." disabled>
       			<input type="button" class="share" value="????????????" onclick="share()">
       		</c:when>
			<c:when test="${project.c_status == 3}">
				<input type="button" class="funding2" value="??????????????? ?????????????????????." disabled>
       			<input type="button" class="share" value="????????????" onclick="share()">
			</c:when>
		</c:choose>         
         <c:choose>         
            <c:when test="${pj.pick == 0}"> 
               <img src="images/dislike.png" id="heart" width="40px" onclick="pick()"><b id=likecount>${likecount}</b>
             </c:when>
            <c:when test="${pj.pick == 1}">
               <img src="images/like.png" id="heart"  width="40px" onclick="pick()"><b id=likecount>${likecount}</b>
            </c:when>  
           
            </c:choose> 
            
         <br>
         <h1 id="subject">${project.pj_sub}</h1>
         </div>
                  
         <div id="share_content" class="share_content">
         <a onclick="exit()" style="float:right;">X</a><br><br><br>
         <a>???????????? ????????????</a><br><br>
         <div class="addthis_inline_share_toolbox"></div> 
         </div>
         
         <div id="planner">
            <img src="upload/${project.pl_img}" width="30px" alt="project_img" style="border-radius: 150px; height:40px; width:40px;">
            &nbsp;<a style="color:black; vertical-align:4.5px;" href="<c:url value="projectlist${project.pj_id}"/>">${project.pl_name}</a>
         </div>
         <div id="pl_info">${project.pl_info}</div><br>
         <p>   
            <span id="label">?????? ?????? 
                  <label id="value1"><fmt:formatNumber value="${project.pj_goal}" pattern="#,###"/>???</label>
            </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <span id="label">????????? 
                  <label id="value2">${funding.count}???</label>
            </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <span id="label">?????? ?????? 
            	  <c:choose>
					<c:when test="${project.c_status == 1}">
						<label id="input_dday" class="input_dday">0???</label><a id="fin_value"> (${project.pj_fin})</a>
					</c:when>
					<c:when test="${project.c_status == 2 or project.c_status == 4}">
						<label id="input_dday2" class="input_dday">0???</label><a id="fin_value"> (${project.pj_fin})</a>
       				</c:when>
					<c:when test="${project.c_status == 3}">
						<label id="input_dday2" class="input_dday">??????</label><a id="fin_value"> (${project.pj_fin})</a>
					</c:when>
				</c:choose>                  
            </span>
         </p>
        	 ?????? ?????? <label id="sum"><fmt:formatNumber value="${funding.sum}" pattern="#,###"/>???</label>
         <span><a id="percent_value">(${dday.percent}%)</a></span>
         <div class="Graph">
            <p>
               <c:if test="${dday.percent > 99}">
               <svg id="svg">
                  <rect x="0" y="0" fill="#e9e9e9" height="2" width="100%"></rect>
                  <rect x="0" y="0" height="5" width="100%" fill="#430201"></rect>
               </svg>
            </c:if>
            <c:if test="${dday.percent < 100}">
               <svg id="svg">
                  <rect x="0" y="0" fill="#e9e9e9" height="2" width="100%"></rect>
                  <rect x="0" y="0" height="5" width="${dday.percent}%" fill="#430201"></rect>
               </svg>
            </c:if>
            </p>
         </div>
         <div class="plinfo">
         		<c:choose>
					<c:when test="${project.c_status == 1}"> 
							?????? ????????? ?????????????????? ?????? ???????????????.<br> ??????????????? ????????? ????????? ????????? ????????? ?????? ???????????????.
					</c:when>
					<c:when test="${project.c_status == 2}">
						????????? ??????????????????!<br> ????????? ?????? ????????? ?????? ????????? ???????????????.
       				</c:when>
					<c:when test="${project.c_status == 3}">
						????????? ????????? ????????? ????????? ????????? ?????????????????????.<br> ????????? ????????? ???????????????.
					</c:when>
					<c:when test="${project.c_status == 4}">
						?????? ????????? ???????????? ???????????????.<br> ????????? ????????? ???????????????.
					</c:when>
				</c:choose>           
           	
         </div><br><br>

         <div class="detailtab">
            <input type="radio" name="detailtab" id="story" checked> 
            <input type="radio" name="detailtab" id="gift" onclick="check_gift()"> 
            <input type="radio" name="detailtab" id="commu"> 
            <label for="story">???????????????</label>
            <label for="gift">????????????</label>
            <label for="commu">????????????</label>
            
            <div id="story_content" class="story_content" style="text-align: left;">
            
            <div id="story1">
               <p>${project.story}</p>
               <c:if test="${userId eq project.pj_id}">
               <a id="go_modify" onclick="modify()">????????????</a>
               </c:if>
            </div>
            <div id="story2">
               <textarea id="contents" name="storyboard">${project.story}</textarea>
               <script>
                  CKEDITOR.replace('contents', { filebrowserUploadUrl : '/upload', height : '500px'});
               </script><br>
               <a id="go_modify" onclick="modify_cancel()" style="background-color:gray;">????????????</a>&nbsp;&nbsp;&nbsp;
               <a id="go_modify" onclick="modify_story()">????????????</a>
               <input type="hidden" name="modify" id="modify" value="${storyreq.modify}"> <br />
            </div>
            </div>
            
            <div class="gift_content">
               <div id="gift1detail" style="visibility: visible;">
               <ul style="list-style-image: url(images/giftcount.png); line-height: 3px;">
                  <li id="gift_count">${gift.count1}?????? ??????</li>
               </ul><br>
                  <p id="gift1_price"><fmt:formatNumber value="${project.min_price1}" pattern="#,###"/>???+</p>
                  <p id="gift1_name">${project.gift_name1} ( X 1 )</p>
                  <c:choose>
					<c:when test="${project.c_status == 1}"> 
						  <c:choose>
								<c:when test="${funder.status == 1}">
									<input type="button" class="selfunding2" value="?????? ?????????????????????." onclick="go_mine()">
								</c:when>
								<c:otherwise>
									<input type="button" class="selfunding" value="????????????" onclick="go_funding()">
								</c:otherwise>
						  </c:choose>
					</c:when>
					<c:when test="${project.c_status == 2}">
                		  <input type="button" class="selfunding2" value="????????????" disabled>
       				</c:when>
					<c:when test="${project.c_status == 3}">
                 		 <input type="button" class="selfunding2" value="????????????" disabled>
					</c:when>
					<c:when test="${project.c_status == 4}">
                 		 <input type="button" class="selfunding2" value="????????????" disabled>
					</c:when>
				</c:choose>   
               </div>
               <br> <br> <br>
               <div id="gift2detail" style="visibility: visible;">
               <ul style="list-style-image: url(images/giftcount.png); line-height: 3px;">
                  <li id="gift_count">${gift.count2}?????? ??????</li>
               </ul><br>
                  <p id="gift2_price"><fmt:formatNumber value="${project.min_price2}" pattern="#,###"/>???+</p>
                  <p id="gift2_name">${project.gift_name2} ( X 1 )</p>
                  <c:choose>
					<c:when test="${project.c_status == 1}"> 
						  <c:choose>
								<c:when test="${funder.status == 1}">
									<input type="button" class="selfunding2" value="?????? ?????????????????????." onclick="go_mine()">
								</c:when>
								<c:otherwise>
									<input type="button" class="selfunding" value="????????????" onclick="go_funding()">
								</c:otherwise>
						  </c:choose>
					</c:when>
					<c:when test="${project.c_status == 2}">
                		  <input type="button" class="selfunding2" value="????????????" disabled>
       				</c:when>
					<c:when test="${project.c_status == 3}">
                 		 <input type="button" class="selfunding2" value="????????????" disabled>
					</c:when>
					<c:when test="${project.c_status == 4}">
                 		 <input type="button" class="selfunding2" value="????????????" disabled>
					</c:when>
				</c:choose>  
               </div>
               <br> <br> <br>
               <div id="gift3detail" style="visibility: visible;">
               <ul style="list-style-image: url(images/giftcount.png); line-height: 3px;">
                  <li id="gift_count" style="float:left;">${gift.count3}?????? ??????</li>
               </ul><br>
                  <p id="gift3_price"><fmt:formatNumber value="${project.min_price3}" pattern="#,###"/>???+</p>
                  <p id="gift3_name">${project.gift_name3} ( X 1 )</p>
				<c:choose>
					<c:when test="${project.c_status == 1}"> 
						  <c:choose>
								<c:when test="${funder.status == 1}">
									<input type="button" class="selfunding2" value="?????? ?????????????????????." onclick="go_mine()">
								</c:when>
								<c:otherwise>
									<input type="button" class="selfunding" value="????????????" onclick="go_funding()">
								</c:otherwise>
						  </c:choose>
					</c:when>
					<c:when test="${project.c_status == 2}">
                		  <input type="button" class="selfunding2" value="????????????" disabled>
       				</c:when>
					<c:when test="${project.c_status == 3}">
                 		 <input type="button" class="selfunding2" value="????????????" disabled>
					</c:when>
					<c:when test="${project.c_status == 4}">
                 		 <input type="button" class="selfunding2" value="????????????" disabled>
					</c:when>
				</c:choose>  
               </div> <br> <br>
               <p style="font-size:13px; color: dimgray;">?????? ???????????? ???????????? ????????? 30??? ???????????????. 30?????? ?????? ?????? ?????? ???????????????.</p>
               
               <br><br>
		         <c:if test="${userId eq project.pj_id}">
		         	<h2>??????????????? ?????? ??????</h2><br>
		         			<table id="fundedlist">
		         				<tr>
		         					<th>?????????</th>
		         					<th>?????????</th>
		         					<th>????????????</th>
		         					<th>??????</th>
		         					<th>????????????</th>
		         					<th>????????????</th>
		         				</tr>
		         				<c:forEach var="f" items="${funderList}">
		         				<tr>
		         					<td>${f.id}</td>
		         					<td>${f.tel}</td>
		         					<td>${f.zip}</td>
		         					<td>${f.address}, ${f.address2}</td>
		         					<td>
		         						<c:if test="${f.number == 0}">?????? ??????</c:if>
		         						<c:if test="${f.number == 1}">${project.gift_name1}</c:if>
		         						<c:if test="${f.number == 2}">${project.gift_name2}</c:if>
		         						<c:if test="${f.number == 3}">${project.gift_name3}</c:if>
		         					</td>
		         					<td><fmt:formatNumber value="${f.funded}" pattern="#,###"/>???</td>
		         				</tr>
		         				</c:forEach>
		         			</table>
		         <br>
		         </c:if>
            </div>
            <div class="commu_content">
               <c:if test="${ empty articles }">
                  <div class="community" style="background-color:white;">
                     <a id="commu_null" style="font-size:14px; color:black;">????????? ?????? ????????????.</a>
                  </div>
               </c:if>
               <c:if test="${! empty articles }">
                  <c:forEach var="p" items="${articles}">
                     <div class="community">
                           <c:if test="${p.id == project.pj_id }"><span style="float:left;">
                                 <a id="commu_planner">?????????</a>&nbsp;<a style="font-size:14px; color:black;">${p.name}</a></span>
                                 <span style="float:right; font-size:14px; color:black;"><a id="go_comment" href="<c:url value="/read=${p.cseq}"/>">?????? ?????? ??????</a></span></c:if>
                           <c:if test="${p.id != project.pj_id}"><span style="float:left;">
                                 <a style="font-size:14px; color:black;">${p.name}</a></span>
                                 <span style="float:right; font-size:14px; color:black;"><a id="go_comment" href="<c:url value="/read=${p.cseq}"/>">?????? ?????? ??????</a></span></c:if>
                           <br><br><a style="font-weight:bold; color:black; font-size:20px; margin">${p.csub}</a><br><br>
                           <a style="font-size:14px; color:#404040;">${p.ccon}</a><br>
                     </div>
                  </c:forEach>
               </c:if>
            </div>
         </div>
      </form>
	</div>	
</body>
</html>