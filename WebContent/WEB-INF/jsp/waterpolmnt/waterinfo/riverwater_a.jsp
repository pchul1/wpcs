<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : riverwater_a.jsp
	 * Description : 수질측정망정보 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 2014.10.27  mypark     검색개선
	 * 2014.11.14  mypark    그리드 걷어내고 테이블 처리
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
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugye');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'A', 'sugye');
		}
		
		//시공사일경우 해당 공구만 선택할 수 있게
		if(memFactCode != null && memFactCode != "") {
			$("#sys > option[value=T]").attr("selected", "true");
			$("#sys").attr("disabled", "disabled");
			
			$("#sugye > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		}
		
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchList();
		});
		
		$("#dataList tr:odd").attr("class","add");
		
	});
	
	function setDate() {
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
	
	var itemCnt;
	var sItemCnt;
	var itemArray , itemCode;
	
	//itemArray 셋팅
	function itemSetting() {
		itemCnt = 41;
		itemArray = new Array(itemCnt);
		itemCode = new Array(itemCnt);
		itemArray[0] = "탁도(NTU)";		itemCode[0] = "TUR00";
		itemArray[1] = "pH";				itemCode[1] = "PHY00";
		itemArray[2] = "DO(mg/L)";		itemCode[2] = "DOW00";
		itemArray[3] = "EC(mS/cm)";	itemCode[3] = "CON00";
		itemArray[4] = "수온(℃)";		itemCode[4] = "TMP00";
		itemArray[5] = "총유기탄소";			itemCode[5] = "TOC00";
		itemArray[6] = "임펄스";			itemCode[6] = "IMP00";
		itemArray[7] = "임펄스(좌)";		itemCode[7] = "LIM00";
		itemArray[8] = "임펄스(우)";		itemCode[8] = "RIM00";
		itemArray[9] = "독성지수(좌)";		itemCode[9] = "LTX00";
		itemArray[10] = "독성지수(우)";	itemCode[10] = "RTX00";
		itemArray[11] = "미생물 독성지수(%)";	itemCode[11] = "TOX00";
		itemArray[12] = "조류 독성지수";		itemCode[12] = "EVN00";
		itemArray[13] = "염화메틸렌";	itemCode[13] = "VOC01";
		itemArray[14] = "1.1.1-트리클로로에테인";	itemCode[14] = "VOC02";
		itemArray[15] = "벤젠";		itemCode[15] = "VOC03";
		itemArray[16] = "사염화탄소";	itemCode[16] = "VOC04";
		itemArray[17] = "트리클로로에틸렌";	itemCode[17] = "VOC05";
		itemArray[18] = "톨루엔";		itemCode[18] = "VOC06";
		itemArray[19] = "테트라클로로에티렌";	itemCode[19] = "VOC07";
		itemArray[20] = "에틸벤젠";	itemCode[20] = "VOC08";
		itemArray[21] = "m,p-자일렌";	itemCode[21] = "VOC09";
		itemArray[22] = "o-자일렌";	itemCode[22] = "VOC10";
		itemArray[23] = "[ECD]염화메틸렌";	itemCode[23] = "VOC11";
		itemArray[24] = "[ECD]1.1.1-트리클로로에테인";	itemCode[24] = "VOC12";
		itemArray[25] = "[ECD]사염화탄소";	itemCode[25] = "VOC13";
		itemArray[26] = "[ECD]트리클로로에틸렌";	itemCode[26] = "VOC14";
		itemArray[27] = "[ECD]테트라클로로에티렌";	itemCode[27] = "VOC15";
		itemArray[28] = "총질소";	itemCode[28] = "TON00";
		itemArray[29] = "총인";	itemCode[29] = "TOP00";
		itemArray[30] = "암모니아성질소";	itemCode[30] = "NH400";
		itemArray[31] = "질산성질소";	itemCode[31] = "NO300";
		itemArray[32] = "인산염인";	itemCode[32] = "PO400";
		itemArray[33] = "클로로필-a";		itemCode[33] = "TOF00";
		itemArray[34] = "카드뮴";	itemCode[34] = "CAD00";
		itemArray[35] = "납";	itemCode[35] = "PLU00";
		itemArray[36] = "구리";	itemCode[36] = "COP00";
		itemArray[37] = "아연";	itemCode[37] = "ZIN00";
		itemArray[38] = "페놀1";	itemCode[38] = "PHE00";
		itemArray[39] = "페놀2";	itemCode[39] = "PHL00";
		itemArray[40] = "강수량";	itemCode[40] = "RIN00";
	}
	
	var colSpan = 6;
	//테이블 헤더 생성
	function makeHeader(bItem) {
		itemSetting();
		var header="";
		var overBox = $("#overBox");
		var colWidthHtml="";
		overBox.html("");
	
		$("#dataTable").attr("class", "dataTable");
		$("#dataTable").css("width", "4000px");
			
		//헤더 생성
		$("#dataHeader").html("");
		 header = "<tr>" + 
						"<th rowspan ='2' scope='col'>NO</th>" +
						"<th rowspan ='2' scope='col'>수계</th>" +
						"<th rowspan ='2' scope='col'>지역</th>" +
						"<th rowspan ='2' scope='col'>측정소</th>" +
						"<th rowspan ='2' scope='col'>수신일자</th>" +
						"<th rowspan ='2' scope='col'>수신시간</th>";
							
						if(bItem == "all" || bItem == "COM1")
							header += "<th colspan ='5' scope='col'>일반항목</th>";
						if(bItem == "all" || bItem == "ORGA")
							header += "<th colspan='1' scope='col' style='height:24px'>유기물질</th>";
						if(bItem == "all" || bItem == "BIO1")
							header += "<th colspan='1' scope='col'>생물독성<br/>(물고기)</th>";
						if(bItem == "all" || bItem == "BIO2")
							header += "<th colspan='2' scope='col'>생물독성<br/>(물벼룩1)</th>";
						if(bItem == "all" || bItem == "BIO3")
							header += "<th colspan='2' scope='col'>생물독성<br/>(물벼룩2)</th>";
						if(bItem == "all" || bItem == "BIO4")
							header += "<th colspan='1' scope='col'>생물독성<br/>(미생물)</th>";
						if(bItem == "all" || bItem == "BIO5")
							header += "<th colspan='1' scope='col'>생물독성<br/>(조류)</th>";
						if(bItem == "all" || bItem == "VOCS")
							header += "<th colspan='15' scope='col'>휘발성<br/>유기화합물</th>";
						if(bItem == "all" || bItem == "NUTR")
							header += "<th colspan='5' scope='col' style='height:24px'>영양염류</th>";
						if(bItem == "all" || bItem == "CHLA")	
							header += "<th colspan='1' scope='col' style='height:24px'>클로로필-a</th>";
						if(bItem == "all" || bItem == "METL")
							header += "<th colspan='4' scope='col' style='height:24px'>중금속</th>";
						if(bItem == "all" || bItem == "PHEN")
							header += "<th colspan='2' scope='col' style='height:24px'>페놀</th>";
						if(bItem == "all" || bItem == "RAIN")
							header += "<th colspan='1' scope='col' style='height:24px'>강수량계</th>";
						
				header += "</tr>" +  "<tr>";
				
				var rowIdx = 0;	//아이템 출력 시작번호
				var len = itemCnt;	//아이템 출력 끝번호
				
				if(bItem == "all") {
					sItemCnt = 41;	//전체일땐 41개 항목 전부 출력
				}
				
				switch(bItem) {
				case "COM1" : //일반항목 (내부)
					rowIdx = 0;
					len = 5;
					sItemCnt = 5;
					$("#dataTable").css("width", "990px");
					break;
				case "ORGA" :
					rowIdx = 5;
					len = 6;
					sItemCnt = 1;
					$("#dataTable").css("width", "990px");
					break;
				case "BIO1" : //생물독성 물고기
					rowIdx = 6;
					len = 7;
					sItemCnt = 1;
					$("#dataTable").css("width", "990px");
					break;
				case "BIO2" : //생물독성 물벼룩1
					rowIdx = 7;
					len = 9;
					sItemCnt = 2;
					$("#dataTable").css("width", "990px");
					break;
				case "BIO3" : //생물독성 물벼룩2;
					rowIdx = 9;
					len = 11;
					sItemCnt = 2;
					$("#dataTable").css("width", "990px");
					break;
				case "BIO4" : //생물독성 미생물
					rowIdx = 11;
					len = 12;
					sItemCnt = 1;
					$("#dataTable").css("width", "990px");
					break;
				case "BIO5" : //생물독성 조류
					rowIdx = 12;
					len = 13;
					sItemCnt = 1;
					$("#dataTable").css("width", "990px");
					break;
				case "VOCS" : //휘발성 유기화합물
					rowIdx = 13;
					len = 28;
					sItemCnt = 15;
					$("#dataTable").css("width", "2100px");
					break;
				case "NUTR" :
					rowIdx = 28;
					len = 33;
					sItemCnt = 5;
					$("#dataTable").css("width", "990px");
					break;	
				case "CHLA" : //클로로필 
					rowIdx = 33;
					len = 34;
					sItemCnt = 1;
					$("#dataTable").css("width", "990px");
					break;
				case "METL" : //중금속
					rowIdx = 34;
					len = 38;
					sItemCnt = 4;
					$("#dataTable").css("width", "990px");
					break;
				case "PHEN" : //페놀
					rowIdx = 38;
					len = 40;
					sItemCnt = 2;
					$("#dataTable").css("width", "990px");
					break;
				case "RAIN" :
					rowIdx = 40;
					len = 41;
					sItemCnt = 1;
					$("#dataTable").css("width", "990px");
					break;
				}
		colSpan = colSpan + sItemCnt; 		
		for(rowIdx;rowIdx<len;rowIdx++) {
			header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
		}
		header += "</tr>";
		
		//구분
		colWidthHtml += "<col width='45' />";
		//기본정보
		colWidthHtml += "<col width='80' />";
		colWidthHtml += "<col width='100' />";
		colWidthHtml += "<col width='110' />";
		colWidthHtml += "<col width='90' />";
		colWidthHtml += "<col width='70' />";
		if (bItem == "all") {
			//일반항목
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			//유기물질
			colWidthHtml += "<col width='80' />";
			//생물독성(물고기)
			colWidthHtml += "<col width='100' />";
			//생물독성(물벼룩1)
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
			//생물독성(물벼룩2)
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
			//생물독성(미생물)
			colWidthHtml += "<col width='110' />";
			//생물독성(조류)	
			colWidthHtml += "<col width='90' />";
			//휘발성유기화합물
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			//영양염류
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='90' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			//클로로필-a
			colWidthHtml += "<col width='80' />";
			//중금속
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			//페놀
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			//강수량계
			colWidthHtml += "<col width='100' />";
		} else if (bItem == "COM1") {	
			//일반항목
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='90' />";
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='90' />";
		} else if (bItem == "BIO1") {
			//생물독성(물고기)
			colWidthHtml += "<col width='100' />";
		} else if (bItem == "BIO2") {
			//생물독성(물벼룩1)
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
		} else if (bItem == "BIO3") {	
			//생물독성(물벼룩2)
			colWidthHtml += "<col width='100' />";	
			colWidthHtml += "<col width='100' />";	
		} else if (bItem == "BIO4") {
			//생물독성(미생물)
			colWidthHtml += "<col width='110' />";
		} else if (bItem == "BIO5") {
			//생물독성(조류)	
			colWidthHtml += "<col width='100' />";
		} else if (bItem == "CHLA") {
			//클로로필-a
			colWidthHtml += "<col width='100' />";
		} else if (bItem == "VOCS") {
			//휘발성유기화합물
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
			colWidthHtml += "<col width='80' />";
		} else if (bItem == "NUTR") {
			//영양염류
			colWidthHtml += "<col width='90' />";
			colWidthHtml += "<col width='90' />";
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
		} else if (bItem == "METL") {
			//중금속
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
		} else if (bItem == "PHEN") {
			//페놀
			colWidthHtml += "<col width='100' />";
			colWidthHtml += "<col width='100' />";
		} else if (bItem == "ORGA") {
			//유기물질
			colWidthHtml += "<col width='100' />";
		} else if (bItem == "RAIN") {
			//강수량계
			colWidthHtml += "<col width='100' />";
		}
		
		$("#colWidth").html("");
		$('#colWidth').append(colWidthHtml);
		$("#dataHeader").html("");
		$("#dataHeader").append(header);
		
		$("#table_over").addClass("table_over");
		$("#data_table").addClass("table_overWidth");
	}
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시됩니다.
	function setGraphBtn() {
		if($('#branchNo').val() == "all") {
			$('#img_chartPopup').attr("onclick", "#");
			$('#img_chartPopup').hide();
		} else {
			$('#img_chartPopup').attr("onclick","javascript:chartPopup()");
			$('#img_chartPopup').fadeIn('fast');
		}
	}
	
	function sysChange() {
		var sys_kind = $("#sys").val();
		
		if(sys_kind == "all") {
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", "disabled");
			$("#factCode").attr("disabled", "disabled");
		} else {
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", false);
			$("#factCode").attr("disabled", false);
		}
	}
	
	function adjustGongku() {		
		var sugyeCd = $('#sugye').val();
		
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		//측정망 전용페이지로 변경 - 2010. 10. 07
		if( sugyeCd == 'all'){// || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
			//dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuListNew.do'/>", {sugye:sugyeCd, system:'A'}, 
			function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_all(data.gongku);
					
					if(memFactCode != null && memFactCode != "") {
						$("#factCode>option[value="+memFactCode+"]").attr("selected", "selected");
						$("#factCode").attr("disabled", "disabled");
					} else {
						$("#factCode>option[value="+data.gongku[0].VALUE+"]").attr("selected", "selected");
					}
					
					adjustBranchListNew();
					
					if(memFactCode == 'all')
						dropDownSet_branchNo.attr("disabled", true);
					
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	//측정소 목록 가져오기
	function adjustBranchList() {
		var factCode = $('#factCode').val();
		var sys_kind = $("#sys").val();
		//console.log("factCode : ",factCode);
		var dropDownSet = $('#branchNo');
		
		if( factCode == 'all' || sys_kind == 'all' ){
			$("#branchNo>option:first").text("전체");
			$("#branchNo>option:first").val("all");
			dropDownSet.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
			$.getJSON(url, {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					//console.log("결과 값 확인 : ",data);
					//console.log("data.branch.length : ",data.branch.length);
					if (data.branch.length != 1) {
						dropDownSet.loadSelect_all(data.branch);
					} else {
						//자료가 1개일 경우 disabled 처리
						dropDownSet.loadSelect(data.branch);
						dropDownSet.attr("disabled", true);
						dropDownSet.attr('style', "background:#e9e9e9;");
					}
					
					if(typeof(adjustItemList) == "function") {
						adjustItemList();
					}
					
					if(!firstFlag) {
						reloadData();
						firstFlag = true;
					}
					
					//$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");
					
					//setGraphBtn();
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
				$("#branchNo").hide();
			});
		}
	}
	
	function adjustBranchListNew() {
		var url = "";
		if(user_roleCode == 'ROLE_ADMIN'){
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		}else{
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchListNew.do'/>";
		}
	
		var factCode = $('#factCode').val();
		var sys_kind = $("#sys").val();
		//console.log("factCode : ",factCode);
		var dropDownSet = $('#branchNo');
		
		if( factCode == 'all' || sys_kind == 'all' ){
			$("#branchNo>option:first").text("전체");
			$("#branchNo>option:first").val("all");
			dropDownSet.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON(url, {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					//console.log("결과 값 확인 : ",data);
					//console.log("data.branch.length : ",data.branch.length);
					if (data.branch.length != 1) {
						dropDownSet.loadSelect_all(data.branch);
					} else {
						//자료가 1개일 경우 disabled 처리
						dropDownSet.loadSelect(data.branch);
						dropDownSet.attr("disabled", true);
						dropDownSet.attr('style', "background:#e9e9e9;");
					}
					
					if(typeof(adjustItemList) == "function") {
						adjustItemList();
					}
					
					if(!firstFlag) {
						reloadData();
						firstFlag = true;
					}
					
					//$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");
					
					//setGraphBtn();
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
				$("#branchNo").hide();
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
		
		//측정망 전용페이지로 변경 - 2010. 10. 07
		//var sys = $("#sys").val();
		sys = 'A';
		var valid = $("#validFlag").val();
		
		var minor = 'all'; //$("#minorCheck").val();
		
		if(valid == null || valid == undefined || valid == "")
			valid = "all";
		//if(minor==null || minor==undefined||minor=="")
		//	minor = "all";
		
		var rType = '2'; //분자료 (측정망은 분자료 밖에 없음)
		
		var bItem = $("#item").val(); //대항목 선택값
		
		var param = "sugye=" + sugye + "&gongku=" + gongku + "&chukjeongso=" + chukjeongso +
		"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime +
		"&sys=" + sys +
		"&minor=" + minor +
		"&valid=" + valid +
		"&dataType=" + rType +
		"&item=" + bItem;
		
		location.href="<c:url value='/waterpolmnt/waterinfo/getExcelDetalViewRIVER.do'/>?"+param;
	}
	
	function chartPopup() {
		if( validation() == false ) return;
	
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		
		//측정망 전용페이지로 변경 - 2010. 10. 07
		var sys = 'A';
		var valid = $("#validFlag").val();
		var minor = 'all';
		
		if(valid == null || valid == undefined || valid == "")
			valid = "all";
			
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 800;
		var winWidth = 1000;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		if(sugye == "01") {
			sugye = "R01"
		} else if(sugye == "02") {
			sugye = "R02"
		} else if(sugye == "03") {
			sugye = "R03"
		} else if(sugye == "04") {
			sugye = "R04"
		}
		
		var bItem = $("#item").val(); //대항목 선택값
		
		var rType = '2'; //분자료 (측정망은 분자료 밖에 없음)
		
		var param = "sugye=" + sugye + "&gongku=" + gongku + "&chukjeongso=" + chukjeongso +
		"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime +
		"&sys=" + sys +
		"&valid=" + valid +
		"&minor=" + minor +
		"&dataType=" + rType + "&width=" + (winWidth-40) + "&height=" + (winHeight-40) +
		"&item=" + bItem;
		
		//stats/getAccidentStatsChart.do
		window.open("<c:url value='/waterpolmnt/waterinfo/goChartDetailRIVER.do'/>?"+encodeURI(param),
				'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	var tmpSys = "";
	var tmpBItem = "";
	
	function reloadData(pageNo){
		if( validation() == false ) return;
		colSpan = 6;
		setGraphBtn();
		showLoading();
		$("#dataList").html("");
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		
		var bItem = $("#item").val();
		
		//측정망 전용페이지로 변경 - 2010. 10. 07
		var sys = 'A'; //$("#sys").val();
		var valid = $("#validFlag").val();
		var minor = 'all';//$("#minorCheck").val();
		
		if(valid == null || valid == undefined || valid == "")
			valid = "all";
		
		if(gongku == null || gongku == "unknowned")
			gongku = "all";
		if(sugye == null || sugye == "unknowned")
			sugye = "all";
		
		makeHeader(bItem);
		var rType = '2'; //분자료 (측정망은 분자료 밖에 없음)
		
		if (pageNo == null) pageNo = 1;
		var dataHtml = "";
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDetailViewRIVER.do'/>",
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
					minor:minor,
					item:bItem,
					pageIndex:pageNo,
					dataType:rType
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='"+ colSpan +"'>조회 결과가 없습니다.</td></tr>";
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
							
						obj.factNumber = factNumber.replace("_", "");
						
						obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
						obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
						obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
						obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
						obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
						obj.toc = (obj.toc != null && obj.toc != '') ? obj.toc : '-';
						
						obj.imp = (obj.imp != null && obj.imp != '') ? obj.imp : '-';
						obj.lim = (obj.lim != null && obj.lim != '') ? obj.lim : '-';
						obj.rim = (obj.rim != null && obj.rim != '') ? obj.rim : '-';
						
						obj.ltx = (obj.ltx != null && obj.ltx != '') ? obj.ltx : '-';
						obj.rtx = (obj.rtx != null && obj.rtx != '') ? obj.rtx : '-';
						
						obj.tox = (obj.tox != null && obj.tox != '') ? obj.tox : '-';
						obj.evn = (obj.evn != null && obj.evn != '') ? obj.evn : '-';
						
						obj.voc1 = (obj.voc1 != null && obj.voc1 != '') ? obj.voc1 : '-';
						obj.voc2 = (obj.voc2 != null && obj.voc2 != '') ? obj.voc2 : '-';
						obj.voc3 = (obj.voc3 != null && obj.voc3 != '') ? obj.voc3 : '-';
						obj.voc4 = (obj.voc4 != null && obj.voc4 != '') ? obj.voc4 : '-';
						obj.voc5 = (obj.voc5 != null && obj.voc5 != '') ? obj.voc5 : '-';
						obj.voc6 = (obj.voc6 != null && obj.voc6 != '') ? obj.voc6 : '-';
						obj.voc7 = (obj.voc7 != null && obj.voc7 != '') ? obj.voc7 : '-';
						obj.voc8 = (obj.voc8 != null && obj.voc8 != '') ? obj.voc8 : '-';
						obj.voc9 = (obj.voc9 != null && obj.voc9 != '') ? obj.voc9 : '-';
						obj.voc10 = (obj.voc10 != null && obj.voc10 != '') ? obj.voc10 : '-';
						obj.voc11 = (obj.voc11 != null && obj.voc11 != '') ? obj.voc11 : '-';
						obj.voc12 = (obj.voc12 != null && obj.voc12 != '') ? obj.voc12 : '-';
						obj.voc13 = (obj.voc13 != null && obj.voc13 != '') ? obj.voc13 : '-';
						obj.voc14 = (obj.voc14 != null && obj.voc14 != '') ? obj.voc14 : '-';
						obj.voc15 = (obj.voc15 != null && obj.voc15 != '') ? obj.voc15 : '-';
						
						obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
						obj.ton = (obj.ton != null && obj.ton != '') ? obj.ton : '-';
						obj.top = (obj.top != null && obj.top != '') ? obj.top : '-';
						obj.nh4 = (obj.nh4 != null && obj.nh4 != '') ? obj.nh4 : '-';
						
						
						obj.no3 = (obj.no3 != null && obj.no3 != '') ? obj.no3 : '-';
						obj.po4 = (obj.po4 != null && obj.po4 != '') ? obj.po4 : '-';
						
						obj.cad = (obj.cad != null && obj.cad != '') ? obj.cad : '-';
						obj.plu = (obj.plu != null && obj.plu != '') ? obj.plu : '-';
						
						obj.cop = (obj.cop != null && obj.cop != '') ? obj.cop : '-';
						obj.zin = (obj.zin != null && obj.zin != '') ? obj.zin : '-';
						obj.phe = (obj.phe != null && obj.phe != '') ? obj.phe : '-';
						obj.phl = (obj.phl != null && obj.phl != '') ? obj.phl : '-';
						
						obj.rin = (obj.rin != null && obj.rin != '') ? obj.rin : '-';

						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.river_name +"</td>";
						dataHtml += "<td>" + obj.factNumber +"</td>";
						dataHtml += "<td>" + obj.branch_name +"</td>";
						dataHtml += "<td>" + obj.strdate +"</td>";
						dataHtml += "<td>" + obj.strtime +"</td>";
						
						if (bItem == "all") {
							dataHtml += "<td>" + obj.tur +"</td>";
							dataHtml += "<td>" + obj.phy +"</td>";
							dataHtml += "<td>" + obj.dow +"</td>";
							dataHtml += "<td>" + obj.con +"</td>";
							dataHtml += "<td>" + obj.tmp +"</td>";
							
							dataHtml += "<td>" + obj.toc +"</td>";
							
							dataHtml += "<td>" + obj.imp +"</td>";
							dataHtml += "<td>" + obj.lim +"</td>";
							dataHtml += "<td>" + obj.rim +"</td>";
							
							dataHtml += "<td>" + obj.ltx +"</td>";
							dataHtml += "<td>" + obj.rtx +"</td>";
							
							dataHtml += "<td>" + obj.tox +"</td>";
							dataHtml += "<td>" + obj.evn +"</td>";
							
							dataHtml += "<td>" + obj.voc1 +"</td>";
							dataHtml += "<td>" + obj.voc2 +"</td>";
							dataHtml += "<td>" + obj.voc3 +"</td>";
							dataHtml += "<td>" + obj.voc4 +"</td>";
							dataHtml += "<td>" + obj.voc5 +"</td>";
							dataHtml += "<td>" + obj.voc6 +"</td>";
							dataHtml += "<td>" + obj.voc7 +"</td>";
							dataHtml += "<td>" + obj.voc8 +"</td>";
							dataHtml += "<td>" + obj.voc9 +"</td>";
							dataHtml += "<td>" + obj.voc10 +"</td>";
							dataHtml += "<td>" + obj.voc11 +"</td>";
							dataHtml += "<td>" + obj.voc12 +"</td>";
							dataHtml += "<td>" + obj.voc13 +"</td>";
							dataHtml += "<td>" + obj.voc14 +"</td>";
							dataHtml += "<td>" + obj.voc15 +"</td>";
							
							dataHtml += "<td>" + obj.ton +"</td>";
							dataHtml += "<td>" + obj.top +"</td>";
							dataHtml += "<td>" + obj.nh4 +"</td>";
							dataHtml += "<td>" + obj.no3 +"</td>";
							dataHtml += "<td>" + obj.po4 +"</td>";
							
							dataHtml += "<td>" + obj.tof +"</td>";
							
							dataHtml += "<td>" + obj.cad +"</td>";
							dataHtml += "<td>" + obj.plu +"</td>";
							dataHtml += "<td>" + obj.cop +"</td>";
							dataHtml += "<td>" + obj.zin +"</td>";
							
							dataHtml += "<td>" + obj.phe +"</td>";
							dataHtml += "<td>" + obj.phl +"</td>";
							
							dataHtml += "<td>" + obj.rin +"</td>";
						} else if (bItem == "COM1") {
							//일반항목
							dataHtml += "<td>" + obj.tur +"</td>";
							dataHtml += "<td>" + obj.phy +"</td>";
							dataHtml += "<td>" + obj.dow +"</td>";
							dataHtml += "<td>" + obj.con +"</td>";
							dataHtml += "<td>" + obj.tmp +"</td>";
						} else if (bItem == "ORGA") {
							//유기물질
							dataHtml += "<td>" + obj.toc +"</td>";
						} else if (bItem == "BIO1") {
							//생물독성(물고기)
							dataHtml += "<td>" + obj.imp +"</td>";
						} else if (bItem == "BIO2") {
							//생물독성(물벼룩1)
							dataHtml += "<td>" + obj.lim +"</td>";
							dataHtml += "<td>" + obj.rim +"</td>";
						} else if (bItem == "BIO3") {
							//생물독성(물벼룩2)
							dataHtml += "<td>" + obj.ltx +"</td>";
							dataHtml += "<td>" + obj.rtx +"</td>";
						} else if (bItem == "BIO4") {
							//생물독성(미생물)
							dataHtml += "<td>" + obj.tox +"</td>";
						} else if (bItem == "BIO5") {
							//생물독성(조류)
							dataHtml += "<td>" + obj.evn +"</td>";
						} else if (bItem == "VOCS") {
							//휘발성유기화합물
							dataHtml += "<td>" + obj.voc1 +"</td>";
							dataHtml += "<td>" + obj.voc2 +"</td>";
							dataHtml += "<td>" + obj.voc3 +"</td>";
							dataHtml += "<td>" + obj.voc4 +"</td>";
							dataHtml += "<td>" + obj.voc5 +"</td>";
							dataHtml += "<td>" + obj.voc6 +"</td>";
							dataHtml += "<td>" + obj.voc7 +"</td>";
							dataHtml += "<td>" + obj.voc8 +"</td>";
							dataHtml += "<td>" + obj.voc9 +"</td>";
							dataHtml += "<td>" + obj.voc10 +"</td>";
							dataHtml += "<td>" + obj.voc11 +"</td>";
							dataHtml += "<td>" + obj.voc12 +"</td>";
							dataHtml += "<td>" + obj.voc13 +"</td>";
							dataHtml += "<td>" + obj.voc14 +"</td>";
							dataHtml += "<td>" + obj.voc15 +"</td>";
						} else if (bItem == "NUTR") {
							//영양염류
							dataHtml += "<td>" + obj.ton +"</td>";
							dataHtml += "<td>" + obj.top +"</td>";
							dataHtml += "<td>" + obj.nh4 +"</td>";
							dataHtml += "<td>" + obj.no3 +"</td>";
							dataHtml += "<td>" + obj.po4 +"</td>";
						} else if (bItem == "CHLA") {
							//클로로필-a
							dataHtml += "<td>" + obj.tof +"</td>";
						} else if (bItem == "METL") {
							//중금속
							dataHtml += "<td>" + obj.cad +"</td>";
							dataHtml += "<td>" + obj.plu +"</td>";
							dataHtml += "<td>" + obj.cop +"</td>";
							dataHtml += "<td>" + obj.zin +"</td>";
						} else if (bItem == "PHEN") {
							//페놀
							dataHtml += "<td>" + obj.phe +"</td>";
							dataHtml += "<td>" + obj.phl +"</td>";
						} else if (bItem == "RAIN") {
							//강수량계
							dataHtml += "<td>" + obj.rin +"</td>";
						}
						dataHtml +="</tr>";
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
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				var dataHtml="<tr colspan='"+ colSpan +"'><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
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
	}
	
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
							<div class="searchBox dataSearch">
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
										<select class="fixWidth11" id="factCode">
											<option value="all">전체</option>
										</select>
									<span style="display:none;">&gt;</span>
									<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled" style="display:none;">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork(this)"/>
									<select id="frTime" name="frTime" onchange="commonWork(this)" style="width:45px">
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
									<select id="toTime" name="toTime" onchange="commonWork(this)" style="width:45px">
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
								<li>
									<span class="fieldName">항목구분</span>
									<select id="item" name="bItem" style="width:126px">
										<option value="all">전체</option>
										<option value="COM1">일반항목</option>
										<option value="BIO1">생물독성(물고기)</option>
										<option value="BIO2">생물독성(물벼룩1)</option>
										<option value="BIO3">생물독성(물벼룩2)</option>
										<option value="BIO4">생물독성(미생물)</option>
										<option value="BIO5">생물독성(조류)</option>
										<option value="CHLA">클로로필-a</option>
										<option value="VOCS">휘발성 유기화합물</option>
										<option value="METL">중금속</option>
										<option value="PHEN">페놀</option>
										<option value="ORGA">유기물질</option>
										<option value="NUTR">영양염류</option>
										<option value="RAIN">강수량계</option>
									</select>
								</li>
									<!-- 
										<dt><label for="">대항목</label></dt>
										<dd>
											<select id="bitem" name="bitem" disabled="true">
												<option value="1">일반항목</option>
											</select>
										</dd>
										<dt>소항목</dt>
										<dd>
											<ul class="checkList">
												<li id="sys0"><input type="checkbox" class="inputCheck" id="i1" checked="checked" /><label for="">탁도</label></li>
												<li id="sys1"><input type="checkbox" class="inputCheck" id="i2" checked="checked"/><label for="">DO</label></li>
												<li id="sys2"><input type="checkbox" class="inputCheck" id="i3" checked="checked"/><label for="">수온</label></li>
												<li id="sys3"><input type="checkbox" class="inputCheck" id="i4" checked="checked"/><label for="">pH</label></li>
												<li id="sys4"><input type="checkbox" class="inputCheck" id="i5" checked="checked"/><label for="">전기전도도</label></li>
											</ul>
										</dd>
										 -->
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="img_chartPopup" name="img_chartPopup" class="btn btn_graph" onclick="javascript:excelDown()" style='display:none'/>
							<input type="button" id="btnBasic" name="btnBasic" class="btn btn_excel" onclick="javascript:excelDown()" />
						</div>
						<div class="table_wrapper">
							<div id="table_over">
								<table id="dataTable" summary="게시판 구분 , 기본정보, 수질정보가 담김">
									<colgroup id="colWidth">
									</colgroup>
									<thead id="dataHeader">
									</thead>
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