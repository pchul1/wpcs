<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : waterPollutionList.jsp
	 * Description : 수질오염접수목록 화면->사고(수동)관리
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.04.30	YIK			최초 생성
	 * 2013.10.31	lkh			리뉴얼
	 * 2014.10.27 mypark      페이징처리
	 * 
	 * author YIK
	 * since 2013.04.30
	 *	
	 * Copyright (C) 2013 by YIK  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<%
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
%>

<script type="text/javascript">
//<![CDATA[
	$(function(){
		//============================= 달 력  Start ======================================
		/*shows the loading div every time we have an Ajax call*/
		var startDate = '<%=startDate%>';
		var endDate = '<%=endDate%>';
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#startDate").datepicker({
			buttonText: '조회일자'
		});
		
		$("#endDate").datepicker({
			buttonText: '조회일자'
		});
		
		var today = new Date(); 
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		var today2 = new Date(); 
		today2 = today2.getFullYear()+"/"+ addzero(today2.getMonth()+1) + "/01" ;
		
		//var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
		//yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		if('${searchCon.sStartDate}' == '' || '${searchCon.sEndDate}' == ''){
			
			//날짜 초기값 Setting	
			if(startDate == 'null'){
				$("#startDate").val(today2);
			}else{
				$("#startDate").val(startDate);
			}
			if(endDate == 'null'){
				$("#endDate").val(today);
			}else{
				$("#endDate").val(endDate);
			}
		}
		//=============================	 달 력  End	======================================
//		$('#btnSearch').click(function () {
//			//dataLoad();
//		});
		
//		$('#btnRegist').click(function () {
//			//fnRegist();
//		});
		
		var fromStats = '';
		var year = '';
		var riverDiv = '';
		var regKind = '';
		var supportKind = '';
		var wpKind = '';
		var statsStartDate = '';
		var statsEndDate = '';
		
		fromStats		= "${param.fromStats}";
		year			= "${param.year}";
		riverDiv		= "${param.riverDiv}";
		regKind			= "${param.regKind}";
		supportKind		= "${param.supportKind}";
		wpKind			= "${param.wpKind}";
		wpsStep			= "${param.wpsStep}";
		statsStartDate	= "${param.statsStartDate}";
		statsEndDate	= "${param.statsEndDate}";
		
		if(fromStats == 'Y'){
			if(year == 'total'){
				$('#startDate').val(statsStartDate);
				$('#endDate').val(statsEndDate);
				$('#searchRiverDiv').val(riverDiv);
				$('#searchWpsStep').val(wpsStep);
				$('#searchWpKind').val(wpKind);
				$('#searchSupportKind').val(supportKind);
			}else{
				$('#startDate').val(year+'/01/01');
				$('#endDate').val(year+'/12/31');
				$('#searchRiverDiv').val(riverDiv);
				$('#searchWpsStep').val(wpsStep);
				$('#searchWpKind').val(wpKind);
				$('#searchSupportKind').val(supportKind);
			}
		}
		
		selectedSugyeInMemberId(user_riverid , 'searchRiverDiv');
		dataLoad();
	});
	
	function dataLoad(pageNo){
		
		var startDate = $("#startDate").val().split('/').join('');
		var endDate = $("#endDate").val().split('/').join('');
		var searchRiverDiv = $("#searchRiverDiv").val();
		var searchRegKind = $("#searchRegKind").val();
		var searchWpKind = $("#searchWpKind").val();
		var searchWpsStep = $("#searchWpsStep").val();
		var searchSupportKind = $("#searchSupportKind").val();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpollution/getWaterPollutionList.do'/>",
			data:{
					startDate:startDate,
					endDate:endDate,
					searchRiverDiv:searchRiverDiv,
					searchRegKind:searchRegKind,
					searchWpKind:searchWpKind,
					searchWpsStep:searchWpsStep,
					searchSupportKind:searchSupportKind,
					pageIndex:pageNo
			},
			dataType:"json",
			success:function(result){
				//console.log("결과 값 확인 : ",result);
				
				var tot = result['list'].length;
				var pageInfo = result['paginationInfo'];
				var html = "";
				
				if( tot <= 0 ){
					html += "<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
				} else {  
					for(var i=0; i< tot; i++) {
						var obj = result['list'][i];
						
						if(obj.riverDiv == 'R01'){
							obj.riverDivName = '한강';
						}else if(obj.riverDiv == 'R02'){
							obj.riverDivName = '낙동강';
						}else if(obj.riverDiv == 'R03'){
							obj.riverDivName = '금강';
						}else if(obj.riverDiv == 'R04'){
							obj.riverDivName = '영산강';
						}
						
						if(obj.wpKind == 'PA'){
							obj.wpKindName = '유류유출';
						}else if(obj.wpKind == 'PB'){
							obj.wpKindName = '물고기폐사';
						}else if(obj.wpKind == 'PC'){
							obj.wpKindName = '화학물질';
						}else if(obj.wpKind == 'PD'){
							obj.wpKindName = '기타';
						}else if(obj.wpKind == 'PT'){
							obj.wpKindName = '테스트';
						}
						
						if(obj.wpsStep == 'STA'){
							obj.wpsStepName = '신고';
						}else if(obj.wpsStep == 'RCV'){
							obj.wpsStepName = '접수';
						}else if(obj.wpsStep == 'ING'){
							obj.wpsStepName = '수습중';
						}else if(obj.wpsStep == 'END'){
							obj.wpsStepName = '조치완료';
						}
						
						if(obj.supportKind == 'Y'){
							obj.supportKindName = '지원';
						}else if(obj.supportKind == 'N'){
							obj.supportKindName = '접수';
						}else{
							obj.supportKindName = '미정';
						}
						
						if(obj.regKind == '1'){
							obj.regKindName = '공단';
						}else if(obj.regKind == '2'){
							obj.regKindName = '환경부';
						}else if(obj.regKind == '3'){
							obj.regKindName = '공단&환경부';
						}
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						trclass = "";
						if(i % 2 == 1) trclass = "class=\"even\"";
						
						html +="<tr "+trclass+">";
						html += "<td><a onclick=\"fnGoDetail('"+obj.wpCode+"','"+obj.wpsStep+"'); return false;\" href=\"#\">"+ obj.no +"</a></td>";
						html += "<td><a onclick=\"fnGoDetail('"+obj.wpCode+"','"+obj.wpsStep+"'); return false;\" href=\"#\">"+ obj.receiveDate +"</a></td>";
						html += "<td><a onclick=\"fnGoDetail('"+obj.wpCode+"','"+obj.wpsStep+"'); return false;\" href=\"#\">"+ obj.riverDivName +"</a></td>";
						html += "<td><a onclick=\"fnGoDetail('"+obj.wpCode+"','"+obj.wpsStep+"'); return false;\" href=\"#\">"+ obj.wpKindName +"</a></td>";
						html += "<td align='left' style='padding-left:5px;'><a onclick=\"fnGoDetail('"+obj.wpCode+"','"+obj.wpsStep+"'); return false;\" href=\"#\">"+ obj.wpContent.replace(/\r\n/gi, "<BR>") +"</a></td>";
						html += "<td><a onclick=\"fnGoDetail('"+obj.wpCode+"','"+obj.wpsStep+"'); return false;\" href=\"#\">"+ obj.wpsStepName +"</a></td>";
						html += "<td><a onclick=\"fnGoDetail('"+obj.wpCode+"','"+obj.wpsStep+"'); return false;\" href=\"#\">"+ obj.supportKindName +"</a></td>";
						html += "<td><a onclick=\"fnGoDetail('"+obj.wpCode+"','"+obj.wpsStep+"'); return false;\" href=\"#\">"+ obj.regKindName +"</a></td>";
						html +="</tr>";
					}
				}
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				// 총건수 표시
				var totCnt = result['totCnt'];
				
				$("#p_total_cnt").html("[총 " + totCnt +"건]");
				
				closeLoading();
				$("#dataList").html(html);
			},
			error:function(result){
				var html = "";
				html += "<tr><td colspan='8'>서버 접속에 실패하였습니다.</td></tr>";
				$("#dataList").html(html);
				closeLoading();
			}
		});
	}
	//페이지 번호 클릭	
	function linkPage(pageNo){
		dataLoad(pageNo);
	}
	
	//등록페이지 이동
	function fnRegist(){
		location.href = "<c:url value='/waterpollution/waterPollutionRegist.do'/>";
	}
	
	//상세페이지이동
	function fnGoDetail(wpCode,wpsStep){
		var varForm				= document.all["goDetailForm"];
		if(wpsStep == "STA"){
			varForm.action			= "<c:url value='/waterpollution/waterPollutionRegist.do'/>";
		}else{
			varForm.action			= "<c:url value='/waterpollution/waterPollutionDetail.do'/>";
		}
		varForm.wpCode.value	   = wpCode;	
		varForm.sRiverDiv.value    = $('#searchRiverDiv').val();
		varForm.sRegKind.value     = $('#searchRegKind').val();
		varForm.sWpKind.value      = $("#searchWpKind").val();
		varForm.sStartDate.value   = $("#startDate").val();
		varForm.sEndDate.value     = $("#endDate").val();
		varForm.sWpsStep.value     = $("#searchWpsStep").val();
		varForm.sSupportKind.value = $("#searchSupportKind").val();

		varForm.submit();
		//location.href = "<c:url value='/waterpollution/waterPollutionDetail.do?wpCode='/>" + wpCode;
	}
	
	//날짜(달력) 처리 함수
	function commonWork() {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, "startDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					stdt.value = "";
					stdt.focus;
					return false;
				}
			}
		}
		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				
				var returnValue = commonWork2(endt.value, "endDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					endt.value = "";
					endt.focus;
					return false;
				}
			}
		}
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
	}
	
	//숫자만 입력했을때 자동완성을 위한 함수
	// 1. 8자리 체크
	// 2. 1000 년이후 체크
	// 3. 월 체크
	// 4. 일 체크
	function commonWork2(dateValue, inputId){
		var returnValue = "";
		var checkNum = "";
		
		for(var i=0 ; i<dateValue.length ; i++){
			var checkCode = dateValue.charCodeAt(i);
			
			//숫자로만 이루어져 있는지 여부 체크.
			if( checkCode >= 48 && checkCode <= 57 ){
				checkNum	= "true";
			}else{
				returnValue = "false";
				checkNum	= "false";
				break;
			}
		}
		
		//숫자로만 이루어져 있다면.
		if(checkNum == "true"){
			if( dateValue.length != 8){ //8자리가 아니면 false;
				returnValue = "false";
			}else{
				
				//년 비교
				if( !(1000 < Number(dateValue.substr(0,4)) && Number(dateValue.substr(0,4)) <= 9999 )){
					returnValue = "false";
				}else{
					var month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
					var monthCheck = 'false';
					
					for(var j=0 ; j < month.length ; j++){
						if(Number(dateValue.substr(4,2)) == month[j]){
							monthCheck = 'true';
							break;
						}
					}
					
					//월 비교 통과했다면.
					if(monthCheck == 'true'){
						var day = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
						var dayCheck = 'false';
						
						for(var k=0 ; k < day.length ; k++){
							if(Number(dateValue.substr(6,2)) == day[k]){
								dayCheck = 'true';
								break;
							}
						}
						
						//일체크를 통과했다면.
						if(dayCheck == 'true'){
							var tempVar = dateValue.substr(0,4) + '/' + dateValue.substr(4,2) + '/' + dateValue.substr(6,2);
							document.getElementById(inputId).value = tempVar;
							returnValue = 'true';
						}else{
							returnValue = "false";
						}
						
					}else{
						returnValue = "false";
					}
				}
			}
		}
		return returnValue;
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility:hidden ; position: absolute;">
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
						<input type="hidden" id="wpCode" name="wpCode"/>
						<input type="hidden" id="sRiverDiv" name="sRiverDiv"/>
						<input type="hidden" id="sRegKind" name="sRegKind"/>
						<input type="hidden" id="sWpKind" name="sWpKind"/>
						<input type="hidden" id="sStartDate" name="sStartDate"/>
						<input type="hidden" id="sEndDate" name="sEndDate"/>
						<input type="hidden" id="sWpsStep" name="sWpsStep"/>
						<input type="hidden" id="sSupportKind" name="sSupportKind"/>
						
					</form>
					
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">수계</span>
									<select id="searchRiverDiv">
										<option value="" ${searchCon.sRiverDiv == '' ? 'selected' : ''}>전체</option>
										<option value="R01" ${searchCon.sRiverDiv == 'R01' ? 'selected' : ''}>한강</option>
										<option value="R02" ${searchCon.sRiverDiv == 'R02' ? 'selected' : ''}>낙동강</option>
										<option value="R03" ${searchCon.sRiverDiv == 'R03' ? 'selected' : ''}>금강</option>
										<option value="R04" ${searchCon.sRiverDiv == 'R04' ? 'selected' : ''}>영산강</option>
									</select>
								</li>
								<li>
									<span class="fieldName">유형</span>
									<select id="searchWpKind">
										<option value="" ${searchCon.sWpKind == '' ? 'selected' : ''}>전체</option>
										<option value="PA" ${searchCon.sWpKind == 'PA' ? 'selected' : ''}>유류유출</option>
										<option value="PB" ${searchCon.sWpKind == 'PB' ? 'selected' : ''}>물고기폐사</option>
										<option value="PC" ${searchCon.sWpKind == 'PC' ? 'selected' : ''}>화학물질</option>
										<option value="PD" ${searchCon.sWpKind == 'PD' ? 'selected' : ''}>기타</option>
									</select>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" id="startDate" name="startDate" size="13" onchange="commonWork()" alt="조회시작일" value="<c:out value='${searchCon.sStartDate}'/>"/>
									<span>~</span>
									<input type="text" id="endDate" name="endDate" size="13" onchange="commonWork()" alt="조회종료일" value="<c:out value='${searchCon.sEndDate}'/>"/>
								</li>
								
								<li>
									<span class="fieldName">단계</span>
									<select id="searchWpsStep">
										<option value="" ${searchCon.sWpsStep == '' ? 'selected' : ''}>전체</option>
										<option value="STA" ${searchCon.sWpsStep == 'STA' ? 'selected' : ''}>신고</option>
										<option value="RCV" ${searchCon.sWpsStep == 'RCV' ? 'selected' : ''}>접수</option>
										<option value="ING" ${searchCon.sWpsStep == 'ING' ? 'selected' : ''}>수습중</option>
										<option value="END" ${searchCon.sWpsStep == 'END' ? 'selected' : ''}>조치완료</option>
									</select>
								</li>
								<li>
									<span class="fieldName">접수/지원</span>
									<select id="searchSupportKind">
										<option value="" ${searchCon.sSupportKind == '' ? 'selected' : ''}>전체</option>
										<option value="Y" ${searchCon.sSupportKind == 'Y' ? 'selected' : ''}>지원</option>
										<option value="N" ${searchCon.sSupportKind == 'N' ? 'selected' : ''}>접수</option>
									</select>
								</li>
								<li>
									<span class="fieldName">비고</span>
									<select id="searchRegKind">
										<option value="" ${searchCon.sRegKind == '' ? 'selected' : ''}>전체</option>
										<option value="1" ${searchCon.sRegKind == '1' ? 'selected' : ''}>공단</option>
										<option value="2" ${searchCon.sRegKind == '2' ? 'selected' : ''}>환경부</option>
										<option value="3" ${searchCon.sRegKind == '2' ? 'selected' : ''}>공단&amp;환경부</option>
									</select>
								</li>
							</ul>
						</div>
						
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:dataLoad();" alt="조회하기" style="float:right;"/>
						</div>
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<span id="menuAuth1">
							<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_basic" onclick="javascript:fnRegist();" alt="등록"/>
							</span>
						</div>
						
						<div class="table_wrapper">
							<table>
								<col width='45' />
								<col width='110' />
								<col width='110' />
								<col width='110' />
								<col width='*' />
								<col width='110' />
								<col width='110' />
								<col width='110' />
								<thead>
									<tr>
										<th scope='col'>No</th>
										<th scope='col'>일시</th>
										<th scope='col'>수계</th>
										<th scope='col'>유형</th>
										<th scope='col'>내용</th>
										<th scope='col'>단계</th>
										<th scope='col'>지원</th>
										<th scope='col'>비고</th>
									</tr>
								</thead>
								<tbody id="dataList">
								</tbody>
							</table>
							<div class="paging">
								<div id="page_number">
									<ul class="paginate" id="pagination"></ul>
								</div>
							</div>
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
	</div>
	<script language="javascript" >
	function menuAuth(auth){
		var iauthC ="";
		var iauthU ="";
		var iauthD ="";
		if(auth == "C"){
			iauthC ="Y";
		}
		if(auth == "U"){
			iauthU ="Y";
		}
		if(auth == "D"){
			iauthD ="Y";
		}
		var menuAuth = ""	;
		$.ajax({	
			type:"post",
			url: "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
			dataType:"json",
			async: false,
			data:{
				userId:$("#userId").val(),
				menuId:$("#naviMenuNo").val(),
				authC:iauthC,
				authU:iauthU,
				authD:iauthD
			},
			success : function(result){
				var tot = 0;
				 tot = result['getUserMenuAuthorCount'];
				 menuAuth = tot;
			}
		});
		return menuAuth;
	}
	if("1" == menuAuth("C")){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	</script>
</body>
</html>