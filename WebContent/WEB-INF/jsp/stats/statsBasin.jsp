<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : statsBasin.jsp
	 * Description : 유역별통계 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2013.10.20	lkh			리뉴얼
	 * 2014.10.28  mypark 	검색 개선
	 * 2014.11.18  mypark    그리드 걷어내고 테이블 처리
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
		if(user_u_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
//<![CDATA[
	$(function () {
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugye');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'U', 'sugye');
		}
		
		$('#system').change(function(){
			adjustGongkuDropDown2(false);
			$('#factCode').attr("disabled", true);			
			if($(this).val() == "A" || $(this).val() == "all")
				$("#itemBox").attr("class", "rows2");
			else
				$("#itemBox").attr("class", "rows1");
		});
		
		$('#sugye').change(function(){
			adjustGongkuDropDown2(false, true);
			$('#factCode').attr("disabled", false);
			//2014-10-28 mypark 검색 개선
			$('#factCode').hide();
		});
		
		$('#factCode').change(function(){
			setChartBtn(true);
			//adjustBranchDropDown();
		});
		
		$('#branchNo').change(function(){
			//adjustItemList();
		});
		
		$("#quarter").change(function() {
			setChartBtn(true);
		});
		
		$("#month").change(function() {
			setChartBtn(true);
		});
		
		$("#day").change(function() {
			setChartBtn(true);
		});
		
		$(":radio[name=gubun]").click(function(){
			var gubun = $(":radio[name=gubun]:checked").val();
			if(gubun == 1) {
				$("#year").show();
				$("#quarter").hide();
				$("#month").hide();
				$("#day").hide();
			} else if(gubun == 2) {
				$("#year").show();
				$("#quarter").show();
				$("#month").hide();
				$("#day").hide();
			} else if(gubun == 3) {
				$("#year").show();
				$("#quarter").hide();
				$("#month").show();
				$("#day").hide();
				setMonth(true);
			} else if(gubun == 4) {
				$("#year").show();
				$("#quarter").hide();
				$("#month").show();
				$("#day").show();
				setMonth(false);
			}
		});
		
		$("#year").show();
		$("#quarter").hide();
		$("#month").hide();
		$("#day").hide();
		
		var today = new Date();
		
		var yArr = new Array();
		for(var i=6; i>=0; i--) {
			var tmp = Number(today.getFullYear())-i;
			yArr.push({CAPTION:tmp+"년",VALUE:tmp});
		}
		$('#year').loadSelect(yArr);
		$('#year').attr('value', today.getFullYear());
		
		setMonth(true);
		
		var dArr = new Array();
		dArr.push({CAPTION:"전체",VALUE:"all"});
		
		var check_date= today.getDate()-1;

		var pre_day;
		
		if(check_date==0){
			var newDay = new Date(today.getFullYear(), today.getMonth(), "");
		    var lastDay = newDay.getDate();
		    
		    pre_day = lastDay;
		}else{
			pre_day = today.getDate()-1;
		}
		
		
		for(var i=0; i<31; i++) {
			var tmp = addzero(i+1);
			dArr.push({CAPTION:tmp+"일",VALUE:tmp});
		}
		
		$('#day').loadSelect(dArr);
		$('#day').attr('value', addzero(pre_day));
		
		adjustGongkuDropDown2(false, true);
		$('#factCode').attr("disabled", true);
		
		init();
		
		
	});
	
	function adjustGongku(){
		
	}
	
	function setMonth(isAll) {
		var today = new Date();
		var mArr = new Array();
		
		if(isAll == true) mArr.push({CAPTION:"전체",VALUE:"all"});
		
		for(var i=0; i<12; i++) {
			var tmp = addzero(i+1);
			mArr.push({CAPTION:tmp+"월",VALUE:tmp});
		}
		$('#month').loadSelect(mArr);
		
		if(isAll == true){
			$('#month').attr('value', addzero(today.getMonth()));	
		}else{
			$('#month').attr('value', addzero(today.getMonth()+1));	
		}
	}
	
	var firstFlag = true;
	function init() {
		if(firstFlag) {
			search_data();
			firstFlag = false;
		}
	}
	
	var itemCnt;
	var sItemCnt;
	
	//itemArray 셋팅
	function itemSetting(sys) {
/* 		if(sys == "T") {
			itemCnt = 2;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도(NTU)";	itemCode[0] = "TUR";
			itemArray[1] = "EC(mS/cm)";	itemCode[4] = "CON";
		} */
		if(sys == "U") {
			itemCnt = 6;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도(NTU)";	itemCode[0] = "TUR";
			itemArray[1] = "수온(℃)";	itemCode[1] = "TMP";
			itemArray[2] = "pH";	itemCode[2] = "PHY";
			itemArray[3] = "DO(mg/L)";	itemCode[3] = "DOW";
			itemArray[4] = "EC(mS/cm)";	itemCode[4] = "CON";
			itemArray[5] = "Chl-a(μg/L)";	itemCode[5] = "TOF";
		} else if(sys=="A") {
			itemCnt = 45;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "pH1";			itemCode[0] = "PHY00";
			itemArray[1] = "DO1<br/>(mg/L)";		itemCode[1] = "DOW00";
			//itemArray[2] = "EC1<br/>(mS/cm)";	itemCode[2] = "CON00";
			itemArray[2] = "EC1<br/>(μS/cm)";	itemCode[2] = "CON00";
			itemArray[3] = "수온1<br/>(℃)";	itemCode[3] = "TMP00";
			
			itemArray[4] = "pH2";			itemCode[4] = "PHY01";
			itemArray[5] = "DO2<br/>(mg/L)";		itemCode[5] = "DOW01";
			//itemArray[6] = "EC2<br/>(mS/cm)";	itemCode[6] = "CON01";
			itemArray[6] = "EC2<br/>(μS/cm)";	itemCode[6] = "CON01";
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
			itemArray[19] = "벤젠";		itemCode[19] = "VOC03";
			itemArray[20] = "사염화탄소";	itemCode[20] = "VOC04";
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
	function makeHeader(sys)
		{
			var header;

			var overBox = $("#overBox");

			overBox.html("");

			var table = "<table class='dataTable' id='dataTable'>"
								+"<colgroup>"
								+"<col />"
								+"<col width='85' />"
								+"<col width='120'/>"
								+"<col width='85'/>"
								+"<col />"
								+"<col />"
								+"<col />"
								+"<col />"
								+"<col />"
                                +"<col />"
								+"<col />";
								if(sys=="U")
								{
									table+="<col />";
								}
							table +="</colgroup>"
						  	+ "<thead id='dataHeader'>" 
						  	+ "</thead>"
						  	+ "<tbody id='statsBody'>"
						    + "</tbody>"
						  + "</table>";
						 
			overBox.html(table);
		
			$("#dataTable").attr("class", "");
			$("#dataTable").attr("class", "dataTable");
			
			if(sys == "U")
			{
				$("#dataTable").css("width", "1500px");
			}
			else if(sys=="A")
			{
				$("#dataTable").css("width", "10200px");
			}
				
				

			if(sys=="A")
			{

				//헤더 생성
				$("#dataHeader").html("");
				header = "<tr>" + 
								"<th rowspan ='3' scope='col' class='bgStyle'>지역</th>" +
								"<th rowspan ='3' scope='col' class='bgStyle'>기간</th>" +
								"<th rowspan ='3' scope='col' class='bgStyle'>시스템</th>" +
								"<th rowspan ='3' scope='col' class='bgStyle'>측정소</th>";

								if(sys == "U")
									header += "<th rowspan ='3' scope='col' class='bgStyle'>수신율</th>";	
								

								header += "<th colspan ='"+(4*3)+"' scope='col' class='bgStyle'>일반항목(내부)</th>";
								header += "<th colspan ='"+(5*3)+"' scope='col' class='bgStyle'>일반항목(외부)</th>";
								header += "<th colspan='"+(1*3)+"' scope='col' class='bgStyle'>생물독성(물고기)</th>";
								header += "<th colspan='"+(2*3)+"' scope='col' class='bgStyle'>생물독성(물벼룩1)</th>";
								header += "<th colspan='"+(2*3)+"' scope='col' class='bgStyle'>생물독성(물벼룩2)</th>";
								header += "<th colspan='"+(1*3)+"' scope='col' class='bgStyle'>생물독성(미생물)</th>";
								header += "<th colspan='"+(1*3)+"' scope='col' class='bgStyle'>생물독성(조류)</th>";
								header += "<th colspan='"+(1*3)+"' scope='col' style='height:24px' class='bgStyle'>클로로필-a</th>";
								header += "<th colspan='"+(15*3)+"' scope='col' class='bgStyle'>휘발성 유기화합물</th>";
								header += "<th colspan='"+(4*3)+"' scope='col' style='height:24px' class='bgStyle'>중금속</th>";
								header += "<th colspan='"+(2*3)+"' scope='col' style='height:24px' class='bgStyle'>페놀</th>";
								header += "<th colspan='"+(1*3)+"' scope='col' style='height:24px' class='bgStyle'>유기물질</th>";
								header += "<th colspan='"+(5*3)+"' scope='col' style='height:24px' class='bgStyle'>영양염류</th>";
								header += "<th colspan='"+(1*3)+"' scope='col' style='height:24px' class='bgStyle'>강수량계</th>";
												
							header += "</tr><tr>";

								for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
								{
									header += "<th colspan='3' scope='col'>"+itemArray[rowIdx]+"</th>";
								}

							header += "</tr><tr>";
							
							for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
							{
								header += "<th scope='col'>최대</th>";
								header += "<th scope='col'>평균</th>";
								header += "<th scope='col'>최소</th>";
							}
			
							header += "</tr>";

							
			}
			else
			{
				
			//헤더 생성
			$("#dataHeader").html("");
			header = "<tr>" + 
							"<th rowspan ='2' scope='col'>지역</th>" +
							"<th rowspan ='2' scope='col'>기간</th>" +
							"<th rowspan ='2' scope='col'>시스템</th>" +
							"<th rowspan ='2' scope='col'>측정소</th>";

							if(sys == "U")
								header += "<th rowspan ='2' scope='col'>수신율</th>";
							
							for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
							{
								header += "<th colspan='3' scope='col'>"+itemArray[rowIdx]+"</th>";
							}
		
				
						header += "</tr><tr>"
		
						for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
						{
							header += "<th scope='col'>최대</th>";
							header += "<th scope='col'>평균</th>";
							header += "<th scope='col'>최소</th>";
						}
		
						header += "</tr>";
			}
		
			
			$("#dataHeader").append(header);			
			//$("#dataList").html("<tr><td colspan='"+(itemCnt + 6)+"'>데이터를 불러오는 중 입니다.</td></tr>");
	
		}
	
	function search_data(){

		showLoading();

		setChartBtn();
		var sysKind = $("#system").val();
		var riverDiv = $("#sugye").val();
		var factCode = $("#factCode").val();
		
		if(factCode == null || factCode == "none")
			factCode = 'all';

		itemSetting(sysKind);
		makeHeader(sysKind);			
		
		var searchDate = "";
		var itemCode = "";
		var gubun = $(":radio[name=gubun]:checked").val();				
		var statsDiv = "D";

		var year = $("#year").val();
		var quarter = $("#quarter").val();
		var month = $("#month").val();
		var day = $("#day").val();

		var paramMonth = "";
		var paramQuarter = "";
		var paramDay = "";
		
		
		if(gubun == 1) {
			searchDate = year;
			statsDiv = "Y";
			paramMonth = "";
			paramQuarter = "";
			$("#statTitle").text("[ "+year+"년 년간 통계 ]");
		} else if(gubun == 2) {
			searchDate = year;
			statsDiv = "Q" + quarter;
			if(quarter != "all")
			{
				$("#statTitle").text("[ "+year+"년 "+quarter+"분기 통계 ]");
				paramQuarter = "";
				paramMonth = "";
			}
			else
			{
				$("#statTitle").text("[ "+year+"년 분기별 통계 ]");
				statsDiv = "Q";
				paramQuarter = "all";
				paramMonth = "";
			}
		} else if(gubun == 3) {
			searchDate = year + month;
			statsDiv = "M";

			if(month != "all")
			{
				$("#statTitle").text("[ "+year+"년 "+month+"월 월간 통계 ]");
				paramQuarter = "";
				paramMonth = "";
			}
			else
			{
				searchDate = year;
				$("#statTitle").text("[ "+year+"년 월별 통계 ]");
				paramQuarter = "";
				paramMonth = "all";
			}
		} else if(gubun == 4) {
			searchDate = year + month + day;
			statsDiv = "D";

			if(day != "all")
			{
				$("#statTitle").text("[ "+year+"년 "+month+"월 "+day+"일 일간 통계 ]");
				paramDay = "";
			}
			else
			{
				$("#statTitle").text("[ "+year+"년 "+month+"월  일간 통계 ]");
				searchDate = year+month;
				paramDay = "all";					
			}
		}


		$("#statTitle").append("<span class='noticeSpan1'> ※조회결과는 확정자료가 아닙니다.</span>");
	
		$.ajax({
			type:"post",
			url:"/stats/getStatsBasin.do",
			data:{
					sysKind:$("#system").val(), 
					riverDiv:riverDiv,
					factCode:factCode, 
					branchNo:$("#branchNo").val(), 
					itemCode:itemCode, 
					startDate:searchDate, 
					month:paramMonth,
					quarter:paramQuarter,
					day:paramDay,
					gubun:gubun,
					statsDiv:statsDiv},
			dataType:"json",
			success:function(result){
                var tot = result['data'].length;


                item = "";

                $("#statsBody").html("");

                if( tot <= "0" ){
	                if(sysKind == "U")
                		$("#statsBody").html("<tr><td colspan='"+((itemCnt * 3)+ 5)+"'>조회 결과가 없습니다</td></td>");	   
	                else
	                	$("#statsBody").html("<tr><td colspan='"+((itemCnt * 3)+ 4)+"'>조회 결과가 없습니다</td></td>");
	                closeLoading();  
                } else {             
	                for(var j=0; j < tot; j++){
	                    var obj = result['data'][j];

	    				var item = "<tr id='rowIdx"+j+"'>";

	    				item +=
	    					 "<td>"+obj.regName+"</td>"

    					 if(gubun == 1)
			    			    item += "<td>" + year + "년</td>";
			    			else if(gubun == 2)
	    					 	item += "<td>"+obj.year + "년 " + obj.quarter+"</td>";
	    					else if(gubun == 3)
		    					item += "<td>"+obj.year + "년 " + obj.startMonth+"월</td>";
		    				else
			    				item += "<td>"+obj.day+"</td>";
				    				
	    					 item += "<td>"+obj.sysName+"</td>"
	    					 item += "<td>"+obj.branchName+"</td>";

	    					 if(sysKind == "U")
		    					 item += "<td>"+obj.recvRt+"</td>";
	    					 
	    					 if(sysKind == "T")
			                    {
			    					 item += "" 
				    			     + "<td class='num'><span>"+obj.turMax+"</span></td>"
			    					 + "<td class='num'><span>"+obj.turAvg+"</span></td>"
			    					 + "<td class='num'><span>"+obj.turMin+"</span></td>"
			    					 + "<td class='num'><span>"+obj.conMax+"</span></td>"    					 
			    					 + "<td class='num'><span>"+obj.conAvg+"</span></td>"	 
			    					 + "<td class='num'><span>"+obj.conMin+"</span></td>";   					 
			                    }
				                else if(sysKind == "U")
				                {
				                	 item += "" 
					    			     +"<td class='num'><span>"+obj.turMax+"</span></td>"
				    					 + "<td class='num'><span>"+obj.turAvg+"</span></td>"
				    					 + "<td class='num'><span>"+obj.turMin+"</span></td>"
					    			     +"<td class='num'><span>"+obj.tmpMax+"</span></td>"
				    					 + "<td class='num'><span>"+obj.tmpAvg+"</span></td>"
				    					 + "<td class='num'><span>"+obj.tmpMin+"</span></td>"
					    			     +"<td class='num'><span>"+obj.phyMax+"</span></td>"
				    					 + "<td class='num'><span>"+obj.phyAvg+"</span></td>"
				    					 + "<td class='num'><span>"+obj.phyMin+"</span></td>"
					    			     +"<td class='num'><span>"+obj.dowMax+"</span></td>"
				    					 + "<td class='num'><span>"+obj.dowAvg+"</span></td>"
				    					 + "<td class='num'><span>"+obj.dowMin+"</span></td>"
					    			     +"<td class='num'><span>"+obj.conMax+"</span></td>"
				    					 + "<td class='num'><span>"+obj.conAvg+"</span></td>"
				    					 + "<td class='num'><span>"+obj.conMin+"</span></td>"
					    			     +"<td class='num'><span>"+obj.tofMax+"</span></td>"
				    					 + "<td class='num'><span>"+obj.tofAvg+"</span></td>"
				    					 + "<td class='num'><span>"+obj.tofMin+"</span></td>";
				                } 
				                else if(sysKind == "A")
				                {
				                	item += "" 
					            	    + "<td class='num'><span>"+obj.phyMax+"</span></td>"
					            	    + "<td class='num'><span>"+obj.phyAvg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.phyMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.dowMax+"</span></td>"
					            	    + "<td class='num'><span>"+obj.dowAvg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.dowMin+"</span></td>"
					                	+ "<td class='num'><span>"+obj.conMax+"</span></td>"
										+ "<td class='num'><span>"+obj.conAvg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.conMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.tmpMax+"</span></td>"
					            	    + "<td class='num'><span>"+obj.tmpAvg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.tmpMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.phy1Max+"</span></td>"
					            	    + "<td class='num'><span>"+obj.phy1Avg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.phy1Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.dow1Max+"</span></td>"
					            	    + "<td class='num'><span>"+obj.dow1Avg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.dow1Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.con1Max+"</span></td>"
					            	    + "<td class='num'><span>"+obj.con1Avg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.con1Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.tmp1Max+"</span></td>"
					            	    + "<td class='num'><span>"+obj.tmp1Avg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.tmp1Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.turMax+"</span></td>"
					            	    + "<td class='num'><span>"+obj.turAvg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.turMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.impMax+"</span></td>"
					            	    + "<td class='num'><span>"+obj.impAvg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.impMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.limMax+"</span></td>"
					            	    + "<td class='num'><span>"+obj.limAvg+"</span></td>"
					            	    + "<td class='num'><span>"+obj.limMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.rimMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.rimAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.rimMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.ltxMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.ltxAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.ltxMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.rtxMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.rtxAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.rtxMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.toxMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.toxAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.toxMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.evnMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.evnAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.evnMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.tofMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.tofAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.tofMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc1Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc1Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc1Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc2Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc2Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc2Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc3Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc3Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc3Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc4Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc4Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc4Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc5Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc5Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc5Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc6Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc6Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc6Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc7Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc7Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc7Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc8Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc8Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc8Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc9Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc9Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc9Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc10Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc10Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc10Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc11Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc11Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc11Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc12Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc12Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc12Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc13Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc13Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc13Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc14Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc14Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc14Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.voc15Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc15Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.voc15Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.copMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.copAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.copMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.pluMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.pluAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.pluMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.zinMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.zinAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.zinMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.cadMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.cadAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.cadMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.pheMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.pheAvg+"</span></td>"

					            	     + "<td class='num'><span>"+obj.pheMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.phlMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.phlAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.phlMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.tocMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.tocAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.tocMin+"</span></td>"
					            	    + "<td class='num'><span>"+obj.tonMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.tonAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.tonMin+"</span></td>"
					            	     + "<td class='num'><span>"+obj.topMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.topAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.topMin+"</span></td>"
					            	     + "<td class='num'><span>"+obj.nh4Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.nh4Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.nh4Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.no3Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.no3Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.no3Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.po4Max+"</span></td>"
					            	     + "<td class='num'><span>"+obj.po4Avg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.po4Min+"</span></td>"
					            	    + "<td class='num'><span>"+obj.rinMax+"</span></td>"
					            	     + "<td class='num'><span>"+obj.rinAvg+"</span></td>"
					            	     + "<td class='num'><span>"+obj.rinMin+"</span></td>";
				                } 

	                    
	    				item += "</tr>"; 

	       				$("#statsBody").append(item);

	       			 	$("#rowIdx"+j+"  td > span").each(function(){
		                	if($(this).text() == "")
		                	{
			                	$(this).text("-");
		                	}
	                	});
	                	
	                    item = "";
	                }	
	                $('#statsBody tr:odd').addClass('add');
                }
                closeLoading();  

               
			},
            error:function(result){}
		});
	}    				
	
	function excel_down() {
		var sysKind = $("#system").val();
		var riverDiv = $("#sugye").val();
		var factCode = $("#factCode").val();
		
		if(factCode == null || factCode == "none")
			factCode = 'all';
		
		var searchDate = "";
		var itemCode = "";
		var gubun = $(":radio[name=gubun]:checked").val();
		var statsDiv = "D";
		var statsTitle = "";
		var year = $("#year").val();
		var quarter = $("#quarter").val();
		var month = $("#month").val();
		var day = $("#day").val();
		var paramMonth = "";
		var paramQuarter = "";
		var paramDay = "";
		
		if(gubun == 1) {
			searchDate = year;
			statsDiv = "Y";
			paramMonth = "";
			paramQuarter = "";
		} else if(gubun == 2) {
			searchDate = year;
			statsDiv = "Q" + quarter;
			if(quarter != "all") {
				paramQuarter = "";
				paramMonth = "";
			} else {
				statsDiv = "Q";
				paramQuarter = "all";
				paramMonth = "";
			}
		} else if(gubun == 3) {
			searchDate = year + month;
			statsDiv = "M";
			
			if(month != "all") {
				paramQuarter = "";
				paramMonth = "";
			} else {
				searchDate = year;
				paramQuarter = "";
				paramMonth = "all";
			}
		} else if(gubun == 4) {
			searchDate = year + month + day;
			statsDiv = "D";
			
			if(day != "all") {
				paramDay = "";
			} else {
				searchDate = year+month;
				paramDay = "all";
			}
		}
		
		var param = "system="+sysKind+"&factCode="+factCode+"&branchNo="+$("#branchNo").val()+"&itemCode="+itemCode
			+"&startDate="+searchDate+"&statsDiv="+statsDiv+"&gubun="+gubun + "&statsTitle=" + encodeURI(statsTitle) +
			"&quarter=" + paramQuarter +
			"&riverDiv=" + riverDiv +
			"&sysKind=" + sysKind +
			"&month=" + paramMonth +
			"&day=" + paramDay+
			"&searchYear=" + year + 
			"&searchMonth="  + month +
			"&searchDay=" + day +
			"&searchQuarter=" + quarter;
		
		location.href="<c:url value='/stats/getStatsBasinExcel.do'/>?"+param;
	}
	
	function setChartBtn(change) {
		if($("#factCode").val() == "all") {
			$("#chart").hide();
			return;
		}
		
		if(change == true) {
			$("#chart").hide();
		} else {
			var gubun = $(":radio[name=gubun]:checked").val();
			if((gubun == 3 && $("#month").val() == "all") || ($("#quarter").val() == "all" && gubun == 2)  || ($("#day").val() =="all" && gubun==4))
				$("#chart").show();
			else
				$("#chart").hide();
		}
	}
	
	function chart_popup() {
		var sysKind = $("#system").val();
		var sugye = $("#sugye").val();
		var riverDiv = $("#sugye").val();
		
		var searchDate = "";
		var itemCode = "";
		var gubun = $(":radio[name=gubun]:checked").val();
		var statsDiv = "D";
		var isCompare = "N";
		
		if($("#isCompare").is(":checked")) {
			isCompare = "Y";
		}
		
		var year = $("#year").val();
		var quarter = $("#quarter").val();
		var month = $("#month").val();
		var day = $("#day").val();
		
		var paramMonth = "";
		var paramQuarter = "";
		var paramDay = "";
		
		if(gubun == 1) {
			searchDate = year;
			statsDiv = "Y";
			paramMonth = "";
			paramQuarter = "";
		} else if(gubun == 2) {
			searchDate = year;
			statsDiv = "Q" + quarter;
			if(quarter != "all") {
				paramQuarter = "";
				paramMonth = "";
			} else {
				statsDiv = "Q";
				paramQuarter = "all";
				paramMonth = "";
			}
		} else if(gubun == 3) {
			searchDate = year + month;
			statsDiv = "M";
			
			if(month != "all") {
				paramQuarter = "";
				paramMonth = "";
			} else {
				searchDate = year;
				paramQuarter = "";
				paramMonth = "all";
			}
		} else if(gubun == 4) {
			searchDate = year + month + day;
			statsDiv = "D";
			
			if(day != "all") {
				paramDay = "";
			} else {
				searchDate = year+month;
				paramDay = "all";
			}
		}
		
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 546;
		var winWidth = 642;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		var param = "sysKind=" + sysKind +
					"&sugye=" + sugye +
					"&riverDiv=" + riverDiv +
					"&factCode=" + $("#factCode").val() +
					"&month=" + paramMonth +
					"&quarter=" + paramQuarter +
					"&day=" + paramDay +
					"&startDate=" + searchDate +
					"&gubun=" + gubun +
					"&statsDiv="+statsDiv+
					"&width=" + (winWidth-40) +
					"&height=" + (winHeight-40);
					
		window.open("<c:url value='/stats/goStatsBasinGraph.do'/>?"+encodeURI(param),
				'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
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
						
						<!-- 유역별 통계 검색 -->
						<form action="" onsubmit="return false">
						
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select class="fixWidth7" id="sugye" name="sugye">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
<!-- 									<span style="display:none">&gt;</span> -->
<!-- 										<select class="fixWidth11" id="factCode" name="factCode" disabled="disabled" style="background:#e9e9e9;display:none;" > -->
<!-- 											<option value="none">선택</option> -->
<!-- 										</select> -->
<!-- 									<span style="display:none">&gt;</span> -->
<!-- 									<select style="display:none" class="fixWidth11" id="branchNo" name="branchNo" style="background:#e9e9e9;display:none;" > -->
<!-- 										<option value="1">제 1 측정소</option> -->
<!-- 									</select> -->
								</li>
								<li style="display:none;">
									<select class="fixWidth13" id="system" name="system" disabled="disabled" style="background:#e9e9e9;">
										<option value="U" selected="selected">이동형측정기기</option>
<!--										<option value="T">탁수모니터링</option> -->
<!--										<option value="A">국가수질자동측정망</option> -->
									</select>
								</li>
								<li>
									<span class="fieldName">구분</span>
									<input type="radio" class="inputRadio" id="" name="gubun" value="1" checked="checked" /><label for="">년간</label>
									<input type="radio" class="inputRadio" id="" name="gubun" value="2" /><label for="">분기</label>
									<input type="radio" class="inputRadio" id="" name="gubun" value="3" /><label for="">월간</label>
									<input type="radio" class="inputRadio" id="" name="gubun" value="4" /><label for="">일간</label>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<select id="year" name="year" style="width:80px;"><option>2010년</option></select>
									<select id="quarter" name="quarter" style="width:60px;">
										<option value="all">전체</option>
										<option value="1">1분기</option>
										<option value="2">2분기</option>
										<option value="3">3분기</option>
										<option value="4">4분기</option>
									</select>
									<select id="month" name="month" style="width:60px;"><option>12월</option></select>
									<select id="day" name="day" style="width:60px;"><option>30일</option></select>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:search_data();" alt="조회하기" style="float:right;"/>
						</div>
						</form>
						<!-- //유역별 통계 검색 -->
						
						<div id="btArea">
							<span id="statTitle"></span>
							<input type="button" id="btnChart" name="btnChart"  class="btn btn_basic" onclick="javascript:chart_popup();" style="display:none" />
							<input type="button" id="btnExcel" name="btnExcel"  class="btn btn_excel" onclick="javascript:excel_down();" />
						</div>
						
						<div class="table_wrapper">
							<div id="overBox" class="overBox" style="overflow:auto; max-height:610px;">
								<table id="dataTable" class="dataTable" style="width: 1500px;">
									<colgroup>
										<col />
										<col width="85" />
										<col width="120" />
										<col width="85" />
										<col />
										<col />
										<col />
										<col />
										<col />
										<col />
										<col />
										<col />
									</colgroup>
									<thead id="dataHeader">
										<tr>
											<th scope="col" rowspan="2">지역</th>
											<th scope="col" rowspan="2">기간</th>
											<th scope="col" rowspan="2">시스템</th>
											<th scope="col" rowspan="2">측정소</th>
											<th scope="col" rowspan="2">수신율</th>
											<th scope="col" colspan="3">탁도(NTU)</th>
											<th scope="col" colspan="3">수온(℃)</th>
											<th scope="col" colspan="3">pH</th>
											<th scope="col" colspan="3">DO(mg/L)</th>
											<th scope="col" colspan="3">EC(mS/cm)</th>
											<th scope="col" colspan="3">Chl-a(μg/L)</th>
										</tr>
										<tr>
											<th scope="col">최대</th>
											<th scope="col">평균</th>
											<th scope="col">최소</th>
											<th scope="col">최대</th>
											<th scope="col">평균</th>
											<th scope="col">최소</th>
											<th scope="col">최대</th>
											<th scope="col">평균</th>
											<th scope="col">최소</th>
											<th scope="col">최대</th>
											<th scope="col">평균</th>
											<th scope="col">최소</th>
											<th scope="col">최대</th>
											<th scope="col">평균</th>
											<th scope="col">최소</th>
											<th scope="col">최대</th>
											<th scope="col">평균</th>
											<th scope="col">최소</th>
										</tr>
									</thead>
									<tbody id="statsBody">
									</tbody>
								</table>
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