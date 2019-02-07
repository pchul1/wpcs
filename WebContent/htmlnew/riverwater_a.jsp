<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : riverwater_a.jsp
	 * Description : 수질자동측정망정보 화면
	 * Modification Information
	 * 
	 *	수정일				 수정자		수정내용
	 * ----------		--------	---------------------------
	 * 2010.05.17		khany		최초 생성
	 * 2013.10.20		lkh			리뉴얼
	 *
	 * author khany
	 * since 2010.05.17
	 *
	 * Copyright (C) 2010 by khany  All right reserved.
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
	
$(function () {
	//user deptNo에 따른 수계 고정
	set_User_deptNo()
	
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
	
	var today = new Date(); 
	var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 12);

	yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
	today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());

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
});

var itemCnt;
var sItemCnt;

	//itemArray 셋팅 //측정망 전용페이지로 변경 - 2010. 10. 07 - sys parameter에 무조건 'T'만 들어옴
	function itemSetting(sys)
	{
		if(sys != "A")
		{
			itemCnt = 5;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도(NTU)";	itemCode[0] = "TUR";
			itemArray[1] = "수온(℃)";	itemCode[1] = "TMP";
			itemArray[2] = "pH";	itemCode[2] = "PHY";
			itemArray[3] = "DO(mg/L)";	itemCode[3] = "DOW";
			itemArray[4] = "EC(mS/cm)";	itemCode[4] = "CON";
		}
		else if(sys=="A")
		{
			itemCnt = 45;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "pH1";			itemCode[0] = "PHY00";
			itemArray[1] = "DO1<br/>(mg/L)";		itemCode[1] = "DOW00";
			itemArray[2] = "EC1<br/>(mS/cm)";	itemCode[2] = "CON00";
			itemArray[3] = "수온1<br/>(℃)";	itemCode[3] = "TMP00";
			
			itemArray[4] = "pH2";			itemCode[4] = "PHY01";
			itemArray[5] = "DO2<br/>(mg/L)";		itemCode[5] = "DOW01";
			itemArray[6] = "EC2<br/>(mS/cm)";	itemCode[6] = "CON01";
			itemArray[7] = "수온2<br/>(℃)";	itemCode[7] = "TMP01";
			itemArray[8] = "탁도<br/>(NTU)";		itemCode[8] = "TUR00";
			
			itemArray[9] = "임펄스<br/>";	itemCode[9] = "IMP00";
			
			itemArray[10] = "임펄스<br/>(좌)";	itemCode[10] = "LIM00";
			itemArray[11] = "임펄스<br/>(우)";	itemCode[11] = "RIM00";
			
			itemArray[12] = "독성지수<br/>(좌)";	itemCode[12] = "LTX00";
			itemArray[13] = "독성지수<br/>(우)";	itemCode[13] = "RTX00";
			
			itemArray[14] = "미생물<br/>독성지수(%)";	itemCode[14] = "TOX00";
			
			itemArray[15] = "조류<br/>독성지수";		itemCode[15] = "EVN00";
			
			itemArray[16] = "클로로필-a";		itemCode[16] = "TOF00";
			
			itemArray[17] = "염화메틸렌";	itemCode[17] = "VOC01";
			itemArray[18] = "1.1.1-트리클로로에테인";	itemCode[18] = "VOC02";
			itemArray[19] = "사염화탄소";		itemCode[19] = "VOC04";
			itemArray[20] = "벤젠";	itemCode[20] = "VOC03";
			itemArray[21] = "트리클로로에틸렌";	itemCode[21] = "VOC05";
			itemArray[22] = "톨루엔";		itemCode[22] = "VOC06";
			itemArray[23] = "테트라클로로에티렌";	itemCode[23] = "VOC07";
			itemArray[24] = "에틸벤젠";	itemCode[24] = "VOC08";
			itemArray[25] = "m,p-자일렌";	itemCode[25] = "VOC09";
			itemArray[26] = "o-자일렌"; itemCode[26] = "VOC10";
			itemArray[27] = "[ECD]염화메틸렌";	itemCode[27] = "VOC11";
			itemArray[28] = "[ECD]1.1.1-트리클로로에테인";	itemCode[28] = "VOC12";
			itemArray[29] = "[ECD]사염화탄소";	itemCode[29] = "VOC13";
			itemArray[30] = "[ECD]트리클로로에틸렌";	itemCode[30] = "VOC14";
			itemArray[31] = "[ECD]테트라클로로에티렌";	itemCode[31] = "VOC15";
			
			itemArray[32] = "카드뮴";	itemCode[32] = "CAD00";
			itemArray[33] = "납";	itemCode[33] = "PLU00";
			itemArray[34] = "구리";	itemCode[34] = "COP00";
			itemArray[35] = "아연";	itemCode[35] = "ZIN00";
			
			itemArray[36] = "페놀1";	itemCode[36] = "PHE00";
			itemArray[37] = "페놀2";	itemCode[37] = "PHL00";
			
			itemArray[38] = "총유기탄소";	itemCode[38] = "TOC00";
			
			itemArray[39] = "총질소";	itemCode[39] = "TON00";
			itemArray[40] = "총인";	itemCode[40] = "TOP00";
			itemArray[41] = "암모니아성질소";	itemCode[41] = "NH400";
			itemArray[42] = "질산성질소";	itemCode[42] = "NO300";
			itemArray[43] = "인산염인";	itemCode[43] = "PO400";
			
			itemArray[44] = "강수량";	itemCode[44] = "RIN00";
		}
	}
	
	//테이블 헤더 생성
	//탁수모니터링 전용페이지로 변경 - 2010. 10. 07 (sys가 'T'로 고정됨)
	function makeHeader(sys, bItem)
	{
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
							"<th colspan ='"+itemCnt+"' scope='col'>수질정보</th>" +
						"</tr>" + 
						"<tr>";
						
						for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
						{
							header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
						}
						
						header += "</tr>";
			
			$("#dataHeader").append(header);
			//$("#dataList").html("<tr><td colspan='"+(itemCnt + 6)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		}
		else if(sys == "A")
		{
			$("#dataTable").attr("class", "");
			$("#dataTable").attr("class", "dataTable_broad");
			
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
								header += "<th colspan ='4' scope='col'>일반항목<br/>(내부)</th>";
							if(bItem == "all" || bItem == "COM2")	
								header += "<th colspan ='5' scope='col'>일반항목<br/>(외부)</th>";
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
							if(bItem == "all" || bItem == "CHLA")	
								header += "<th colspan='1' scope='col' style='height:24px'>클로로필-a</th>";
							if(bItem == "all" || bItem == "VOCS")
								header += "<th colspan='15' scope='col'>휘발성<br/>유기화합물</th>";
							if(bItem == "all" || bItem == "METL")
								header += "<th colspan='4' scope='col' style='height:24px'>중금속</th>";
							if(bItem == "all" || bItem == "PHEN")
								header += "<th colspan='2' scope='col' style='height:24px'>페놀</th>";
							if(bItem == "all" || bItem == "ORGA")
								header += "<th colspan='1' scope='col' style='height:24px'>유기물질</th>";
							if(bItem == "all" || bItem == "NUTR")
								header += "<th colspan='5' scope='col' style='height:24px'>영양염류</th>";
							if(bItem == "all" || bItem == "RAIN")
								header += "<th colspan='1' scope='col' style='height:24px'>강수량계</th>";
								
						header += "</tr>" + 
						"<tr>";
						
						var rowIdx = 0;	//아이템 출력 시작번호
						var len = itemCnt;	//아이템 출력 끝번호
						
						if(bItem == "all")
						{
							sItemCnt = 45;	//전체일땐 45개 항목 전부 출력
						}
						
						switch(bItem)
						{
						case "COM1" : //일반항목 (내부)
							rowIdx = 0;
							len = 4;
							sItemCnt = 4;
							$("#dataTable").css("width", "1008px");
							break;
						case "COM2" : //일반항목 (외부)
							rowIdx = 4;
							len = 9;
							sItemCnt = 5;
							$("#dataTable").css("width", "1008px");
							break;
						case "BIO1" : //생물독성 물고기
							rowIdx = 9;
							len = 10;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;
						case "BIO2" : //생물독성 물벼룩1
							rowIdx = 10;
							len = 12;
							sItemCnt = 2;
							$("#dataTable").css("width", "800px");
							break;
						case "BIO3" : //생물독성 물벼룩 2;
							rowIdx = 12;
							len = 14;
							sItemCnt = 2;
							$("#dataTable").css("width", "800px");
							break;
						case "BIO4" : //생물독성 미생물
							rowIdx = 14;
							len = 15;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;
						case "BIO5" : //생물독성 조류
							rowIdx = 15;
							len = 16;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;
						case "CHLA" : //클로로필 
							rowIdx = 16;
							len = 17;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;
						case "VOCS" : //휘발성 유기화합물
							rowIdx = 17;
							len = 32;
							sItemCnt = 15;
							$("#dataTable").css("width", "2100px");	
							break;
						case "METL" : //중금속
							rowIdx = 32;
							len = 36;
							sItemCnt = 4;
							$("#dataTable").css("width", "1008px");
							break;
						case "PHEN" : //페놀
							rowIdx = 36;
							len = 38;
							sItemCnt = 2;
							$("#dataTable").css("width", "800px");
							break;
						case "ORGA" :
							rowIdx = 38;
							len = 39;
							sItemCnt = 1;
							$("#dataTable").css("width", "700px");
							break;
						case "NUTR" :
							rowIdx = 39;
							len = 44;
							sItemCnt = 5;
							$("#dataTable").css("width", "1008px");
							break;
						case "RAIN" :
							rowIdx = 44;
							len = 45;
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
	
	//user deptNo에 따른 수계 고정
	function set_User_deptNo()
	{
	
		var riverDept = "";
		var isNull = false;
		
		switch(user_dept_no)
		{
		case "1002":
			riverDept = "R01";
			break;
		case "1004":
			riverDept = "R02";
			break;
		case "1003":
			riverDept = "R03";
			break;
		case "1005":
			riverDept = "R04";
			break;
		default :
			//Null이거나 속하지않으면 전체 표시
			isNull = true;	
		}
		
		if(!isNull)
		{
			$("#sugye > option[value="+riverDept+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		}	
		else
		{
			//$("#sugye").attr("disabled", "disabled");
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
					
					sysChange();
					
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
		var winHeight = 546;
		var winWidth = 642;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		if(sugye == "01") {
			sugye = "R01";
		} else if(sugye == "02") {
			sugye = "R02";
		} else if(sugye == "03") {
			sugye = "R03";
		} else if(sugye == "04") {
			sugye = "R04";
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
		
		setGraphBtn();
		showLoading();
		
		if( validation() == false ) return;
		
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
							/*/  {
								 item += "<td class='num'><span id='rem"+i+"'>"+(obj.tur=="" ? "-" : obj.tur) +"</td>"
								 +"<td class='num'><span id='rem"+i+"'>"+(obj.tmp == "" ? "-" : obj.tmp) +"</td>"
								 +"<td class='num'><span id='rem"+i+"'>"+(obj.phy =="" ? "-" : obj.phy) +"</td>"
								 +"<td class='num'><span id='rem"+i+"'>"+(obj.dow == "" ? "-" : obj.dow)+"</td>"
								 +"<td class='num'><span id='rem"+i+"'>"+(obj.con == "" ? "-" : obj.con)+"</td>";
							/*/ //}

							if(bItem == "all" || bItem == "COM1")
							{
								item += "<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
								+"<td class='num'><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
								+"<td class='num'><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>"
								+"<td class='num'><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "COM2")
							{	
								item += "<td class='num'><span id='phy2_"+i+"'>" + ((obj.phy2 == "") ? "-" : obj.phy2)+ "</span></td>"
								+"<td class='num'><span id='dow2_"+i+"'>" + ((obj.dow2 == "") ? "-" : obj.dow2)+ "</span></td>"
								+"<td class='num'><span id='con2_"+i+"'>" + ((obj.con2 == "") ? "-" : obj.con2)+ "</span></td>"
								+"<td class='num'><span id='tmp2_"+i+"'>" + ((obj.tmp2 == "") ? "-" : obj.tmp2)+ "</span></td>"
								+"<td class='num'><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>";
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
							if(bItem == "all" || bItem == "CHLA")	
							{
								item += "<td class='num'><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>";
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
							if(bItem == "all" || bItem == "ORGA")
							{
								item += "<td class='num'><span id='toc"+i+"'>" + ((obj.toc == "") ? "-" : obj.toc)+ "</span></td>";
							}
							if(bItem == "all" || bItem == "NUTR")
							{
								item += "<td class='num'><span id='ton"+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>"
								+"<td class='num'><span id='top"+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>"
								+"<td class='num'><span id='nh4"+i+"'>" + ((obj.nh4 == "") ? "-" : obj.nh4)+ "</span></td>"
								+"<td class='num'><span id='no3"+i+"'>" + ((obj.no3 == "") ? "-" : obj.no3)+ "</span></td>"
								+"<td class='num'><span id='po4"+i+"'>" + ((obj.po4 == "") ? "-" : obj.po4)+ "</span></td>";
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

				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건]");

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
	}

	function commonWork() {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");

		if(endt.value != '' && stdt.value > endt.value) {
			alert("종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
	}

	// 페이지 번호 클릭	
	function linkPage(pageNo){
		reloadData(pageNo);
	} 
//]]>
</script>

</head>
<body>
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
<div id="wrap">
	<div id="header">
		<c:import url="/common/menu/header.do" />
	</div><!-- //header -->
	<div id="container">
		<!-- 사이드 리스트 -->
		<div id="snb" class="snb">
			<c:import url="/common/menu/left.do" />
		</div>
		<!-- //사이드 리스트 -->
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
		
		<!-- content -->
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_waterinfo">
				<div class="inner_riverwater">
					<!-- 하천 수질 조회 -->
					<div class="search_all_wrap">
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
						<dl>
							<!-- //측정망 전용페이지로 변경 - 2010. 10. 07 
							<dt><img src="<c:url value='/images/content/tit_search_system.gif'/>" alt="시스템" /></dt>
							<dd>
								<select class="fixWidth13" id="sys" name="sys">
										<option value="U">이동형측정기기</option>
<!-- 										<option value="T" selected="selected">탁수모니터링</option> -->
										<option value="A">국가수질자동측정망</option>
								</select>
							</dd>
							-->
							<dt><img src="<c:url value='/images/content/tit_search_branch.gif'/>" alt="측정소" /></dt>
							<dd>
								<select class="fixWidth7"  id="sugye">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
								</select>
								<span>&gt;</span>
									<select class="fixWidth11"  id="factCode">
										<option value="all">전체</option>
									</select>
								<span>&gt;</span>
								<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled">
									<option value="all">전체</option>
								</select>
							</dd>
							<dt><img src="<c:url value='/images/content/tit_search_validity.gif'/>" alt="유효성 구분" /></dt>
							<dd id="valid">
								<select id="validFlag" name="valid">
									<option value="all">전체</option>
									<option value="N">일반데이터</option>
									<option value="Y">유효데이터</option>
								</select>
							</dd>
						</dl>
						<div class="btnInBox">
							<dl>
								<dt><img src="<c:url value='/images/content/tit_search_date.gif'/>" alt="조회기간" /></dt>
								<dd class="time">
									<input type="text" class="inputText" id="startDate" name="startDate" onchange="commonWork()" readonly="readonly"/>
									<select id="frTime" name="frTime">
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
									<span>시</span>
									<span>~</span>
									<input type="text" class="inputText" id="endDate" name="endDate" onchange="commonWork()" readonly="readonly"/>
									<select id="toTime" name="toTime">
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
									<span>시</span>
								</dd>
								<!-- //측정망 전용페이지로 변경 - 2010. 10. 07
								<dd id="minor">
									<select id="minorCheck" name="minor">
										<option value="all">전체(기준초과)</option>
										<option value="0">정상</option>
										<option value="1">기준초과</option>
									</select>
								</dd>
																-->
							<dt><img src="<c:url value='/images/content/tit_search_item.gif'/>" alt="항목구분" /></dt>
							<dd id="valid">
								<select id="item" name="bItem" style="width:126px">
									<option value="all">전체</option>
									<option value="COM1">일반항목(내부)</option>
									<option value="COM2">일반항목(외부)</option>
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
							</dd>
							</dl>
							<dl style="display:none">
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
							</dl>
							<p class="btn_search"><a href="javascript:reloadData()"><img src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></a></p>
						</div>
							<!-- //수질 조회 현황 -->
						</form:form>
					</div>
					<!-- //하천 수질 조회 -->
					<ul class="dataBtn">
						<li><a id="a_chartPopup"><img style='display:none' id="img_chartPopup" src="<c:url value='/images/common/btn_graph.gif'/>" alt="그래프" /></a></li>
						<li><a href="javascript:excelDown()"><img src="<c:url value='/images/common/btn_excel.gif'/>" alt="엑셀" /></a></li>
					</ul>
					<span id="p_total_cnt">[총 ${totCnt}건]</span>
					<div class="data_wrap">
						<!--// areaTOver_riverwater_a -->
						<div id="areaTOver_riverwater_a" class="areaTOver">
						<!-- areaTHeader_intercptn -->
						<div id="areaTHeader_intercptn">
							<table id="tableHeader_intercptn" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
							<colgroup>
								<col width="40" />
								<col width="50" />
								<col width="50" />
								<col width="100" />
								<col width="100" />
								<col width="90" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">수계</th>
								<th scope="col">지역</th>
								<th scope="col">측정소</th>
								<th scope="col">수신일자</th>
								<th scope="col">수신시간</th>
							</tr>
							</thead>
							</table>
						</div>
						<!--// areaTHeader_intercptn -->

						<!-- areaTHeader_top -->
						<div id="areaTHeader_top">
							<table id="tableHeader_top" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
							<colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							<colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							<colgroup>
								<col width="90" />
								<col width="90" />
							</colgroup>
							<colgroup>
								<col width="90" />
								<col width="90" />
							<colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
							<colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							<colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							<colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							<colgroup>
								<col width="90" />
								<col width="90" />
							</colgroup>
								<col width="90" />
							</colgroup>
							<colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
								<col width="90" />
							<thead>
							<tr>
								<th scope="colgroup" colspan="4">일반항목<br />내부</th>
								<th scope="colgroup" colspan="5">일반항목<br />외부</th>
								<th scope="colgroup" colspan="2">생물독성<br />(물벼룩1)</th>
								<th scope="colgroup" colspan="2">생물독성<br />(물벼룩2)</th>
								<th scope="col">생물독성<br />(미생물)</th>
								<th scope="col">생물독성<br />(조류)</th>
								<th scope="col">클로로필-a</th>
								<th scope="colgroup" colspan="15">휘발성<br />유기화합물</th>
								<th scope="colgroup" colspan="4">중금속</th>
								<th scope="colgroup" colspan="2">페놀</th>
								<th scope="col">유기물질</th>
								<th scope="colgroup" colspan="5">영양염류</th>
								<th scope="col">강수량계</th>
							</tr>
							<tr>
								<th scope="col">pH1</th>
								<th scope="col">DO1<br />(mg/L)</th>
								<th scope="col">EC1<br />(mS/cm)</th>
								<th scope="col">수온1(℃)</th>	
								<th scope="col">pH2</th>
								<th scope="col">DO2<br />(mg/L)</th>
								<th scope="col">EC2<br />(mS/cm)</th>
								<th scope="col">수온2(C)</th>
								<th scope="col">탁도</th>
								<th scope="col">임펄스<br />(좌)</th>
								<th scope="col">임펄스<br />(우)</th>
								<th scope="col">독성지수<br />(좌)</th>
								<th scope="col">독성지수<br />(우)</th>
								<th scope="col">미생물<br />독성지수(%)</th>
								<th scope="col">조류<br />독성지수(%)</th>
								<th scope="col">클로로필-a</th>
								<th scope="col">염화메틸렌</th>
								<th scope="col">1.1.1-트리클로로에테인</th>
								<th scope="col">사염화탄소</th>
								<th scope="col">벤젠</th>
								<th scope="col">트리클로로에틸렌</th>
								<th scope="col">톨루엔</th>
								<th scope="col">테트라클로로에틸렌</th>
								<th scope="col">에틸벤젠</th>
								<th scope="col">m,p-자일렌</th>
								<th scope="col">o-자일렌</th>
								<th scope="col">[ECD]염화메틸렌</th>
								<th scope="col">[ECD]1.1.1-트리클로로에테인</th>
								<th scope="col">[ECD]사염화탄소</th>
								<th scope="col">[ECD]트리클로로에틸렌</th>
								<th scope="col">[ECD]테트라클로로에틸렌</th>
								<th scope="col">카드뮴</th>
								<th scope="col">납</th>
								<th scope="col">구리</th>
								<th scope="col">아연</th>
								<th scope="col">페놀1</th>
								<th scope="col">페놀2</th>
								<th scope="col">총유기탄소</th>
								<th scope="col">총질소</th>
								<th scope="col">총인</th>
								<th scope="col">암모니아성<br />질소</th>
								<th scope="col">질산성질소</th>
								<th scope="col">인산염인</th>
								<th scope="col">강수량</th>
							</tr>
							</thead>
							</table>
						</div>
						<!--// areaTHeader_top -->
						
						<!-- areaTHeader_left -->
						<div id="areaTHeader_left" style="overflow:hidden;float:left;clear:left;">
							<table id="tableHeader_left" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
							<colgroup>
								<col width="40" />
								<col width="50" />
								<col width="50" />
								<col width="100" />
								<col width="100" />
								<col width="90" />
							</colgroup>
							<tbody>
							<%for(int i = 0 ; i < 20 ; i++) {%>
							<tr class="undefined">
								<td class="num"><span>1</span></td>
								<td><span id="rvr0">한강</span></td><!--기존 id 없었음 -->
								<td><span id="tur0">tur0</span></td>
								<td><span id="dow0">dow0</span></td>
								<td><span id="rem0">rem0</span></td>
								<td><span id="ret0">ret0</span></td><!--기존 id="rem0", 중복아이디어서 rename -->
							</tr>
							<tr class="add">
								<td class="num"><span>1</span></td>
								<td><span id="rvr1">한강</span></td>
								<td><span id="tur1">tur1</span></td>
								<td><span id="dow1">dow1</span></td>
								<td><span id="rem1">rem1</span></td>
								<td><span id="ret1">ret1</span></td>
							</tr>
							<%}%>
							</tbody>
							</table>
						</div>
						<!-- // areaTHeader_left -->

						<!-- areaTData -->
						<div id="areaTData" onscroll="scroll()">
							<table id="tableData" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
							<colgroup>
									<%for(int i = 0 ; i < 44 ; i++) {%>
									<col width="90" />
									<%}%>
							</colgroup>
						<tbody>
							<%for(int i = 0 ; i < 20 ; i++) {%>
							<tr class="undefined">
								<!--bItem == "COM1" -->
								<td class="num"><span id="phy0">phy0</span></td>
								<td class="num"><span id="dow0">dow0</span></td>
								<td class="num"><span id="con0">con0</span></td>
								<td class="num"><span id="tmp0">tmp0</span></td>
								<!--bItem == "COM2" -->
								<td class="num"><span id="phy2_0">phy2_0</span></td>
								<td class="num"><span id="dow2_0">dow2_0</span></td>
								<td class="num"><span id="tmp2_0">tmp2_0</span></td>
								<td class="num"><span id="tur0">tur0</span></td>
								<!--bItem == "BIO1" -->
								<td class="num"><span id="imp0">imp0</span></td>
								<!--bItem == "BIO2" -->
								<td class="num"><span id="lim0">lim0</span></td>
								<td class="num"><span id="rim0">rim0</span></td>
								<!--bItem == "BIO3" -->
								<td class="num"><span id="ltx0">ltx0</span></td>
								<td class="num"><span id="rtx0">rtx0</span></td>
								<!--bItem == "BIO4" -->
								<td class="num"><span id="tox0">tox0</span></td>
								<!--bItem == "BIO5" -->
								<td class="num"><span id="evn0">evn0</span></td>
								<!--bItem == "CHLA" -->
								<td class="num"><span id="tof0">tof0</span></td>
								<!--bItem == "VOCS" -->
								<td class="num"><span id="voc1_0">voc1_0</span></td>
								<td class="num"><span id="voc2_0">voc2_0</span></td>
								<td class="num"><span id="voc3_0">voc3_0</span></td>
								<td class="num"><span id="voc4_0">voc4_0</span></td>
								<td class="num"><span id="voc5_0">voc5_0</span></td>
								<td class="num"><span id="voc6_0">voc6_0</span></td>
								<td class="num"><span id="voc7_0">voc7_0</span></td>
								<td class="num"><span id="voc8_0">voc8_0</span></td>
								<td class="num"><span id="voc9_0">voc9_0</span></td>
								<td class="num"><span id="voc10_0">voc10_0</span></td>
								<td class="num"><span id="voc11_0">voc11_0</span></td>
								<td class="num"><span id="voc12_0">voc12_0</span></td>
								<td class="num"><span id="voc13_0">voc13_0</span></td>
								<td class="num"><span id="voc14_0">voc14_0</span></td>
								<td class="num"><span id="voc15_0">voc15_0</span></td>
								<!--bItem == "METL" -->
								<td class="num"><span id="cad0">cad0</span></td>
								<td class="num"><span id="pul0">pul0</span></td>
								<td class="num"><span id="cop0">cop0</span></td>
								<td class="num"><span id="zin0">zin0</span></td>
								<!--bItem == "PHEN" -->
								<td class="num"><span id="phe0">phe0</span></td>
								<td class="num"><span id="phl0">phl0</span></td>
								<!--bItem == "ORGA" -->
								<td class="num"><span id="toc0">toc0</span></td>
								<!--bItem == "NUTR" -->
								<td class="num"><span id="ton0">ton0</span></td>
								<td class="num"><span id="top0">top0</span></td>
								<td class="num"><span id="nh40">nh40</span></td>
								<td class="num"><span id="no30">no30</span></td>
								<td class="num"><span id="po40">po40</span></td>
								<!--bItem == "RAIN" -->
								<td class="num"><span id="rin0">rin0</span></td>
							</tr>
							<tr class="add">
								<!--bItem == "COM1" -->
								<td class="num"><span id="phy1">phy1</span></td>
								<td class="num"><span id="dow1">dow1</span></td>
								<td class="num"><span id="con1">con1</span></td>
								<td class="num"><span id="tmp1">tmp1</span></td>
								<!--bItem == "COM2" -->
								<td class="num"><span id="phy2_1">phy2_1</span></td>
								<td class="num"><span id="dow2_1">dow2_1</span></td>
								<td class="num"><span id="tmp2_1">tmp2_1</span></td>
								<td class="num"><span id="tur1">tur1</span></td>
								<!--bItem == "BIO1" -->
								<td class="num"><span id="imp1">imp1</span></td>
								<!--bItem == "BIO2" -->
								<td class="num"><span id="lim1">lim1</span></td>
								<td class="num"><span id="rim1">rim1</span></td>
								<!--bItem == "BIO3" -->
								<td class="num"><span id="ltx1">ltx1</span></td>
								<td class="num"><span id="rtx1">rtx1</span></td>
								<!--bItem == "BIO4" -->
								<td class="num"><span id="tox1">tox1</span></td>
								<!--bItem == "BIO5" -->
								<td class="num"><span id="evn1">evn1</span></td>
								<!--bItem == "CHLA" -->
								<td class="num"><span id="tof1">tof1</span></td>
								<!--bItem == "VOCS" -->
								<td class="num"><span id="voc1_1">voc1_1</span></td>
								<td class="num"><span id="voc2_1">voc2_1</span></td>
								<td class="num"><span id="voc3_1">voc3_1</span></td>
								<td class="num"><span id="voc4_1">voc4_1</span></td>
								<td class="num"><span id="voc5_1">voc5_1</span></td>
								<td class="num"><span id="voc6_1">voc6_1</span></td>
								<td class="num"><span id="voc7_1">voc7_1</span></td>
								<td class="num"><span id="voc8_1">voc8_1</span></td>
								<td class="num"><span id="voc9_1">voc9_1</span></td>
								<td class="num"><span id="voc10_1">voc10_1</span></td>
								<td class="num"><span id="voc11_1">voc11_1</span></td>
								<td class="num"><span id="voc12_1">voc12_1</span></td>
								<td class="num"><span id="voc13_1">voc13_1</span></td>
								<td class="num"><span id="voc14_1">voc14_1</span></td>
								<td class="num"><span id="voc15_1">voc15_1</span></td>
								<!--bItem == "METL" -->
								<td class="num"><span id="cad1">cad1</span></td>
								<td class="num"><span id="pul1">pul1</span></td>
								<td class="num"><span id="cop1">cop1</span></td>
								<td class="num"><span id="zin1">zin1</span></td>
								<!--bItem == "PHEN" -->
								<td class="num"><span id="phe1">phe1</span></td>  
								<td class="num"><span id="phl1">phl1</span></td>
								<!--bItem == "ORGA" -->
								<td class="num"><span id="toc1">toc1</span></td>
								<!--bItem == "NUTR" -->
								<td class="num"><span id="ton1">ton1</span></td>
								<td class="num"><span id="top1">top1</span></td> 
								<td class="num"><span id="nh41">nh41</span></td>  
								<td class="num"><span id="no31">no31</span></td>
								<td class="num"><span id="po41">po41</span></td>
								<!--bItem == "RAIN" -->
								<td class="num"><span id="rin1">rin1</span></td>
							</tr>
							<%}%>
							</tr>
							</tbody>
							</table>
						</div>
						<!--// areaTData -->
						
						<script type="text/javascript">
						var areaTHeader_top = document.getElementById("areaTHeader_top");
						var areaTHeader_left = document.getElementById("areaTHeader_left");
						var areaTData = document.getElementById("areaTData");
						function scroll()
						{
							areaTHeader_top.scrollLeft = areaTData.scrollLeft;
							areaTHeader_left.scrollTop = areaTData.scrollTop;
						}	
						</script>
						
						</div>
						<!--// areaTOver_riverwater_a -->
					</div>
					<ul class="paginate" id="pagination">
					</ul>
				</div>
			</div>
		</div><!-- //content -->
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>