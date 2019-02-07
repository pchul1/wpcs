<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : boManageList.jsp
	 * Description : 보 운영정보
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.17	YIK			최초 생성
	 * 2013.10.20	lkh			 리뉴얼
	 * 2014.11.17  mypark    그리드 걷어내고 테이블 처리
	 * 
	 * author YIK
	 * since 2013.05.17
	 * 
	 * Copyright (C) 2010 by YIK All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<%
	String startDate = request.getParameter("startDate");
	String endDate	 = request.getParameter("endDate");
%>
<script type="text/javascript">
//<![CDATA[
	$(function(){		
		setDate();

		selectedSugyeInMemberId(user_riverid , 'sugye');
		
		$('#sugye').change(function(){
			setBoObsCd();
		});
		
		setBoObsCd();
		
		$('#search').click(function () {
			dataLoad();
		});
		
	});
	
	var firstFlag = false;
	
	function setDate() {
		var startDate = '<%=startDate%>';
		var endDate	= '<%=endDate%>';
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
		
		//날짜 초기값 Setting	
		if(startDate == 'null'){
			$("#startDate").val(today);
		}
		if(endDate == 'null'){
			$("#endDate").val(today);
		}
	}
	
	function dataLoad(pageNo){
		if (pageNo == null) pageNo = 1;
		
		showLoading();
		
		var startDate	= $("#startDate").val().split('/').join('');
		var endDate		= $("#endDate").val().split('/').join('');
		var sugye		= $("#sugye").val();
		var searchObsCd = $("#searchObsCd").val();
		var dataType	= $("#dataType").val();
		var frTime		= $("#frTime").val();
		var toTime		= $("#toTime").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getBoManageList.do'/>",
			data:{
					startDate:startDate,
					endDate:endDate,
					sugye:sugye,
					searchObsCd:searchObsCd,
					dataType:dataType,
					frTime:frTime,
					toTime:toTime,
					pageIndex:pageNo
			},
			dataType:"json",
			success:function(result){
				//console.log("결과 값 확인 : ",result);
				var tot = result['list'].length;
				var pageInfo = result['paginationInfo'];
				var dataHtml="";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='10'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i< tot; i++){
						var obj = result['list'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;

						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.recvDay +"</td>";
						dataHtml += "<td>" + obj.recvTime +"</td>";
						dataHtml += "<td>" + obj.obsNm +"</td>";
						dataHtml += "<td>" + obj.swl +"</td>";
						dataHtml += "<td>" + obj.owl +"</td>";
						dataHtml += "<td>" + obj.sfw +"</td>";
						dataHtml += "<td>" + obj.ecpc +"</td>";
						dataHtml += "<td>" + obj.inf +"</td>";
						dataHtml += "<td>" + obj.otf +"</td>";
						dataHtml += "</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				// 총건수 표시
				$("#p_total_cnt").empty();
				$("#p_total_cnt").append("[총 "+result['paginationInfo'].totalRecordCount+"건] <span class='red'> ※조회결과는 확정자료가 아닙니다.</span>");
				
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				
				closeLoading();
			}
		});
	}
	
	//페이지 번호 클릭	
	function linkPage(pageNo){
		dataLoad(pageNo);
	}
	
	//날짜(달력) 처리 함수
	function commonWork(n) {
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
		
		var date = new Date(stdt.value).getTime();
		var overdate =  new Date(date + (60*60*24*31)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}
		
		if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}
		
		timeCheck();
	}
	
	function timeCheck()
	{
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		
		if(stdt.value == endt.value)
		{
			var frTime = $("#frTime").val();
			var toTime = $("#toTime").val();
			
			if(frTime > toTime)
			{
				alert("조회 종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
				$("#frTime").val("");
				$("#toTime").val("");
				$("#frTime").focus();
				
				return false;
			}
		}
		return true;
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
	
	function setBoObsCd(){
		var sugyeCd = $('#sugye').val();
		var dropDownSet = $('#searchObsCd');
		var temp = "";
		$("#searchObsCd").html("");
		temp = "<option value=''>전체</option>"
		$("#searchObsCd").append(temp);
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getBoObsCdList.do'/>",
			data:{
				sugye:sugyeCd
			},
			dataType:"json",
			success:function(result){
				var tot = result['obsCd'].length;
				var item = "";
				
				if( tot <= "0" ){
					//$("#dataList").html("<tr><td colspan='10'>조회 결과가 없습니다</td></td>");
					closeLoading();
				}else{
					for(var i=0; i< tot; i++){
						var obj = result['obsCd'][i];
						
						item = "<option value='"+obj.VALUE + "'>"+ obj.CAPTION + "</option>";
						
						$("#searchObsCd").append(item);
					}
					
					$("#searchObsCd>option[value='"+ result['obsCd'][0].VALUE +"']").attr("selected", "selected");
					
					if(!firstFlag){
						dataLoad();
						firstFlag = true;
					}
				}
			},
			error:function(result){}
		});
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
					
					<!-- 방류수 수질 조회 -->
					<form:form commandName="searchTaksuVO" name="listFrm"  id="listFrm" method="post">
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>
						<input type="hidden" name="chukjeongso" id="chukjeongso"/>
						<input type="hidden" name="gongku" id="gongku"/>
						<input type="hidden" name="sugye"  id="river_div"/>
						<input type="hidden" name="frDate" id="frDate"/>
						<input type="hidden" name="toDate" id="toDate"/>
						<input type="hidden" name="item01" id="item01"/>
						<input type="hidden" name="item02" id="item02"/>
						<input type="hidden" name="item03" id="item03"/>
						<input type="hidden" name="item04" id="item04"/>
						<input type="hidden" name="item05" id="item05"/>
						
						<div class="searchBox">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select class="fixWidth7" id="sugye">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span>&gt;</span>
									<select class="fixWidth11" id="searchObsCd">
										<option value="">전체</option>
									</select>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork(this)"/>
									<select id="frTime" name="frTime" onchange="commonWork(this)">
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
									</select>
									<span>~</span>
									<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork(this)"/>
									<select id="toTime" name="toTime" onchange="commonWork(this)">
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23" selected="selected">23</option>
									</select>
								</li>
								<!-- <li>
									<span>기준치구분</span>
									<select id="minorCheck" name="minor">
										<option value="all">전체</option>
										<option value="0">정상</option>
										<option value="1">기준초과</option>
									</select>
								</li> -->
								<li>
									<span class="fieldName">수집주기</span>
									<select id="dataType" name="dataType">
										<option id="rDataType" value="2">분자료</option>
										<option id="rDataType" value="1">시간자료</option>
									</select>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:dataLoad();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea"><span id="p_total_cnt">[총 ${totCnt}건]</span></div>
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 수신일, 수신시간, 보이름, 보상위수량, 보하위수량, 저수량 , 공용량, 유입량, 방류량이 담김">
								<colgroup>
									<col width="45" />
									<col width="120" />
									<col width="100" />
									<col width="110" />
									<col width="120" />
									<col width="120" />
									<col width="90" />
									<col width="90" />
									<col width="90" />
									<col width="105" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">수신일</th>
										<th scope="col">수신시간</th>
										<th scope="col">보이름</th>
										<th scope="col">보상위수량(mm)</th>
										<th scope="col">보하위수량(mm)</th>
										<th scope="col">저수량(mm)</th>
										<th scope="col">공용량(mm)</th>
										<th scope="col">유입량(mm)</th>
										<th scope="col">방류량(mm)</th>
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
</body>
</html>