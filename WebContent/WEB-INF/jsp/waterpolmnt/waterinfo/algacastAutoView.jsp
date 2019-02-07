<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name : algacastAutoView.jsp
	* Description : 조류정보 화면
	* Modification Information
	* 
	* 수정일			수정자			수정내용
	* ----------	--------	---------------------------
	* 2013.11.30	lkh			최초 생성
	* 2014.10.29	mypark		검색 개선
	* 2014.11.14  mypark    그리드 걷어내고 테이블 처리
	* 
	* author lkh
	* since 2013.11.30
	* 
	* Copyright (C) 2013 by lkh All right reserved.
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
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	var firstFlag = false;
	$(function () {
		setDate();
		
		//user deptNo에 따른 수계 고정
		set_User_deptNo(user_dept_no, "sugye");
		selectedSugyeInMemberId(user_riverid , 'sugye');
	
		//시공사일경우 해당 공구만 선택할 수 있게
		if(memFactCode != null && memFactCode != "") {
			$("#sys > option[value=T]").attr("selected", "true");
			$("#sys").attr("disabled", "disabled");
			
			$("#sugye > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		}
		
		adjustGongku();
		
		$('#sys').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchList();
		});
		
	});
	
	function setDate(){
		//초기 시작값의 현재 시각 선택
		var date = new Date();
		var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		$("#toTime option[value="+time+"]").attr("selected", "true");
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
			buttonText: '시작일'
			
		});
		$("#endDate").datepicker({
			buttonText: '종료일'
		});
		
		var todayObj = new Date(); 
		var yday = new Date();
		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		var today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());
		
		var time = todayObj.getHours();
		
		var timeStr = addzero(time-2);
		if(time <= 0)
			timeStr = "00";
		
		$("#frTime > option[value=" + timeStr + "]").attr("selected", "selected");
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		$("#startDate").val(yday);
		$("#endDate").val(today);
	}
	
	function sysChange(){
		var sys_kind = $("#sys").val();
		
		$("#branchNo>option:first").attr("selected", "true");
		$("#factCode>option:first").attr("selected", "true");
		
		$("#branchNo").attr("disabled", false);
		if(sys_kind != "U") $("#factCode").attr("disabled", false);
		
		if(sys_kind == "U")
			$("#spanBranch").show();
		else
			$("#spanBranch").hide();
	}
	
	function adjustGongku() {
		var sugyeCd = $('#sugye').val();
		var sys_kind = $("#sys").val();
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		if( sugyeCd == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			dropDownSet.attr("style", "background:#ffffff;");
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
					{sugye:sugyeCd, system:sys_kind}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					if (sys_kind == "U"){
						dropDownSet.attr("disabled", true);
						dropDownSet.attr("style", "background:#e9e9e9;");
					}
					sysChange();
					adjustBranchList();
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
				if(sys_kind == "U") {
					$("#spanFact").hide();
					$("#factCode").hide();
					$("#spanBranch").show();
					$("#branchNo").show();
				} else {
					$("#spanFact").show();
					$("#factCode").show();
					$("#spanBranch").hide();
					$("#branchNo").hide();
				}
			});
		}
	}
	
	//측정소 목록 가져오기
	function adjustBranchList() {	
		var factCode = $('#factCode').val();
		var sys_kind = $("#sys").val();
		
		var dropDownSet = $('#branchNo');
		if( factCode == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
			$.getJSON(url, {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_all(data.branch);
					$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");
					if(typeof(adjustItemList) == "function") {
						adjustItemList();
					}
					if(!firstFlag) {
						reloadData();
						firstFlag = true;
					}
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	function excelDown() {
		if( validation() == false ) return;
		var sugye = $("#sugye").val();
		//var gongku = $("#gongku").val();
		var gongku = $("#factCode").val();
		//var chukjeongso = $("#chukjeongso").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		
		var sys = $("#sys").val();
		var valid = $("#validFlag").val();
		
		var minor = 'all'; //$("#minorCheck").val();
		
		if(valid == null || valid == undefined || valid == "")
			valid = "all";
		
		var rType = '2'; //분자료 (측정망은 분자료 밖에 없음)
		
		var param = "sugye=" + sugye + "&gongku=" + gongku + "&chukjeongso=" + chukjeongso +
			"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
			"&sys=" + sys + 
			"&minor=" + minor +
			"&valid=" + valid +
			"&dataType=" + rType;
			
		location.href="<c:url value='/waterpolmnt/waterinfo/getExcelAlgacastAuto.do'/>?"+param;
	}
	
	function reloadData(pageNo){
		if( validation() == false ) return;
		
		showLoading();
		
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var sys = $("#sys").val();
		var valid = $("#validFlag").val();
		var minor = "all";//$("#minorCheck").val();
		
		if(valid == null || valid == undefined || valid == "")
			valid = "all";
		
		if(gongku == null || gongku == "unknowned")
			gongku = "all";
		if(sugye == null || sugye == "unknowned")
			sugye = "all";
		
		var rType = '2'; //분자료 (측정망은 분자료 밖에 없음)
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getAlgacastAutoList.do'/>",
			data:{
					sugye:sugye, 
					gongku:gongku,
					chukjeongso:chukjeongso,
					frDate:frDate,
					toDate:toDate,
					frTime:frTime,
					toTime:toTime,
					sys:sys,
					valid:valid,
					pageIndex:pageNo,
					dataType:rType
			},
			dataType:"json",
			success:function(result){
// 				console.log("getAlgacastAutoList : ",result);
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
				$("#searchResult").hide(); 
				var sugye = $("#sugye").val();
				var dataHtml = "";
				
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						var factNumber = "";
						if(sugye == 'R01')
							factNumber = obj.factname.replace('한강', '');
						else if(sugye == 'R02')
							factNumber = obj.factname.replace('낙동강', '');
						else if(sugye == 'R03')
							factNumber = obj.factname.replace('금강', '');
						else if(sugye == 'R04')
							factNumber = obj.factname.replace('영산강','');
						
						obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
						obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
						obj.factNumber = factNumber.replace("_", "");
						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.river_name +"</td>";
						dataHtml += "<td>" + obj.factNumber +"</td>";
						dataHtml += "<td>" + obj.branch_name +"</td>";
						dataHtml += "<td>" + obj.strdate +"</td>";
						dataHtml += "<td>" + obj.strtime +"</td>";
						dataHtml += "<td>" + obj.tmp +"</td>";
						dataHtml += "<td>" + obj.tof +"</td>";
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
				var dataHtml="<tr colspan='8'><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				
				closeLoading();
			}
		});
	}
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		if(!timeCheck()) {return false;}
	}
	
	function timeCheck() {
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
		
		timeCheck();
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
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
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
					<!-- 조류측정정보 조회 -->
					<form:form commandName="searchTaksuVO" name="listFrm"  id="listFrm" method="post">
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>
						<input type="hidden" name="chukjeongso" id="chukjeongso"/>
						<input type="hidden" name="gongku" id="gongku"/>
						<input type="hidden" name="sugye" id="river_div"/>
						<input type="hidden" name="frDate" id="frDate"/>
						<input type="hidden" name="toDate" id="toDate"/>
						<input type="hidden" name="item01" id="item01"/>
						<input type="hidden" name="item02" id="item02"/>
						<input type="hidden" name="item03" id="item03"/>
						<input type="hidden" name="item04" id="item04"/>
						<input type="hidden" name="item05" id="item05"/>
						
							<!-- //측정망 전용페이지로 변경 - 2010. 10. 07 
							<dt><img src="<c:url value='/images/content/tit_search_system.gif'/>" alt="시스템" /></dt>
							<dd>
								<select class="fixWidth13" id="sys" name="sys">
										<option value="U">이동형측정기기</option>
										<option value="T" selected="selected">탁수모니터링</option>
										<option value="A">국가수질자동측정망</option>
								</select>
							</dd>
							-->
							<div class="searchBox dataSearch">
							<ul>
								<li>
<!-- 									//측정망 전용페이지로 변경 - 2010. 10. 07  -->
									<span class="fieldName">시스템</span>
									<select class="fixWidth13" id="sys" name="sys">
										<option value="U" selected="selected">이동형측정기기</option>
<!--											<option value="T">탁수모니터링</option> -->
										<option value="A">국가수질자동측정망</option>
									</select>
								</li>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select class="fixWidth7" id="sugye">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span style="display:none" id="spanFact">&gt;</span>
									<select class="fixWidth11" id="factCode" disabled="disabled">
										<option value="all">전체</option>
									</select>
									<span id="spanBranch" style="display:none">
										<span>&gt;</span>
										<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled">
											<option value="all">전체</option>
										</select>
									</span>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork()"/>
									<select id="frTime" name="frTime" onchange="commonWork()" style="width:45px">
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
									<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork()"/>
									<select id="toTime" name="toTime" onchange="commonWork()" style="width:45px">
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
									<!-- <label>&nbsp;최근 <input type="checkbox" name="lately" id="lately" checked="checked"/></label>	확인할것 -->
								</li>
								<!-- //측정망 전용페이지로 변경 - 2010. 10. 07
									<select id="minorCheck" name="minor">
										<option value="all">전체(기준초과)</option>
										<option value="0">정상</option>
										<option value="1">기준초과</option>
									</select>
								-->
								<li>
									<span class="fieldName">유효성구분</span>
									<select id="validFlag" name="valid">
										<option value="all" selected="selected">전체데이터</option>
										<option value="Y">유효데이터</option>
									</select>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData(1);" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="btnBasic" name="btnBasic" class="btn btn_excel" onclick="javascript:excelDown()" />
						</div>
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 수계, 지역, 측정소, 수신일자, 수신시간, 수온 (℃), 클로로필-a가 담김">
								<colgroup>
									<col width="45" />
									<col width="140" />
									<col width="130" />
									<col width="140" />
									<col width="130" />
									<col width="130" />
									<col width="130" />
									<col width="145" />
									<col />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">수계</th>
										<th scope="col">지역</th>
										<th scope="col">측정소</th>
										<th scope="col">수신일자</th>
										<th scope="col">수신시간</th>
										<th scope="col">수온 (℃)</th>
										<th scope="col">클로로필-a</th>
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