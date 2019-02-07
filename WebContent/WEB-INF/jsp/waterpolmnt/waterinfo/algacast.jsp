<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name : algacast.jsp
	* Description : 조류측정조회 화면
	* Modification Information
	* 
	* 수정일			수정자			수정내용
	* -------		--------	---------------------------
	* 2010.05.17	khany		최초 생성
	* 2013.10.20	lkh			리뉴얼
	* 2014.11.13  mypark    그리드 걷어내고 테이블 처리
	* 
	* author khany
	* since 2010.05.17
	* 
	* Copyright (C) 2010 by khany All right reserved.
	*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript">
//<![CDATA[
	var search_date_start = "${param.searchStart}";
	var search_date_end = "${param.searchEnd}";
	var river_div = "${param.river_div}";
	var pageIdx = "${param.pageIndex}";
	
	$(function () {
		setDate();
		selectedSugyeInMemberId(user_riverid , 'river_div');
		$("#river_div > option[value="+river_div+"]").attr("selected", "selected");
		if(pageIdx != null && pageIdx != undefined && pageIdx != '')
			dataLoad(pageIdx);
		else
			dataLoad();
	});
	
	function setDate(){
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		$("#search_date_start").datepicker({
			buttonText: '측정일자'
			
		});
		$("#search_date_end").datepicker({
			buttonText: '분석일자'
		});
		
		var today = new Date(); 
		var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
		
		//yday = yday.getFullYear()-3  +"/"+ addzero(yday.getMonth()+1) +"/"+ addzero(yday.getDate());
		yday = '2010/08/01';
		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		if(search_date_start != null && search_date_start != "")
			$("#search_date_start").val(search_date_start);
		else
			$("#search_date_start").val(yday);
		
		if(search_date_end != null && search_date_end != "")
			$("#search_date_end").val(search_date_end);
		else
			$("#search_date_end").val(today);
	}
	
	//데이터 불러오기
	function dataLoad(pageNo){
		if(validation() == false) return;
		showLoading(); 
		
		var sugye = $("#river_div").val();
		var start = $("#search_date_start").val();
		var end = $("#search_date_end").val();

		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getAlgaCastList.do'/>",
			data: {
						river_div:sugye,
						search_date_start:start,
						search_date_end:end,
						pageIndex:pageNo
					},
			dataType:"json",
			success : function(result){
				//console.log("결과 값 확인 : ",result);
				var tot = result['dataList'].length;
				var pageInfo = result['paginationInfo'];
				var dataHtml = "";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
				} else {
					for(var i=0; i < tot; i++){
						var obj = result['dataList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						obj.page_no = pageNo;
						obj.chla = (obj.chla != null && obj.chla != '') ? obj.chla : '-';
						obj.cyan = (obj.cyan != null && obj.cyan != '') ? obj.cyan : '-';
						obj.temp = (obj.temp != null && obj.temp != '') ? obj.temp : '-';
						obj.ph = (obj.ph != null && obj.ph != '') ? obj.ph : '-';
						var even = "";
						if(i%2 == 1){even = "even"}
						dataHtml +="<tr class='"+even+"' style='cursor:pointer;' onClick='goView(\"" + obj.cast_num + "\" ,\"" + obj.page_no + "\")'>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.analysis_time +"</td>";
						dataHtml += "<td>" + obj.river_div +"</td>";
						dataHtml += "<td>" + obj.survey_point +"</td>";
						dataHtml += "<td>" + obj.chla +"</td>";
						dataHtml += "<td>" + obj.cyan +"</td>";
						dataHtml += "<td>" + obj.temp +"</td>";
						dataHtml += "<td>" + obj.ph +"</td>";
						dataHtml += "</tr>";
					}
				}
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건] <span class='red'>※조회결과는 확정자료가 아닙니다.</span>");
				
				closeLoading();
			},
			error:function(result){
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				//var dataHtml="<tr ><td colspan='8'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				var dataHtml="<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				
				closeLoading();
			}
		});
	}
	
	function getSurveyPoint(value) {
		var result;
		switch(value) {
			case "R01" :
				result = "한강";
				break;
			case "R02" :
				result = "낙동강";
				break;
			case "R03" :
				result = "금강";
				break;
			case "R04" :
				result = "영산강";
				break;
			default :
				result = value;
		}
		return result;
	}
	
	function goView(castNum, pageIndex) {
		var river_div = $("#river_div").val();
		var searchStart = $("#search_date_start").val2();
		var searchEnd = $("#search_date_end").val2();
		var param = "pageIndex=" + pageIndex + "&cast_num=" + castNum + "&river_div=" + river_div + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;
		window.location = "<c:url value='/waterpolmnt/waterinfo/goAlgaCastView.do'/>?" + param;
	}
	
	function linkPage(pageNo){
		dataLoad(pageNo);
	}
	
	function validation(){
		if( $('#search_date_start').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#search_date_end').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
	}
	
	function commonWork() {
		var stdt = document.getElementById("search_date_start");
		var endt = document.getElementById("search_date_end");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, "search_date_start");
				
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
				
				var returnValue = commonWork2(endt.value, "search_date_end");
				
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
				if( !(999 < Number(dateValue.substr(0,4)) && Number(dateValue.substr(0,4)) <= 9999 )){
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
					
						<!-- 조류 예보 조회 -->
						<form:form commandName="algaCastDataVO" name="listFrm"  id="listFrm" method="post" cssClass="formBox">
						<input type="hidden" name="pageIndex" id="pageIndex" value="${algaCastDataVO.pageIndex}"/>
						<input type="hidden" name="survey_point" id="sugye"/>
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">수계</span>
									<select class="fixWidth10" id="river_div" name="river_div">
										<option value="all">전체</option>
										<option value="R01">한강</option>
										<option value="R03">금강</option>
										<option value="R02">낙동강</option>
										<option value="R04">영산강</option>
									</select>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" size="13" id="search_date_start" name="startDate" onchange="commonWork()"/>
									<span>~</span>
									<input type="text" size="13" id="search_date_end" name="search_date_end" onchange="commonWork()"/>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:dataLoad();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //조류 예보 조회 -->
						
						<!-- 조류 예보 조회 현황 -->
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
						</div>
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 분석일자, 수계, 측정지점, chl-a(mg/m2), 남조류(cells/ml), 수온, pH가 담김">
								<colgroup>
									<col width="45" />
									<col width="140" />
									<col width="140" />
									<col width="130" />
									<col width="130" />
									<col width="130" />
									<col width="130" />
									<col width="145" />
									<col />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">분석일자</th>
										<th scope="col">수계</th>
										<th scope="col">측정지점</th>
										<th scope="col">chl-a(mg/m2)</th>
										<th scope="col">남조류(cells/ml)</th>
										<th scope="col">수온</th>
										<th scope="col">pH</th>
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
						<!-- //조류 예보 조회 현황 -->
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
</body>
</html>