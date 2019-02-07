<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : statsRiverOutlet.jsp
	 * Description : 수질유량관계 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		 수정내용
	 * ----------	--------	---------------------------
	 * 2013.10.20	lkh			 리뉴얼
	 * 2014.10.28  mypark 	검색 개선
	 * 
	 * author lkh
	 * since 2013.10.20
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
	//관리자 외에 등록 된 측정소가 없을 경우 메인으로 이동
	if(user_roleCode != 'ROLE_ADMIN'){
		if(user_u_cnt == 0 && user_a_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
//<![CDATA[
	var chkCnt = 0;
	
	$(function () {
		$('#search').click(function () {
			search_data();
		});
		
		$('#system').change(function(){
			adjustGongku();
			adjustGongkuDropDownY();
			
			sysChange();
		});
		
		$('#sugyeX').change(function(){
			adjustGongku();
		});
		
		$('#sugyeY').change(function(){
			adjustGongkuDropDownY();
		});
		
		$('#factCodeX').change(function(){
			adjustBranchListNew();
		});
		
		$('#branchNoX').change(function(){
		});
		
		//$('#sugyeY').change(function(){
		//	adjustGongkuDropDownY();
		//});
		
		$('#factCodeY').change(function(){
		//	adjustBranchDropDownY();
		});
		
		$('#branchNoY').change(function(){
		});
		
		var today = new Date();
		var yday = new Date(Date.parse(today) - 2 * 1000 * 60 * 60 * 12);
		
		var todayStr = today.getFullYear() + "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		var yday = yday.getFullYear() + "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		
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
			buttonText: '시작일자'
		});
		
		$("#endDate").datepicker({
			buttonText: '종료일자'
		});
		
		$('#startDate').val(yday);
		$('#endDate').attr('value', todayStr);
		
		var mArr = new Array();
		for(var i=0; i<23; i++) {
			var tmp = addzero(i+1);
			mArr.push({CAPTION:tmp+"시",VALUE:tmp});
		}
		$('#startTime').loadSelect(mArr);
		$('#startTime').attr('value', '01');
		$('#endTime').loadSelect(mArr);
		$('#endTime').attr('value', '01');
				
		
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugyeX');
			
			adjustGongku();
		}else{
			$("#system option").remove();
			if(user_u_cnt != 0 ){
				$("#system").append("<option value='U'>이동형측정기기</option>");
			}
			if(user_a_cnt != 0 ){
				$("#system").append("<option value='A'>국가수질자동측정망</option>");
			}
			selectedSugyeInMemberIdNew(id, $('#system').val(), 'sugyeX');
		}
		
// 		adjustGongku();
		
		selectedSugyeInMemberId(user_riverid , 'sugyeY');
		adjustGongkuDropDownY();
		
		getBItemDropDown();
		
	});
	
	//시스템 변경시
	function sysChange()
	{
		var sys = $("#system").val();
		
		if(sys == "A")
		{
			$("#spanBItemX").show();
		}
		else
		{
			$("#spanBItemX").hide();
		}
	}
	
	var itemCnt;
	var itemArray;
	var itemCode;
	var itemEName;
	
	var itemCnt2;
	var itemArray2;
	var itemCode2;
	var itemEName2;
	
	//itemArray 셋팅
	function itemSetting(sys)
	{
		itemArray = new Array(itemCnt);
		itemCode = new Array(itemCnt);
		itemEName = new Array(itemCnt);
		
		itemCnt2 = 2;
		itemArray2 = new Array(itemCnt2);
		itemCode2 = new Array(itemCnt2);
		itemEName2 = new Array(itemCnt2);
		
		itemArray2[0] = "수위"; itemCode2[0] = "WLV00"; itemEName2[0] = "wlv";
		itemArray2[1] = "유량"; itemCode2[1] = "FLW00"; itemEName2[1] = "flw";
		
		if(sys == "A")
		{
			itemCnt = 41;
			itemArray[0] = "탁도";				itemCode[0] = "TUR00";			itemEName[0] = "tur";
			itemArray[1] = "pH";				itemCode[1] = "PHY00";			itemEName[1] = "phy";
			itemArray[2] = "DO";				itemCode[2] = "DOW00";			itemEName[2] = "dow";
			itemArray[3] = "EC";				itemCode[3] = "CON00";			itemEName[3] = "con";
			itemArray[4] = "수온";				itemCode[4] = "TMP00";			itemEName[4] = "tmp";
			itemArray[5] = "총유기탄소";			itemCode[5] = "TOC00";			itemEName[5] = "toc";
			itemArray[6] = "임펄스";				itemCode[6] = "IMP00";			itemEName[6] = "imp";
			itemArray[7] = "임펄스(좌)";			itemCode[7] = "LIM00";			itemEName[7] = "lim";
			itemArray[8] = "임펄스(우)";			itemCode[8] = "RIM00";			itemEName[8] = "rim";
			itemArray[9] = "독성지수(좌)";			itemCode[9] = "LTX00";			itemEName[9] = "ltx";
			itemArray[10] = "독성지수(우)";			itemCode[10] = "RTX00";			itemEName[10] = "rtx";
			itemArray[11] = "미생물독성지수";		itemCode[11] = "TOX00";			itemEName[11] = "tox";
			itemArray[12] = "조류독성지수";			itemCode[12] = "EVN00";			itemEName[12] = "evn";
			itemArray[13] = "염화메틸렌";			itemCode[13] = "VOC01";			itemEName[13] = "voc1";
			itemArray[14] = "1.1.1-트리클로로에테인";itemCode[14] = "VOC02";			itemEName[14] = "voc2";
			itemArray[15] = "벤젠";				itemCode[15] = "VOC03";			itemEName[15] = "voc3";
			itemArray[16] = "사염화탄소";			itemCode[16] = "VOC04";			itemEName[16] = "voc4";
			itemArray[17] = "트리클로로에틸렌";		itemCode[17] = "VOC05";			itemEName[17] = "voc5";	
			itemArray[18] = "톨루엔";				itemCode[18] = "VOC06";			itemEName[18] = "voc6";
			itemArray[19] = "테트라클로로에티렌";		itemCode[19] = "VOC07";			itemEName[19] = "voc7";
			itemArray[20] = "에틸벤젠";			itemCode[20] = "VOC08";			itemEName[20] = "voc8";
			itemArray[21] = "m,p-자일렌";			itemCode[21] = "VOC09";			itemEName[21] = "voc9";
			itemArray[22] = "o-자일렌";			itemCode[22] = "VOC10";			itemEName[22] = "voc10";
			itemArray[23] = "[ECD]염화메틸렌";		itemCode[23] = "VOC11";			itemEName[23] = "voc11";
			itemArray[24] = "[ECD]1.1.1-트리클로로에테인";itemCode[24] = "VOC12";		itemEName[24] = "voc12";
			itemArray[25] = "[ECD]사염화탄소";		itemCode[25] = "VOC13";			itemEName[25] = "voc13";
			itemArray[26] = "[ECD]트리클로로에틸렌";	itemCode[26] = "VOC14";			itemEName[26] = "voc14";
			itemArray[27] = "[ECD]테트라클로로에티렌";itemCode[27] = "VOC15";			itemEName[27] = "voc15";
			itemArray[28] = "총질소";				itemCode[28] = "TON00";			itemEName[28] = "ton";
			itemArray[29] = "총인";				itemCode[29] = "TOP00";			itemEName[29] = "top";
			itemArray[30] = "암모니아성질소";		itemCode[30] = "NH400";			itemEName[30] = "nh4";
			itemArray[31] = "질산성질소";			itemCode[31] = "NO300";			itemEName[31] = "no3";
			itemArray[32] = "인산염인";			itemCode[32] = "PO400";			itemEName[32] = "po4";
			itemArray[33] = "Chl-a";			itemCode[33] = "TOF00";			itemEName[33] = "tof";
			itemArray[34] = "카드뮴";				itemCode[34] = "CAD00";			itemEName[34] = "cad";
			itemArray[35] = "납";				itemCode[35] = "PLU00";			itemEName[35] = "plu";
			itemArray[36] = "구리";				itemCode[36] = "COP00";			itemEName[36] = "cop";
			itemArray[37] = "아연";				itemCode[37] = "ZIN00";			itemEName[37] = "zin";
			itemArray[38] = "페놀1";				itemCode[38] = "PHE00";			itemEName[38] = "phe";
			itemArray[39] = "페놀2";				itemCode[39] = "PHL00";			itemEName[39] = "phl";
			itemArray[40] = "강수량";				itemCode[40] = "RIN00";			itemEName[40] = "rin";
		}
		else if(sys == "U")
		{
			itemCnt = 6;
			itemArray[0] = "탁도";	itemCode[0] = "TUR00";  itemEName[0] = "tur";
			itemArray[1] = "수온";	itemCode[1] = "TMP00";  itemEName[1] = "tmp";
			itemArray[2] = "pH";	itemCode[2] = "PHY00";  itemEName[2] = "phy";
			itemArray[3] = "DO";	itemCode[3] = "DOW00"; itemEName[3] = "dow";
			itemArray[4] = "전기전도도";	itemCode[4] = "CON00"; itemEName[4] = "con";
			itemArray[5] = "Chl-a";	itemCode[5] = "TOF00"; itemEName[5] = "tof";
		}
		else
		{
			itemCnt = 5;
			itemArray[0] = "탁도";	itemCode[0] = "TUR00";  itemEName[0] = "tur";
			itemArray[1] = "수온";	itemCode[1] = "TMP00";  itemEName[1] = "tmp";
			itemArray[2] = "pH";	itemCode[2] = "PHY00";  itemEName[2] = "phy";
			itemArray[3] = "DO";	itemCode[3] = "DOW00"; itemEName[3] = "dow";
			itemArray[4] = "전기전도도";	itemCode[4] = "CON00"; itemEName[4] = "con";
		}
	}
	
	var upperX;
	var lowerX;
	
	function setItemBound()
	{
		var sys = $("#system").val();
		var bItem = $("#bItemX").val();
		
		upperX = 0;
		lowerX = 0;
		
		if(sys == "T")
		{
			upperX = 4;
			lowerX = 0;
			return;
		}
		if(sys == "U")
		{
			upperX = 5;
			lowerX = 0;
			return;
		}
		
		if(bItem == "COM1")
		{
			lowerX = 0;
			upperX = 4;
		}
		else if(bItem == "ORGA")
		{
			lowerX = 5;
			upperX = 5;
		}
		else if(bItem == "BIO1")
		{
			lowerX = 6;
			upperX = 6;
		}
		else if(bItem == "BIO2")
		{
			lowerX = 7;
			upperX = 8;
		}
		else if(bItem == "BIO3")
		{
			lowerX = 9;
			upperX = 10;
		}
		else if(bItem == "BIO4")
		{
			lowerX = 11;
			upperX = 11;
		}
		else if(bItem == "BIO5")
		{
			lowerX = 12;
			upperX = 12;
		}
		else if(bItem == "VOCS")
		{
			lowerX = 13;
			upperX = 27;
		}
		else if(bItem == "NUTR")
		{
			lowerX = 28;
			upperX = 32;
		}
		else if(bItem == "CHLA")
		{
			lowerX = 33;
			upperX = 33;
		}
		else if(bItem == "METL")
		{
			lowerX = 34;
			upperX = 37;
		}
		else if(bItem == "PHEN")
		{
			lowerX = 38;
			upperX = 39;
		}
		else if(bItem == "RAIN")
		{
			lowerX = 40;
			upperX = 40;
		}
	}
	
	//대분류 목록 채우기
	function getBItemDropDown(){
		
		var itemCode = "";
		
		itemCode = "42";
		
		var dropDownSetX = $('#bItemX');
		
		dropDownSetX.attr("disabled", false);
		
		$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
			if(status == 'success'){
				//item 객체에 SELECT 옵션내용 추가.
				dropDownSetX.loadSelect(data.codes);
			} else { 
				//alert("ERROR!");
				return;
			}
		});
	}
	
	// 공구 목록 가져오기
	function adjustGongku()
	{	
		var system = "";
		if($('#system').val() == undefined) {
			system = "all";
		} else {
			system = $('#system').val();
		}
		
		var sugyeCd = $('#sugyeX').val();
		var dropDownSet = $('#factCodeX');
		
		dropDownSet.attr("style", "background:#ffffff;");
		
		if( sugyeCd == 'all' ){
			dropDownSet.attr("disabled", true);
			dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuListNew.do", {system:system, sugye:sugyeCd}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					
					if (system == "U"){
						dropDownSet.attr("disabled", true);
						dropDownSet.attr("style", "background:#e9e9e9;");
					}
					
					adjustBranchListNew();
// 					adjustBranchDropDownX();
				} else { 
					 alert("공구 목록 가져오기 실패");
					return;
				}
				
				//2014-10-28 검색 개선
				if(system == 'U') {
					$('#spanFact').show();
					$('#branchNoX').show();
					$('#factCodeX').hide();
					$('#spanBranch').hide();
				} else {
					$('#spanFact').show();
					$('#factCodeX').show();
					$('#spanBranch').hide();
					$('#branchNoX').hide();
				}
			});
		}
	}
	
	function adjustGongkuDropDownX()
	{		
		var system = "";
		if($('#system').val() == undefined) {
			system = "all";
		} else {
			system = $('#system').val();
		}
		
		var sugyeCd = $('#sugyeX').val();
		var dropDownSet = $('#factCodeX');
		
		dropDownSet.attr("style", "background:#ffffff;");
		
		if( sugyeCd == 'all' ){
			dropDownSet.attr("disabled", true);
			dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {system:system, sugye:sugyeCd}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					
					if (system == "U"){
						dropDownSet.attr("disabled", true);
						dropDownSet.attr("style", "background:#e9e9e9;");
					}
					
					adjustBranchDropDownX();
				} else { 
					 alert("공구 목록 가져오기 실패");
					return;
				}
				
				//2014-10-28 검색 개선
				if(system == 'U') {
					$('#spanFact').show();
					$('#branchNoX').show();
					$('#factCodeX').hide();
					$('#spanBranch').hide();
				} else {
					$('#spanFact').show();
					$('#factCodeX').show();
					$('#spanBranch').hide();
					$('#branchNoX').hide();
				}
			});
		}
	}
	
	//측정소 목록 가져오기
	function adjustBranchListNew()
	{
		var url = "";
		
		if(user_roleCode == 'ROLE_ADMIN'){
			url = "<c:url value='waterpolmnt/waterinfo/getBranchList.do'/>";
		}else{
			url = "<c:url value='waterpolmnt/waterinfo/getBranchListNew.do'/>";
		}
		
		var factCode = $('#factCodeX').val();
		var dropDownSet = $('#branchNoX');
		if( factCode == 'all' ){
			dropDownSet.attr("disabled", true);
			dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON(ROOT_PATH+url, {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.branch);
					
					init();
				} else { 
					 alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	function adjustBranchDropDownX()
	{
		var factCode = $('#factCodeX').val();
		var dropDownSet = $('#branchNoX');
		if( factCode == 'all' ){
			dropDownSet.attr("disabled", true);
			dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getBranchList.do", {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.branch);
					
					init();
				} else { 
					 alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	function adjustGongkuDropDownY()
	{
		var sugyeCd = $('#sugyeY').val();
		var dropDownSet = $('#factCodeY');
		
		if( sugyeCd == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getFlowFact.do'/>",
					{sugye:sugyeCd}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					
					init();
				} else { 
					alert("지역 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	var initCnt = 2;
	var initFlagCnt = 0;
	var firstFlag = true;
	function init() {
		initFlagCnt++;
		if(firstFlag && initFlagCnt >= initCnt) {
			search_data();
			firstFlag = false;
		}
	}
	
	function getWeatherX()
	{
			var sugye = $("#sugyeX").val();
			var gongku = $("#factCodeX").val();
			var chukjeongso = $("#branchNoX").val();
			var branchName = $("#branchNoX > option:selected").text();
			var frDate = $("#startDate").val2();
			var toDate = $("#endDate").val2();
		    var frTime = $("#frTime").val();
			var toTime = $("#toTime").val();
			var sys = $("#system").val();
		
			//document.listFrm.action = "/waterpolmnt/waterinfo/getWeatherInfoList.do";
			//document.listFrm.submit();

			$("#factNameX").text(branchName);
			
			$.ajax({
				type:"post",
				url:"/waterpolmnt/waterinfo/getWeatherInfoList2.do",
				data:{sys:$("#system").val(),
					  river_div:sugye, 
					  factCode:gongku,
					  branch_no:chukjeongso,
					  frDate:frDate,
					  toDate:toDate,
					  frTime:frTime,
					  toTime:toTime,
					  sys:sys
					  },
				dataType:"json",
				success:function(result){
	                var tot = result['dataList'].length;
	                var item;
					var trClass;
					
	                $("#weatherDataX").html("");

	                if( tot <= "0" ){
	            		$("#weatherDataX").html("<tr><td colspan='3'>조회 결과가 없습니다</td></td>");
	                }else{
		                for(var i=0; i < tot; i++){
			                
		                    var obj = result['dataList'][i];
		                    
		                    //var imgSrc = getWeatherImg(obj.current_weather);

		                      if(obj.current_weather == null || obj.current_weather == "" || obj.current_weather == undefined)
	                    			obj.current_weather = obj.weather_sky;
			                    
		                    var item = "<tr>";
			                    
		                

	    	                 item += "<td id='rem"+i+"'>"+obj.announce_time+"</td>"		    	                     	               
	    	                 item += "<td id='rem"+i+"'>"+obj.current_weather+"</td>"		    	                     	               
	                       	 item += "<td class='num'><span id='rem"+i+"'>"+(obj.temp=="" ? "-" : obj.temp) +"</td>";
	                       	 
	                 		item += "</tr>";


		           			$("#weatherDataX").append(item);

		                }
	                }

				},
	            error:function(result){  
					$("#weatherDataX").html("");
		            $("#weatherDataX").html("<tr><td colspan='3'>실패!</td></td>");
		        }
			});
	}
	
	function search_data(){
		
		if( validation() == false )
		{
			closeLoading();
			return;
		}
		
		var sys = $("#system").val();
		itemSetting(sys);
		
		showLoading();
		getWeatherX();
		
		var startDate = "";
		var endDate = "";
		var itemCodeX = "";
		var itemCodeXName = "";
		var itemCodeY = "";
		var itemCodeYName = "";
		
		startDate = $("#startDate").val2() + $("#frTime").val();
		endDate = $("#endDate").val2() + $("#toTime").val();
		
		var bItemX = $("#bItemX").val();
		
		var branchNoX = "";
		var branchNoY = "";
		
		if($("#branchNoX").val() != null)
			branchNoX = $("#branchNoX").val();
		if($("#branchNoY").val() != null)
			branchNoY = $("#branchNoY").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/stats/getRelateFlowAnalysis.do'/>",
			data:{
						system:$("#system").val(),
						factCodeX:$("#factCodeX").val(),
						branchNoX:branchNoX, 
						factCodeY:$("#factCodeY").val(),
						branchNoY:branchNoY,
						BItemX:bItemX,
						startDate:startDate,
						endDate:endDate},
			dataType:"json",
			success:function(result){
				
				$("#statsBody").html("");
				
				var tableStyle = "style='";
				
				if(sys=="A" && $("#bItemX").val() == "VOCS")
					tableStyle += "width:1500px";
				//if($("#bItemY").val() == "VOCS")
				//	tableStyle += "";
				tableStyle += "'";
				
				//테이블 생성
				var headerT = $("<table class='dataTable' "+tableStyle+"></table>").html($("<thead id='tableHeader'></thead>"));
				$("#overBox_header").html("");
				$("#overBox_header").html(headerT);
				
				if(sys=="A" && $("#bItemY").val() == "VOCS")
					$("#overBox_header").css("overflow-y","scroll");
				else
					$("#overBox_header").css("overflow-y","hidden");
					
				var table = $("<table class='dataTable' "+tableStyle+"></table>").html($("<tbody id='statsBody'></tbody>"));
				$("#overBox2").html("");
				$("#overBox2").html(table);
				
				//lower,upper setting
				setItemBound();
				//헤더생성
				var header = "<tr>";
				header += "<th>기준/비교</th>";
				for(var idx = lowerX ; idx <= upperX ;idx++)
				{
					header += "<th>"+itemArray[idx]+"</th>";
				}
				header += "</tr>";
				
				$("#tableHeader").html("");
				$("#tableHeader").html(header);
				
				var item = "";
				
				var dataCnt = 0;
					
				for(var yIdx = 0; yIdx <= 1 ; yIdx++)
				{
					item += "<tr><th scope='row'>"+itemArray2[yIdx]+"</th>";
					
					for(var xIdx = lowerX ; xIdx <= upperX ; xIdx++)
					{
						var value = result[itemEName[xIdx]+itemEName2[yIdx]];
						if(value == undefined) value="-";
						
						if(value == "-0.00")
							value = "0.00";
						
						if(value != "-")
							dataCnt++;
						
// 						if(xIdx == lowerX)
// 							item += "<td id='first' onclick='chart_popup(this, " + itemCode[xIdx] + ", " + itemCode2[yIdx] + ")'>" + value + "</td>";
// 						else
// 							item += "<td onclick='chart_popup(this, " + itemCode[xIdx] + "," + itemCode2[yIdx] + ")'>" + value + "</td>";
							
						if(xIdx == lowerX)
							item += "<td id='first' onclick='chart_popup(this, \""+itemCode[xIdx]+"\", \""+itemCode2[yIdx]+"\")'>" + value + "</td>";
						else
							item += "<td onclick='chart_popup(this, \""+itemCode[xIdx]+"\", \""+itemCode2[yIdx]+"\")'>" + value + "</td>";
					}
					
					item += "</tr>";
				}
				
					$("#statsBody").append(item);
					var item = "<tr>";
					
					if(dataCnt == 0) {
						alert("조회된 측정값이 없어 상관계수를 구할 수 없습니다");
						$("#chartTitle").text("그래프 (상관계수를 구할 수 없습니다.)");
					}
					else
						chart_popup(document.getElementById('first'), itemCode[lowerX], itemCode2[0]);
					
				closeLoading();
			},
			error:function(result){}
		});
	}
	
	function chart_popup(obj, itemX, itemY) {
	
		$("#span_loading").show();
		
		$("td").css("background", "white");
		obj.style.background = "#CCC";
		
		if(obj.innerHTML == "-")
			$("#chartTitle").text("그래프 (상관계수를 구할 수 없습니다.)");
		else
			$("#chartTitle").text("그래프");
		
		var startDate = "";
		var endDate = "";
		var itemCodeX = "";
		var itemCodeXName = "";
		var itemCodeY = "";
		var itemCodeYName = "";
		
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 340;
		var winWidth = 1050;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		startDate = $("#startDate").val2() + $("#frTime").val();
		endDate = $("#endDate").val2() + $("#toTime").val();
		
		itemCodeX = itemX;
		itemCodeY = itemY;
		
		var branchNoX = " ";
		var branchNoY = " ";
		
		if($("#branchNoX").val() != null)
			branchNoX = $("#branchNoX").val();
		if($("#branchNoY").val() != null)
			branchNoY = $("#branchNoY").val();
		
		var param = "system="+$("#system").val()+
					"&factNameX="+$("select[name='factCodeX'] > option:selected").text()+
					"&factCodeX="+$("#factCodeX").val()+
					"&branchNoX="+branchNoX+
					"&itemCodeX="+itemCodeX+
					"&factNameY="+$("select[name='factCodeY'] > option:selected").text()+
					"&factCodeY="+$("#factCodeY").val()+
					"&branchNoY="+branchNoY+
					"&itemCodeY="+itemCodeY+
					"&startDate="+startDate+
					"&endDate="+endDate+
					"&width="+width+
					"&height="+height;
		
		chartIfrm.location.href="<c:url value='/stats/getItemAnalysisStatsChart.do'/>?"+encodeURI(param);
	}	
	
	function chartLoaded()
	{
		$("#span_loading").hide();
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
		
		var date = new Date(stdt.value).getTime();
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
		
		timeCheck();
	}
	
	//추이 팝업
	function transitionPopup()
	{
		var sugyeX;// = $("#sugyeX").val();
		var sugyeY;// = $("#sugyeX").val();
		var gongkuX;// = $("#factCodeX").val();
		var gongkuY;// = $("#factCodeX").val();
		var chukjeongsoX = "";// = $("#branchNoX").val();
		var chukjeongsoY = "";// = $("#branchNoX").val();
		var branchNameX;// = $("#branchNoX > option:selected").text();
		var branchNameY;// = $("#branchNoX > option:selected").text();
		var sys = $("#system").val();
		
		itemSetting(sys);
		
		sugyeX = $("#sugyeX").val();
		gongkuX = $("#factCodeX").val();
		
		if($("#branchNoX").val() != null)
			chukjeongsoX = $("#branchNoX").val();
		
		branchNameX = $("#branchNoX > option:selected").text();
		
		sugyeY = $("#sugyeY").val();
		gongkuY = $("#factCodeY").val();
		
		if($("#branchNoY").val() != null)
			chukjeongsoY = $("#branchNoY").val();
		
		branchNameY = $("#branchNoY > option:selected").text();
		
		var sys = $("#system").val();
		var sw=screen.width;var sh=screen.height;
		
		var bItemX = $("#bItemX").val();
		var bItemY = $("#bItemY").val();
		
		var startDate = $("#startDate").val2() + $("#frTime").val();
		var endDate = $("#endDate").val2() + $("#toTime").val();
		
		var winHeight = 820;
		var winWidth = 1000;
		
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		
		var param = "sys=" + sys + 
					"&bItemX=" + bItemX + 
					"&bItemY=" + bItemY +
					"&startDate=" + startDate + 
					"&endDate=" + endDate + 
					"&factCodeX=" + gongkuX +
					"&factCodeY=" + gongkuY +
					"&branchNoX=" + chukjeongsoX +
					"&branchNoY=" + chukjeongsoY;
		
		var src = "<c:url value='/stats/goRelateFlowGraph.do'/>?" + param;
		
		window.open(src,
				'relateFlowAnalysis','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
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
					
						<!-- 검색 -->
						<form action="" onsubmit="return false">
						
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">시스템</span>
									<select class="fixWidth13" id="system" name="system" style="width:130px;">
											<option value="U" selected="selected">이동형측정기기</option>
											<!-- <option value="T">탁수모니터링</option> -->
											<option value="A">국가수질자동측정망</option>
									</select>
								</li>
								<li>
									<span class="fieldName">기준 측정소</span>
									<select class="fixWidth7" id="sugyeX" name="sugyeX">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span id="spanFact">&gt;</span>
									<select class="fixWidth11" id="factCodeX" name="factCodeX">
										<option value="none">선택</option>
									</select>
									<span id="spanBranch">&gt;</span>
									<select class="fixWidth11" id="branchNoX" name="branchNoX">
										<option value="1">제 1 측정소</option>
									</select>
								</li>
								<!-- <li>
									<select class="fixWidth7" id="sugye" name="sugye">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
								</li> -->
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" size="13" id="startDate" name="frDate" onchange="commonWork()"/>
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
								</li>
								<li>
									<span class="fieldName">측정항목</span>
									<select class="fixWidth12" id="bItemX" name="bItemX">
										<option value="COM1">일반항목</option>
									</select>
								</li>
								<li>
<!--									<span>비교 측정소</span> -->
									<span class="fieldName">유량관측소(수위,유량)</span>
									<select class="fixWidth7" id="sugyeY">
										<option value="R01" selected="selected">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span>&gt;</span>
									<select class="fixWidth11" id="factCodeY"></select>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:search_data();" alt="조회하기" style="float:right;"/>
						</div>
						</form>
						<!-- // 검색 -->
						
						<!-- 현황 -->
						<div class="divisionBx">
							<div class="div50">
								<form id="listFrm1" name="listFrm1" action="/itemmanage/setSaveGroup.do" onsubmit="return false">
								
									<div class="topBx mBt5" >
										<span class="buSqu_tit">상관계수</span><span class="red">※조사결과는 확정자료가 아닙니다</span>
										<input type="button" id="btnTransition" name="btnTransition" value="추이" class="btn btn_basic" onclick="javascript:transitionPopup();" />
									</div>
									
									<div style="height: 200px">
										<table summary="수위유량 정보">
											<thead id="tableHeader">
											</thead>
											<tbody id="statsBody">
											</tbody>
										</table>
									</div>
								
								</form>
							</div>
							
							<script type="text/javascript">
								function scrollX()
								{
									document.getElementById("overBox_header").scrollLeft = document.getElementById("overBox2").scrollLeft;
								}
							</script>
							<!-- // 현황 -->
							
							<!-- 개황정보 -->
							<div class="div50 last" style="width:475px;float:right;clear:right;">
								<div class="topBx mBt5" style="height:20px">
									<span class="buSqu_tit">개황정보</span>
								</div>
								<table class="dataTable" style="float: left; width: 457px">
									<colgroup>
										<col width="154px"/>
										<col width="100px"/>
										<col/>
									</colgroup>
									<thead>
										<tr>
											<th colspan="3"><span id="factNameX">팔당호1-14</span></th>
										</tr>
										<tr>
											<th>날자</th>
											<th>날씨</th>
											<th>기온</th>
										</tr>
									</thead>
								</table>
								<div id="data_map" class="data_map" style="width: 475px; max-height:159px; overflow-y: auto">
									<table class="dataTable" style="float: left; width: 457px">
										<colgroup>
											<col width="154px"/>
											<col width="100px"/>
											<col/>
										</colgroup>
										<tbody id="weatherDataX">
										</tbody>
									</table>
								</div>
							</div>
							<!--// 개황정보 -->
						</div>
						
						<!-- 그래프 -->
						<div class="buSqu_tit" style="clear:both;font-weight:bold;text-align:left;" id="chartTitle">그래프</div>
						<div id="data_graph" style="clear:both;width:990px;height:330px;float:right;border:solid 1px #CCC;display:inline-block;">
							<span id="span_loading" style="position:absolute;display:none">그래프를 불러오는 중 입니다...</span>
							<iframe id="chartIfrm" onload="chartLoaded()" name="chartIfrm" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="330px"></iframe>
						</div>
						<!--// 그래프 -->
						
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