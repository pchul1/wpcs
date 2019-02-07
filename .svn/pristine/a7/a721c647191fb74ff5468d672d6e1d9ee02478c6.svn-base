<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name : alertList.jsp
	* Description : 수질측정망정보 화면
	* Modification Information
	* 
	* 수정일				수정자			수정내용
	* ----------		--------	---------------------------
	* 2010.05.17		khany		최초 생성
	* 2013.10.20		lkh			리뉴얼
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
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	
	$(function () {
		//초기 시작값의 현재 시각 선택
		var date = new Date();
		var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		$("#toTime option[value="+time+"]").attr("selected", "true");
		
// 		set_User_deptNo(user_dept_no, "sugye");
	
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

		//시공사일경우 해당 공구만 선택할 수 있게
		if(memFactCode != null && memFactCode != "")
		{
			$("#sys > option[value=T]").attr("selected", "true");
			$("#sys").attr("disabled", "disabled");
			
			$("#sugye > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		}

		adjustGongku();
	
		//측정망 전용페이지로 변경 - 2010. 10. 07
		//$('#sys').change(function(){
		//	adjustGongku();
		//});
		
		$('#sugye')
		.change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchList();
		});
	
		$('#branchNo').change(function(){
			//setGraphBtn();
		});
	
		$("#dataList tr:odd").attr("class","add");
	
		reloadData();
	
	
		//측정망 전용페이지로 변경 - 2010. 10. 07
		itemSetting('A');
		makeHeader('A', "all");
		
		selectedSugyeInMemberId(user_riverid , 'sugye');
	});
	
	var itemCnt;
	var sItemCnt;

	//itemArray 셋팅 //측정망 전용페이지로 변경 - 2010. 10. 07 - sys parameter에 무조건 'T'만 들어옴
	function itemSetting(sys){
		if(sys != "A")
		{
			itemCnt = 5;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도(NTU)";	itemCode[0] = "TUR";
			itemArray[1] = "수온(℃)";		itemCode[1] = "TMP";
			itemArray[2] = "pH";		itemCode[2] = "PHY";
			itemArray[3] = "DO(mg/L)";	itemCode[3] = "DOW";
			itemArray[4] = "EC(mS/cm)";	itemCode[4] = "CON";
		}
		else if(sys=="A")
		{
			itemCnt = 41;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도<br/>(NTU)";		itemCode[0] = "TUR00";
			itemArray[1] = "pH";				itemCode[1] = "PHY00";
			itemArray[2] = "DO<br/>(mg/L)";		itemCode[2] = "DOW00";
			itemArray[3] = "EC<br/>(mS/cm)";	itemCode[3] = "CON00";
			itemArray[4] = "수온<br/>(℃)";		itemCode[4] = "TMP00";
			itemArray[5] = "총유기탄소";			itemCode[5] = "TOC00";
			itemArray[6] = "임펄스<br/>";			itemCode[6] = "IMP00";
			itemArray[7] = "임펄스<br/>(좌)";		itemCode[7] = "LIM00";
			itemArray[8] = "임펄스<br/>(우)";		itemCode[8] = "RIM00";
			itemArray[9] = "독성지수<br/>(좌)";		itemCode[9] = "LTX00";
			itemArray[10] = "독성지수<br/>(우)";	itemCode[10] = "RTX00";
			itemArray[11] = "미생물<br/>독성지수(%)";	itemCode[11] = "TOX00";
			itemArray[12] = "조류<br/>독성지수";		itemCode[12] = "EVN00";
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
	}
	
	//테이블 헤더 생성
	//탁수모니터링 전용페이지로 변경 - 2010. 10. 07 (sys가 'T'로 고정됨)
	function makeHeader(sys, bItem){
		var header;

		var overBox = $("#overBox");

		overBox.html("");

		var table = "<table id='dataTable' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>"
					+"<colgroup>"
					+ "<col width='40px'></col>"
					+ "<col width='60px'></col>"
					+ "<col width='60px'></col>"
					+"</colgroup>"
					+ "<thead id='dataHeader'>" 
					+ "</thead>"
					+ "<tbody id='dataList'>"
					+ "</tbody>"
					+ "</table>";
					 
		overBox.html(table);
	
		if(sys != "A")
		{
			$("#dataTable").attr("class", "");
			$("#dataTable").attr("class", "dataTable");
			
			
			//헤더 생성
			$("#dataHeader").html("");
			header = "<tr>" + 
							"<th rowspan ='2' scope='col'>NO</th>" +
							"<th rowspan ='2' scope='col'>수계</th>" +
							"<th rowspan ='2' scope='col'>지역</th>" +
							"<th rowspan ='2' scope='col'>측정소</th>" +
							"<th rowspan ='2' scope='col'>수신일자</th>" +
							"<th rowspan ='2' scope='col'>수신시간</th>" +
							"<th colspan ='" + itemCnt + "' scope='col'>수질정보</th>" +
						"</tr>" + 
						"<tr>"
						
						for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
						{
							header += "<th scope='col'>" + itemArray[rowIdx] + "</th>";
						}
						
						header += "</tr>";
						
			$("#dataHeader").append(header);
			//$("#dataList").html("<tr><td colspan='"+(itemCnt + 6)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		}
		else if(sys == "A")
		{
			$("#dataTable").attr("class", "dataTable");
			$("#dataTable").css("width", "5200px");
			
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
								
						header += "</tr>" + 
						"<tr>"
						
						var rowIdx = 0;	//아이템 출력 시작번호
						var len = itemCnt;	//아이템 출력 끝번호
						
						if(bItem == "all")
						{
							sItemCnt = 41;	//전체일땐 41개 항목 전부 출력
						}
						
						switch(bItem)
						{
						case "COM1" : //일반항목 (내부)
							rowIdx = 0;
							len = 5;
							sItemCnt = 5;
							$("#dataTable").css("width", "1008px");
							break;
						case "ORGA" :
							rowIdx = 5;
							len = 6;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;	
						//case "COM2" : //일반항목 (외부)
						//	rowIdx = 4;
						//	len = 9;
						//	sItemCnt = 5;
						//	$("#dataTable").css("width", "1008px");
						//	break;
						case "BIO1" : //생물독성 물고기
							rowIdx = 6;
							len = 7;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;
						case "BIO2" : //생물독성 물벼룩1
							rowIdx = 7;
							len = 9;
							sItemCnt = 2;
							$("#dataTable").css("width", "800px");
							break;
						case "BIO3" : //생물독성 물벼룩 2;
							rowIdx = 9;
							len = 11;
							sItemCnt = 2;
							$("#dataTable").css("width", "800px");
							break;
						case "BIO4" : //생물독성 미생물
							rowIdx = 11;
							len = 12;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;
						case "BIO5" : //생물독성 조류
							rowIdx = 12;
							len = 13;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
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
							$("#dataTable").css("width", "1008px");
							break;	
						case "CHLA" : //클로로필 
							rowIdx = 33;
							len = 34;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;
						case "METL" : //중금속
							rowIdx = 34;
							len = 38;
							sItemCnt = 4;
							$("#dataTable").css("width", "1008px");
							break;
						case "PHEN" : //페놀
							rowIdx = 38;
							len = 40;
							sItemCnt = 2;
							$("#dataTable").css("width", "800px");
							break;
						case "RAIN" :
							rowIdx = 40;
							len = 41;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;
						}
						
						for(rowIdx;rowIdx<len;rowIdx++)
						{
							header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
						}
						
						header += "</tr>";
						
			$("#dataHeader").append(header);
			//$("#dataList").html("<tr><td colspan='"+(itemCnt + 6)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		}
	}
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시됩니다.
	function setGraphBtn()
	{
		 if($('#branchNo').val() == "all")
			{
				$('#a_chartPopup').attr("href", "#");
				$('#img_chartPopup').hide();
			}
			else
			{
				$('#a_chartPopup').attr("href","javascript:chartPopup()");
				$('#img_chartPopup').fadeIn('fast');
			}
	}
	
	function sysChange()
	{
		var sys_kind = $("#sys").val();

		if(sys_kind == "all")
		{
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", "disabled");
			$("#factCode").attr("disabled", "disabled");
		}
		else
		{
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", false);
			$("#factCode").attr("disabled", false);
		}

		//측정망 전용페이지로 변경 - 2010. 10. 07
		//f(sys_kind == 'A')
		//{
		//	$("#valid").show();
		//	$("#minor").hide();
		//}
		//else
		//{
		//	$("#valid").hide();
		//	$("#minor").show();
		//}

		//setGraphBtn();
	}

	function adjustGongku()
	{
		//var sugyeCd = $('#sugye').val();
		//var sys_kind = $("#sys").val();
		
		var sugyeCd = $('#sugye').val();

		//측정망 전용페이지로 변경 - 2010. 10. 07
		//var sys_kind = $("#sys").val();
		
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
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
					{sugye:sugyeCd, system:'A'}, 
					function (data, status){
				 if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
				
					dropDownSet.loadSelect_all(data.gongku);
					
					//sysChange();

					if(memFactCode != null && memFactCode != "")
					{
						$("#factCode>option[value="+memFactCode+"]").attr("selected", "selected");
						$("#factCode").attr("disabled", "disabled");
					}

					adjustBranchList();
					
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
	function adjustBranchList()
	{	
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
	
					//$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");

					//setGraphBtn();
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
		
		setGraphBtn();
		showLoading();

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
		//if(minor==null || minor==undefined||minor=="")
		//	minor = "all";
		
		
		if(gongku == null || gongku == "unknowned")
			gongku = "all";
		if(sugye == null || sugye == "unknowned")
			sugye = "all";

		//측정망 전용페이지로 변경 - 2010. 10. 07
		//if(tmpSys != sys)
		//{
		//	itemSetting(sys);
		if(tmpBItem != bItem)
		{
			makeHeader('A', bItem);
			tmpBItem = bItem;
		}
		//}

		var rType = '2'; //분자료 (측정망은 분자료 밖에 없음)
		
		if (pageNo == null) pageNo = 1;

		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDetailViewRIVER.do'/>",
			data:{sugye:sugye, 
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
				var tot = result['detailViewList'].length;
				var item;
				var trClass;
				
				$("#dataList").html("");

				if( tot <= "0" ){
					$("#dataList").html("<tr><td colspan='"+ (6 + sItemCnt) +"'>조회 결과가 없습니다</td></td>");
					 closeLoading();
				}else{
					for(var i=0; i < tot; i++){
						
						var obj = result['detailViewList'][i];
						var pageInfo = result['paginationInfo'];


						var factNumber = "";
						
						if(sugye == 'R01')
							factNumber = obj.factname.replace('한강', '');
						else if(sugye == 'R02')
							factNumber = obj.factname.replace('낙동강', '');
						else if(sugye == 'R03')
							factNumber = obj.factname.replace('금강', '');
						else if(sugye == 'R04')
							factNumber = obj.factname.replace('영산강','');

						factNumber.replace("_", "");
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						item = "<tr class='"+trClass+"'><td class='num'><span>" + no + "</span></td>"
							+"<td>"+obj.river_name+"</td>" 
							+"<td id='tur"+i+"'>"+factNumber+"</td>"
							+"<td id='dow"+i+"'>"+obj.branch_name+"</td>"
							+"<td id='rem"+i+"'>"+obj.strdate+"</td>"
							+"<td id='rem"+i+"'>"+obj.strtime+"</td>";

							//측정망 전용페이지로 변경 - 2010. 10. 07
							//if(sys != "A")
							/*/ {
								item += "<td class='num'><span id='rem"+i+"'>"+(obj.tur=="" ? "-" : obj.tur) +"</td>"
								+"<td class='num'><span id='rem"+i+"'>"+(obj.tmp == "" ? "-" : obj.tmp) +"</td>"
								+"<td class='num'><span id='rem"+i+"'>"+(obj.phy =="" ? "-" : obj.phy) +"</td>"
								+"<td class='num'><span id='rem"+i+"'>"+(obj.dow == "" ? "-" : obj.dow)+"</td>"
								+"<td class='num'><span id='rem"+i+"'>"+(obj.con == "" ? "-" : obj.con)+"</td>";
							/*/ //}

							if(bItem == "all" || bItem == "COM1")
							{
								item += "<td class='num'><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
								+"<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
								+"<td class='num'><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
								+"<td class='num'><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>"
								+"<td class='num'><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>";
							}
							//if(bItem == "all" || bItem == "COM2")
							//{
							//	item += "<td class='num'><span id='phy2_"+i+"'>" + ((obj.phy2 == "") ? "-" : obj.phy2)+ "</span></td>"
							//	+"<td class='num'><span id='dow2_"+i+"'>" + ((obj.dow2 == "") ? "-" : obj.dow2)+ "</span></td>"
							//	+"<td class='num'><span id='con2_"+i+"'>" + ((obj.con2 == "") ? "-" : obj.con2)+ "</span></td>"
							//	+"<td class='num'><span id='tmp2_"+i+"'>" + ((obj.tmp2 == "") ? "-" : obj.tmp2)+ "</span></td>"
							//	
							//}		
							if(bItem == "all" || bItem == "ORGA")
							{
								item += "<td class='num'><span id='toc"+i+"'>" + ((obj.toc == "") ? "-" : obj.toc)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "BIO1")
							{
								item += "<td class='num'><span id='imp"+i+"'>" + ((obj.imp == "") ? "-" : obj.imp)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "BIO2")
							{
								item += "<td class='num'><span id='lim"+i+"'>" + ((obj.lim == "") ? "-" : obj.lim)+ "</span></td>"
								+"<td class='num'><span id='rim"+i+"'>" + ((obj.rim == "") ? "-" : obj.rim)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "BIO3")
							{
								item += "<td class='num'><span id='ltx"+i+"'>" + ((obj.ltx == "") ? "-" : obj.ltx)+ "</span></td>"
								+"<td class='num'><span id='rtx"+i+"'>" + ((obj.rtx == "") ? "-" : obj.rtx)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "BIO4")
							{
								item += "<td class='num'><span id='tox"+i+"'>" + ((obj.tox == "") ? "-" : obj.tox)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "BIO5")
							{
								item += "<td class='num'><span id='evn"+i+"'>" + ((obj.evn == "") ? "-" : obj.evn)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "VOCS")
							{
								item += "<td class='num'><span id='voc1_"+i+"'>" + ((obj.voc1 == "") ? "-" : obj.voc1)+ "</span></td>"
								+"<td class='num'><span id='voc2_"+i+"'>" + ((obj.voc2 == "") ? "-" : obj.voc2)+ "</span></td>"
								+"<td class='num'><span id='voc3_"+i+"'>" + ((obj.voc3 == "") ? "-" : obj.voc3)+ "</span></td>"
								+"<td class='num'><span id='voc4_"+i+"'>" + ((obj.voc4 == "") ? "-" : obj.voc4)+ "</span></td>"
								+"<td class='num'><span id='voc5_"+i+"'>" + ((obj.voc5 == "") ? "-" : obj.voc5)+ "</span></td>"
								+"<td class='num'><span id='voc6_"+i+"'>" + ((obj.voc6 == "") ? "-" : obj.voc6)+ "</span></td>"
								+"<td class='num'><span id='voc7_"+i+"'>" + ((obj.voc7 == "") ? "-" : obj.voc7)+ "</span></td>"
								+"<td class='num'><span id='voc8_"+i+"'>" + ((obj.voc8 == "") ? "-" : obj.voc8)+ "</span></td>"
								+"<td class='num'><span id='voc9_"+i+"'>" + ((obj.voc9 == "") ? "-" : obj.voc9)+ "</span></td>"
								+"<td class='num'><span id='voc10_"+i+"'>" + ((obj.voc10 == "") ? "-" : obj.voc10)+ "</span></td>"
								+"<td class='num'><span id='voc11_"+i+"'>" + ((obj.voc11 == "") ? "-" : obj.voc11)+ "</span></td>"
								+"<td class='num'><span id='voc12_"+i+"'>" + ((obj.voc12 == "") ? "-" : obj.voc12)+ "</span></td>"
								+"<td class='num'><span id='voc13_"+i+"'>" + ((obj.voc13 == "") ? "-" : obj.voc13)+ "</span></td>"
								+"<td class='num'><span id='voc14_"+i+"'>" + ((obj.voc14 == "") ? "-" : obj.voc14)+ "</span></td>"
								+"<td class='num'><span id='voc15_"+i+"'>" + ((obj.voc15 == "") ? "-" : obj.voc15)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "CHLA")	
							{
								item += "<td class='num'><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "NUTR")
							{
								item += "<td class='num'><span id='ton"+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>"
								+"<td class='num'><span id='top"+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>"
								+"<td class='num'><span id='nh4"+i+"'>" + ((obj.nh4 == "") ? "-" : obj.nh4)+ "</span></td>"
								+"<td class='num'><span id='no3"+i+"'>" + ((obj.no3 == "") ? "-" : obj.no3)+ "</span></td>"
								+"<td class='num'><span id='po4"+i+"'>" + ((obj.po4 == "") ? "-" : obj.po4)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "METL")
							{
								item += "<td class='num'><span id='cad"+i+"'>" + ((obj.cad == "") ? "-" : obj.cad)+ "</span></td>"
								+"<td class='num'><span id='plu"+i+"'>" + ((obj.plu == "") ? "-" : obj.plu)+ "</span></td>"
								+"<td class='num'><span id='cop"+i+"'>" + ((obj.cop == "") ? "-" : obj.cop)+ "</span></td>"
								+"<td class='num'><span id='zin"+i+"'>" + ((obj.zin == "") ? "-" : obj.zin)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "PHEN")
							{
								item += "<td class='num'><span id='phe"+i+"'>" + ((obj.phe == "") ? "-" : obj.phe)+ "</span></td>"
								+"<td class='num'><span id='phl"+i+"'>" + ((obj.phl == "") ? "-" : obj.phl)+ "</span></td>";
							}
							
							
							if(bItem == "all" || bItem == "RAIN")
							{
								item += "<td class='num'><span id='rin"+i+"'>" + ((obj.rin == "") ? "-" : obj.rin)+ "</span></td>";
							}
								
						item += "</tr>";
							
						$("#dataList").append(item);

						$("#dataList tr:odd").attr("class","add");
					}
				}

				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);

				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건] <span class='red'>※조회결과는 확정자료가 아닙니다.</span>");

				//측정망 전용페이지로 변경 - 2010. 10. 07
				//tmpSys = sys;

				closeLoading();
			},
			error:function(result){
				$("#dataList").html("");
				$("#dataList").html("<tr><td colspan='11'>서버 접속에 실패하였습니다!</td></td>");
				closeLoading();
			}
		});
		
		//setTimeout(reloadData, 60000);
	}	

	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		if(!timeCheck()) {return false;}
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
							<div class="searchBox">
							<ul>
								<li>
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
									<span>&gt;</span>
									<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
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
									<span>유효성구분</span>
									<select id="validFlag" name="valid">
										<option value="all" selected="selected">전체데이터</option>
										<option value="Y">유효데이터</option>
									</select>
								</li>
								<li>
									<span>항목구분</span>
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
								<li class="last">
									<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:reloadData();"/>
								</li>
							</ul>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="img_chartPopup" name="img_chartPopup" value="그래프" class="btn btn_basic" onclick="javascript:excelDown()" style='display:none'/>
							<input type="button" id="btnBasic" name="btnBasic" value="엑셀" class="btn btn_basic" onclick="javascript:excelDown()" />
						</div>
						<div class="table_wrapper">
						
							<div id="overBox" style="overflow-x:auto;">
								<table id="dataTable" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false" summary="수질조회현황" >
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