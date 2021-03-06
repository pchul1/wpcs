<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : checkUseMonitoring.jsp
	 * Description : 점검및사용일지 모니터링
	 */  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript">
	function fn_daily_work_list(){
		var searchDeptNo = $('#searchDeptNo').val();
		if(searchDeptNo=='') {
			alert("지역본부를 선택해주세요.")
		}
		document.frm.action = "<c:url value='/dailywork/checkUseMonitoring.do'/>";
		document.frm.submit();			
	}
	
	//상세페이지이동
	function fnGoDetail(dailyWorkId, regId, gubun){
		var varForm				= document.all["goDetailForm"];
   		varForm.action			= "<c:url value='/dailywork/checkUseDetail.do'/>";
		varForm.dailyWorkId.value	= dailyWorkId;
		varForm.regId.value	= regId;
		varForm.gubun.value	= gubun;
		varForm.submit();
	}
	
	function fnAuthDetail(e, regDate, deptCode) {
		fnAuthDetailClose('checkUseDetail');
		
		$.ajax({
			type:"post",
			url:"<c:url value='/dailywork/getCheckUsePopupList.do'/>",
			data:{
					regDate:regDate,
					deptCode:deptCode
				},
			dataType:"json",
			success:function(result){
				var tot = result['authUserList'].length;
				var item = "";
				if(tot>0){
					for(var i=0; i< tot; i++){
						var obj = result['authUserList'][i];
						
						item += "<tr style=\"cursor:pointer\" onclick=\"fnGoDetail('"+obj.CHECK_USE_ID+"','"+obj.REG_ID+"','"+obj.GUBUN+"')\">"
							+"<td style='text-align:center;width:100px;'>"+obj.WORK_DAY+"</td>"
							+"<td style='padding-left:10px;width:170px;'>"+obj.REPORT_NAME+"</td>"
							+"<td style='text-align:center;width:100px;'>"+obj.REG_NAME+"</td>"
							+"<td style='text-align:center;width:80px;'>"+obj.WM_GUBUN+"</td>"
							+"</tr>";
					}
					$("#checkUseList").html(item);
				}else{
					$("#checkUseList").html("<tr><td colspan='4' style='text-align:center;width:450px;'>작성내용이 없습니다.</td></tr>");
				}
			},
	        error:function(result){
					$("#checkUseList").html("<tr><td colspan='4' style='text-align:center;width:450px;'>서버접속 실패</td></tr>");
		        }
		});
		
		 var divTop = e.clientY; //상단 좌표
		 var divLeft = e.clientX - 70; //좌측 좌표

		 var name="checkUseDetail";
			
		var win = $(window);
		var winH = divTop;
		var winW =divLeft;
		$('#'+ name).css('top', winH);
		$('#'+ name).css('left', winW);
		$('#'+ name).show();
		$('#'+ name).focus();
		 
	}
	
	function fnAuthDetailClose() {
		$('#checkUseDetail').hide();
	}
</script>
<style type='text/css'>
	#calendar {
		max-width: 990px;
		margin: 0 auto;
	}
	table th {
		background-color : #FFFFFF;
	}
	td {font-family: "돋움"; font-size: 9pt; color:#595959;}
	th {font-family: "돋움"; font-size: 9pt; color:#000000;}
	select {font-family: "돋움"; font-size: 9pt; color:#595959;}


	.divDotText {
		overflow:hidden;
		text-overflow:ellipsis;
	}

	A:link { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
	A:visited { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
	A:active { font-size:9pt; font-family:"돋움";color:red; text-decoration:none; }
	A:hover { font-size:9pt; font-family:"돋움";color:red;text-decoration:none;}
	.day{
		width:100px; 
		height:30px;
		font-weight: bold;
		font-size:12px;
		font-weight:bold;
		text-align: center;
	}
	.sat{
		color:#529dbc;
	}
	.sun{
		color:red;
	}
	.today_button_div{
		float: right;
	}
	.today_button{
		width: 100px; 
		height:30px;
	}
	.calendar{
		width:100%;
		margin:auto;
	}
	.navigation{
		margin-top:15px;
		margin-bottom:30px;
		text-align: center;
		font-size: 25px;
		vertical-align: middle;
	}
	.calendar_body{
		width:100%;
		background-color: #FFFFFF;
		border:1px solid white;
		margin-bottom: 50px;
		border-collapse: collapse;
	}
	.calendar_body .today{
		border:1px solid white;
		height:120px;
		background-color:#c9c9c9;
		text-align: left;
		vertical-align: top;
	}
	.calendar_body .date{
		font-weight: bold;
		font-size: 12px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .sat_day{
		border:1px solid rgba(212, 232, 243, 1);
		height:120px;
		/* background-color:#EFEFEF; */
		text-align:left;
		vertical-align: top;
	}
	.calendar_body .sat_day .sat{
		color: #529dbc; 
		font-weight: bold;
		font-size: 12px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .sun_day{
		border:1px solid rgba(212, 232, 243, 1);
		height:120px;
		/* background-color:#EFEFEF; */
		text-align: left;
		vertical-align: top;
	}
	.calendar_body .sun_day .sun{
		color: red; 
		font-weight: bold;
		font-size: 12px;
		padding-left: 3px;
		padding-top: 3px;
	}
	.calendar_body .normal_day{
		border:1px solid rgba(212, 232, 243, 1);
		height:120px;
		/* background-color:#EFEFEF; */
		vertical-align: top;
		text-align: left;
	}
	.before_after_month{
		margin: 10px;
		font-weight: bold;
	}
	.before_after_year{
		font-weight: bold;
	}
	.this_month{
		margin: 10px;
	}
	.fc_number{
		opacity:0.3;
	}
</style>
</head>
<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
		
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
				
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
					
					<!--tab Contnet Start-->
					<div class="tab_container">
						<form id="goDetailForm" name="goDetailForm" method="post">
							<input type="hidden" id="dailyWorkId" name="dailyWorkId"/>
							<input type="hidden" id="regId" name="regId"/>
							<input type="hidden" id="gubun" name="gubun"/>
						</form>
						<form name="frm" action ="" method="post">
						<div class="searchBox dataSearch">
							<div class="searchImgDiv">
							<ul>
								<li>
									<span class="fieldName">지역본부</span>
									<select name="searchDeptNo" id="searchDeptNo" class="select">
									<c:if test="${deptNo=='1001'}"><option value="1001"<c:if test="${today_info.searchDeptNo==1001 }"> selected="selected"</c:if>>본부</option></c:if>
									<c:if test="${deptNo=='1001' || deptNo == '1002'}"><option value="1002"<c:if test="${today_info.searchDeptNo==1002 }"> selected="selected"</c:if>>수도권동부</option></c:if>
									<c:if test="${deptNo=='1001' || deptNo == '1004'}"><option value="1004"<c:if test="${today_info.searchDeptNo==1004 }"> selected="selected"</c:if>>대구경북</option></c:if>
									<c:if test="${deptNo=='1001' || deptNo == '1003'}"><option value="1003"<c:if test="${today_info.searchDeptNo==1003 }"> selected="selected"</c:if>>충청권</option></c:if>
									<c:if test="${deptNo=='1001' || deptNo == '1005'}"><option value="1005"<c:if test="${today_info.searchDeptNo==1005 }"> selected="selected"</c:if>>호남권</option></c:if>
									</select>
								</li>
							</ul>
							</div>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:fn_daily_work_list();" alt="조회하기" style="float:right;">
						</div>
						</form>
						<div class="calendar" >

							<!--날짜 네비게이션  -->
							<div class="navigation">
								<a class="before_after_year" href="checkUseMonitoring.do?year=${today_info.search_year-1}&month=${today_info.search_month-1}&searchDeptNo=${today_info.searchDeptNo}">
									&lt;&lt;
								<!-- 이전해 -->
								</a> 
								<a class="before_after_month" href="checkUseMonitoring.do?year=${today_info.before_year}&month=${today_info.before_month}&searchDeptNo=${today_info.searchDeptNo}">
									&lt;
								<!-- 이전달 -->
								</a> 
								<span class="this_month">
									&nbsp;${today_info.search_year}. 
									<c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
								</span>
								<a class="before_after_month" href="checkUseMonitoring.do?year=${today_info.after_year}&month=${today_info.after_month}&searchDeptNo=${today_info.searchDeptNo}">
								<!-- 다음달 -->
									&gt;
								</a> 
								<a class="before_after_year" href="checkUseMonitoring.do?year=${today_info.search_year+1}&month=${today_info.search_month-1}&searchDeptNo=${today_info.searchDeptNo}">
									<!-- 다음해 -->
									&gt;&gt;
								</a>
							</div>
						
						<!-- <div class="today_button_div"> -->
						<!-- <input type="button" class="today_button" onclick="javascript:location.href='/calendar.do'" value="go today"/> -->
						<!-- </div> -->
						<table class="calendar_body">
						
						<thead>
							<tr bgcolor="#CECECE">
								<td class="day sun" >
									일
								</td>
								<td class="day" >
									월
								</td>
								<td class="day" >
									화
								</td>
								<td class="day" >
									수
								</td>
								<td class="day" >
									목
								</td>
								<td class="day" >
									금
								</td>
								<td class="day sat" >
									토
								</td>
								<td class="day" >
									주간
								</td>
								<td class="day" >
									월간
								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<c:forEach var="dateList" items="${dateList}" varStatus="date_status"> 
									<c:choose>
										<c:when test="${dateList.value=='today'}">
											<td class="today">
												<div class="date">
													${dateList.date}
												</div>
												<div>
												<c:if test="${dateList.totWeek>0 || dateList.totMonth>0  }"><image src="/images/common/check.png" onclick='javascript:fnAuthDetail(event, "${dateList.schedule}", "${today_info.searchDeptNo}");' style="cursor: pointer;"/></c:if>
												</div>
											</td>
										</c:when>
										<c:when test="${date_status.index%7==6}">
											<c:if test="${dateList.value!=''}">
											<td class="sat_day">
												<div class="sat">
													${dateList.date}
												</div>
												<div>
												<c:if test="${dateList.totWeek>0 || dateList.totMonth>0  }"><image src="/images/common/check.png" onclick='javascript:fnAuthDetail(event, "${dateList.schedule}", "${today_info.searchDeptNo}");' style="cursor: pointer;"/></c:if>
												</div>
											</td>
											</c:if>
											<c:if test="${dateList.value==''}">
											<td class="normal_day">
												<div class="fc_number">
													${dateList.date}
												</div>
												<div>
												<c:if test="${dateList.totWeek>0 || dateList.totMonth>0  }"><image src="/images/common/check.png" onclick='javascript:fnAuthDetail(event, "${dateList.schedule}", "${today_info.searchDeptNo}");' style="cursor: pointer;"/></c:if>
												</div>
											</td>
											</c:if>
											<td>${dateList.totWeek2}/${totWeekCnt }</td>
											<%-- <td><c:if test="${dateList.date==dateList.lastDay }">${dateList.totMonth2}/${totMonthCnt }</c:if></td> --%>
											<td>${dateList.totMonth2}/${totMonthCnt }</td>
										</c:when>
										<c:when test="${date_status.index%7==0 && dateList.value!=''}">
							</tr>
							<tr>	
								<td class="sun_day">
									<div class="sun">
										${dateList.date}
									</div>
									<div>
									<c:if test="${dateList.totWeek>0 || dateList.totMonth>0  }"><image src="/images/common/check.png" onclick='javascript:fnAuthDetail(event, "${dateList.schedule}", "${today_info.searchDeptNo}");' style="cursor: pointer;"/></c:if>
									</div>
								</td>
										</c:when>
										<c:otherwise>
								<td class="normal_day">
									<c:if test="${dateList.value!=''}">
									<div class="date">
									</c:if>
									<c:if test="${dateList.value==''}">
									<div class="fc_number">
									</c:if>
										${dateList.date}
									</div>
									<div>
									<c:if test="${dateList.totWeek>0 || dateList.totMonth>0  }"><image src="/images/common/check.png" onclick='javascript:fnAuthDetail(event, "${dateList.schedule}", "${today_info.searchDeptNo}");' style="cursor: pointer;"/></c:if>
									</div>
								</td>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</tbody>
						
						</table>
						</div>
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
		
		<!-- 레이어 팝업 -->
		<div id="checkUseDetail" class="divPopup">
			<div id="xbox">
				<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
				<input type="button" id="btnGroInsXbox" name="btnGroInsXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:fnAuthDetailClose('checkUseDetail');" alt="닫기"/>
			</div>
			<table summary="점검일지작성현황"style="text-align:left;">
					<tr>
						<th scope="col">일자</th>
						<th scope="col">일지구분</th>
						<th scope="col">작성자</th>
						<th scope="col">주간/월간</th>
					</tr>
					<tbody id="checkUseList"></tbody>
				</table>
		</div>
	</div>
</body>
</html>