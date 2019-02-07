<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : modelingImageResult.jsp
	 * Description : 모델링 물길정보 조회 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2018.11.12   assist5 	최초 작성
	 * 
	 * author 최회섭
	 * since 2018.
	 * 
	 * Copyright (C) 2010 by waterkorea All right reserved.
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
	//관리자 외에 등록 된 측정소가 없을 경우 메인으로 이동
	if(user_roleCode != 'ROLE_ADMIN'){
		if(user_a_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
//<![CDATA[
	$(document).ready(function(){
	//메시지처리
	<c:if test="${not empty message }">
		alert("${message}");
	</c:if>
	});
	
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	var firstFlag = false;
	
	$(function () {
		//초기 시작값의 현재 시각 선택
		setDate();
		
		//user 측정소권한에 따른 수계 고정
		/* if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugye');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'A', 'sugye');
		} */
		
		//시공사일경우 해당 공구만 선택할 수 있게
		/* if(memFactCode != null && memFactCode != "") {
			$("#sys > option[value=T]").attr("selected", "true");
			$("#sys").attr("disabled", "disabled");
			
			$("#sugye > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		} */
		
		/* $('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchList();
		}); */
		
		$("#dataList tr:odd").attr("class","add");
		
	});
	
	function setDate() {
		var date = new Date();
		/* var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		$("#toTime option[value="+time+"]").attr("selected", "true"); */
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
		/* $("#endDate").datepicker({
			buttonText: '종료일'
		}); */
		var todayObj = new Date();
		var yday = new Date();		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		var today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());		
		/* var time = todayObj.getHours();
		var timeStr = addzero(time-2);
		if(time <= 0)
			timeStr = "00";
		$("#frTime > option[value=" + timeStr + "]").attr("selected", "selected"); */
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}		
		$("#startDate").val(yday);
		//$("#endDate").val(today);
	}
	
	function reloadData(pageNo){
		if( validation() == false ) return;
		//setGraphBtn();
		showLoading();
		$("#dataList").html("");
		//var factCode = $("#factCode").val();
		var frDate = $("#startDate").val2();
		//var toDate = $("#endDate").val2();
		var itemCode = $("#itemCode").val();
		var dataHtml = "";
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/modelingImageResultList.do'/>",
			data:{
					imageDate:frDate,
					itemCode:itemCode
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='2'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var itemCode = obj.itemCode;
						if(itemCode=='TMP00') itemCode = '수온';
						if(itemCode=='DOW00') itemCode = 'DO';
						if(itemCode=='BOD00') itemCode = 'CBOD';
						if(itemCode=='NH400') itemCode = 'NH<sub>4</sub>';
						if(itemCode=='NO300') itemCode = 'NO<sub>3</sub>';
						if(itemCode=='PO400') itemCode = 'PO<sub>4</sub>';
						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.imageDateFrom + " ~ " + obj.imageDateTo + "<br/><br/>" + itemCode + "</td>";
						dataHtml += "<td><video width='640px' src='/cmmn/getVideo.do?atchFileId=" + obj.atchFileId +"&fileSn=0' preload controls/></td>";
						dataHtml +="</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				
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
				var dataHtml="<tr><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				closeLoading();
			}
		});
	}
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 일자를 선택하세요"); return false; }
		//if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		//if(!timeCheck()) {return false;}
	}
	
	/* function timeCheck() {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		
		if(stdt.value == endt.value) {
			var frTime = $("#frTime").val();
			var toTime = $("#toTime").val();
			
			if(frTime > toTime) {
				alert("조회 종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
				$("#frTime").val("");
				$("#toTime").val("");
				$("#frTime").focus();
				return false;
			}
		}
		return true;
	} */
	
	function commonWork(n) {
		var stdt = document.getElementById("startDate");
		//var endt = document.getElementById("endDate");
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
		/* if(endt.value !=''){
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
		} */
		
		var date = new Date(stdt.value).getTime();
		var overdate =  new Date(date + (60*60*24*31)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());
		
		/* if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		} */
		
		/* if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		} */
		
		//timeCheck();
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
					
					<!-- 하천 수질 조회 -->
					<form:form commandName="searchTaksuVO" name="listFrm" id="listFrm" method="post">
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>
						<input type="hidden" name="frDate" id="frDate"/>
						<input type="hidden" name="toDate" id="toDate"/>
							<div class="searchBox dataSearch">
							<ul>
								<!-- <li>
									<span class="fieldName">조회지점</span>
									<select class="fixWidth7" name="factCode" id="factCode">
											<option value="">전체</option>
											<option value="2011801">칠곡보</option>
											<option value="2011802">강정고령보</option>
											<option value="2017801">창령·함안보</option>
									</select>
								</li> -->
								<li>
									<span class="fieldName">조회일자</span>
									<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork(this)"/>
									<!-- <span>~</span>
									<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork(this)"/> -->
								</li>
								<li>
									<span class="fieldName">항목</span>
									<select class="fixWidth7" name="itemCode" id="itemCode">
											<option value="">전체</option>
											<option value="TMP00">수온</option>
											<option value="DOW00">DO</option>
											<option value="BOD00">CBOD</option>
											<option value="NH400">NH<sub>4</sub></option>
											<option value="NO300">NO<sub>3</sub></option>
											<option value="PO400">PO<sub>4</sub></option>
									</select>
								</li>
								<!-- <li>
									<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" _onclick="javascript:reloadData();" alt="조회하기">
								</li> -->
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<%-- <div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<!-- <input type="button" id="img_chartPopup" name="img_chartPopup" class="btn btn_graph" onclick="javascript:excelDown()" style='display:none'/> -->
							<!-- <input type="button" id="btnBasic" name="btnBasic" class="btn btn_excel" onclick="javascript:excelDown()" /> -->
						</div> --%>
						<div class="table_wrapper">
							<div id="table_over">
								<table id="dataTable" summary="게시판 구분 , 기본정보, 수질정보가 담김">
									<colgroup id="colWidth">
										<col />
									</colgroup>
									<tbody id="dataList">
									</tbody>
								</table>
							</div>
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