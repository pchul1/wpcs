<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : statsSituOc.jsp
	 * Description : 상황발생 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2013.10.20	lkh			리뉴얼
	 * 2014.10.28  mypark 	검색 개선
	 * 
	 * author lkh
	 * since 2013.10.31
	 * 
	 * Copyright (C) 2013 by lkh  All right reserved.
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

<%
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
%>

<script type="text/javascript">
//<![CDATA[
	$(function () {
		//============================= 달 력  Start ======================================
		var startDate = '<%=startDate%>';
		var endDate = '<%=endDate%>';
		selectedSugyeInMemberId(user_riverid , "sugye");
		/*shows the loading div every time we have an Ajax call*/
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
		//============================= 달 력  End ======================================
		
		$("#quarter").change(function() {
			setChartBtn(true);
		});
		
		$("#month").change(function() {
			setChartBtn(true);
		});
		
		$("#day").change(function() {
			setChartBtn(true);
		});
		
		$('#system').change(function(){
			adjustGongku();
			
			if($(this).val() == "A" || $(this).val() == "all")
				$("#itemBox").attr("class", "rows2");
			else
				$("#itemBox").attr("class", "rows1");
		
		});
		
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchDropDown();
		});
		
		$('#branchNo').change(function(){
			adjustItemList();
		});
		
		$(":radio[name=ocDiv]").click(function(){
			adjustSearch();
		});
		
		$(":radio[name=ocPointDiv]").click(function(){
			adjustSearch();
		});
		
		$(":radio[name=gubun]")
		.click(function(){
			var gubun = $(":radio[name=gubun]:checked").val();
			if(gubun == 1) {
				//$("#gubunDt").show();
				$("#gubunDd").show();
				//$("#dayDt").hide();
				$("#dayDd").hide();
				
				$("#year").show();
				$("#quarter").hide();
				$("#month").hide();
				$("#day").hide();
			} else if(gubun == 2) {
				//$("#gubunDt").show();
				$("#gubunDd").show();
				//$("#dayDt").hide();
				$("#dayDd").hide();
				
				$("#year").show();
				$("#quarter").show();
				$("#month").hide();
				$("#day").hide();
			} else if(gubun == 3) {
				//$("#gubunDt").show();
				$("#gubunDd").show();
				//$("#dayDt").hide();
				$("#dayDd").hide();
				
				$("#year").show();
				$("#quarter").hide();
				$("#month").show();
				$("#day").hide();
				setMonth(true);
			}
			else if(gubun == 4) {
				$("#year").hide();
				$("#quarter").hide();
				$("#month").hide();
				$("#day").hide();
				
				//$("#gubunDt").hide();
				$("#gubunDd").hide();
				//$("#dayDt").show();
				$("#dayDd").show();
			}
		});
		
		$("#year").show();
		$("#quarter").hide();
		$("#month").hide();
		$("#day").hide();
		//$("#dayDt").hide();
		$("#dayDd").hide();
		
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
		
		for(var i=0; i<31; i++) {
			var tmp = addzero(i+1);
			dArr.push({CAPTION:tmp+"일",VALUE:tmp});
		}
		$('#day').loadSelect(dArr);
		$('#day').attr('value', addzero(today.getDate()));
		
		adjustGongku();
		
		
	});
	
	//시스템 경보, 사고접수, 임의지점, 특정지점에 따른 검색조건 변화
	function adjustSearch()
	{
		var ocDiv = $(":radio[name=ocDiv]:checked").val();
		var ocPointDiv = $(":radio[name=ocPointDiv]:checked").val();
		
		var searchLocation = $("#searchLocation");
		var searchFact = $("#searchFact");
		var searchSys = $("#searchSys");
		
		if(ocDiv == "SYS")
		{
			searchLocation.hide();
			searchFact.show();
			searchSys.show();
		}else if(ocDiv == "REG")
			searchLocation.show();
		
		if(ocDiv == "REG" && ocPointDiv == "P"){
			searchFact.show();
			searchSys.show();
		}else if(ocDiv == "REG" && ocPointDiv == "T"){
			searchFact.hide();
			searchSys.hide();
		}
	}
	
	//테이블 헤더 생성
	function makeHeader(ocDiv, ocPointDiv, sys)
	{
		if(ocDiv == null)
			ocDiv = $(":radio[name=ocDiv]:checked").val();
		
		if(ocPointDiv == null)
			ocPointDiv = $(":radio[name=ocPointDiv]:checked").val();
		
		if(sys == null)
			sys = $("#system").val();
			
		var header;
		var overBox = $("#overBox");
		
		overBox.html("");
		
		var table = "<table class='dataTable' id='dataTable'>"
						+ "<colgroup>"
						+ "<col />"
						+ "<col width='120'/>"
						+ "<col width='85'/>"
						+ "<col />"
						+ "<col />"
						+ "<col />"
						+ "<col />"
						+ "<col />"
						+ "</colgroup>"
						+ "<thead id='dataHeader'>"
						+ "</thead>"
						+ "<tbody id='statsBody'>"
						+ "</tbody>"
						+ "</table>";
					
		overBox.html(table);
		
		$("#dataTable").attr("class", "");
		$("#dataTable").attr("class", "dataTable");
		
		if(ocDiv == "SYS")
		{
			$("#dataTable").css("width", "100%");
		}
		else if(ocDiv=="REG")
		{
			$("#dataTable").css("width", "1900px");
		}
		
		//헤더 생성
		$("#dataHeader").html("");
		header = "<tr>"
				+ "<th rowspan ='2' scope='col'>기간</th>"
				+ "<th rowspan ='2' scope='col'>수계</th>"
				+ "<th rowspan ='2' scope='col'>지역</th>";
				
		if(ocDiv == "SYS" || (ocPointDiv != "T" && ocDiv == "REG"))	//임의지점일때만 측정소 표시 안함
			header += "<th rowspan ='2' scope='col'>측정소</th>";
			
		if(ocDiv == "SYS" && sys == "T")
		{
			header += "<th colspan='4' scope='col'>경보 유형</th>";
			header += "</tr><tr>";
			header += "<th>최초</th>";
			header += "<th>3시간</th>";
			header += "<th>6시간</th>";
			header += "<th>12시간이상</th>";
			header += "</tr>";
			
		}
		else if(ocDiv == "SYS" && sys != "T")
		{
			header += "<th colspan='4' scope='col'>경보 단계</th>";
			header += "</tr><tr>";
			header += "<th>관심</th>";
			header += "<th>주의</th>";
			header += "<th>경계</th>";
			header += "<th>심각</th>";
			header += "</tr>";
		}
		else if(ocDiv == "REG")
		{
			header += "<th colspan='13' scope='col'>사고 유형</th>";
			header += "</tr><tr>";
			header += "<th>오탁수발생</th>";
			header += "<th>준설장비용출</th>";
			header += "<th>준설장비전복</th>";
			header += "<th>선박사고</th>";
			header += "<th>선박페인트</th>";
			header += "<th>탱크로리</th>";
			header += "<th>홍수기</th>";
			header += "<th>취정수장</th>";
			header += "<th>유류유출</th>";
			header += "<th>페놀</th>";
			header += "<th>유해물질</th>";
			header += "<th>물고기폐사</th>";
			header += "<th>기타사항</th>";
			header += "</tr>";
		}
		
		$("#dataHeader").append(header);
		//$("#dataList").html("<tr><td colspan='"+(itemCnt + 6)+"'>데이터를 불러오는 중 입니다.</td></tr>");
	}
	
	var firstFlag = true;
	
	function init() {
		
		if(firstFlag) {
			search_data();
			firstFlag = false;
		}
	}
	
	function setMonth(isAll)
	{
		var today = new Date(); 
		
		var mArr = new Array();
		
		if(isAll == true)
			mArr.push({CAPTION:"전체",VALUE:"all"});
		
		for(var i=0; i<12; i++) {
			var tmp = addzero(i+1);
			mArr.push({CAPTION:tmp+"월",VALUE:tmp});
		}
		$('#month').loadSelect(mArr);
		$('#month').attr('value', addzero(today.getMonth()+1));
	}
	
	function search_data(){

		showLoading();

		makeHeader();

		setChartBtn();
		
		var sysKind 		= $("#system").val();	
		var searchDate 		= "";
		var gubun 			= $(":radio[name=gubun]:checked").val();				
		var statsDiv 		= "D";
		var ocDiv 			= $(":radio[name=ocDiv]:checked").val();		
	    var ocPointDiv 		= $(":radio[name=ocPointDiv]:checked").val();
	    var sys 			= $("#system").val();
		var year 			= $("#year").val();
		var quarter 		= $("#quarter").val();
		var month 			= $("#month").val();
		var startDate    	= $("#startDate").val();
		var endDate      	= $("#endDate").val();       
		var paramMonth 		= "";
		var paramQuarter 	= "";
		var paramDay 		= "";
		
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
			startDate = startDate.split('/').join('');
			endDate   = endDate.split('/').join('');
			
			statsDiv = "D";
							
			$("#statTitle").text("[ "+ $("#startDate").val()+" 부터 "+ $("#endDate").val() + " 까지  통계 ]");	
		}

		$("#statTitle").append("<span class='noticeSpan1'> ※조회결과는 확정자료가 아닙니다.</span>");

		$.ajax({
			type:"post",
			url:"/stats/getSituOC.do",
			data:{
					sysKind:$("#system").val(), 
					factCode:$("#factCode").val(), 
					branchNo:$("#branchNo").val(), 
					searchDate:searchDate,
					startDate:startDate,
					endDate:endDate, 
					month:paramMonth,
					quarter:paramQuarter,
					gubun:gubun,
					ocDiv:ocDiv,
					ocPointDiv:ocPointDiv,
					statsDiv:statsDiv},
			dataType:"json",
			success:function(result){
	               var tot = result['data'].length;


	               item = "";

	               $("#statsBody").html("");

	               if( tot <= "0" ){
	                
	      				if(ocDiv == "SYS")
	               		$("#statsBody").html("<tr><td colspan='8'>조회 결과가 없습니다</td></td>");	   
	      				else if(ocDiv == "REG" || ocPointDiv == "T")
	               		$("#statsBody").html("<tr><td colspan='16'>조회 결과가 없습니다</td></td>");	   
	      				else if(ocDiv == "REG" || ocPointDiv == "P")
	               		$("#statsBody").html("<tr><td colspan='17'>조회 결과가 없습니다</td></td>");	   
	          				
	               	
	                closeLoading();  
	               } else {             
	                for(var j=0; j < tot; j++){
	                    var obj = result['data'][j];

	    				var item = "<tr id='rowIdx"+j+"'>";

	    				if(gubun == 1)
		    			    item += "<td>" + year + "년</td>";
		    			else if(gubun == 2)
	   					 	item += "<td>"+obj.year + "년 " + obj.quarter+"</td>";
	   					else if(gubun == 3)
	    					item += "<td>"+obj.year + "년 " + obj.startMonth+"월</td>";
	    				else
		    				item += "<td>"+obj.day+"</td>";

	    				item += "<td>" + obj.riverName + "</td>";			    				

	    				//지역 표시(임의지점일 때만 statArea로 표시)
	    				if(ocPointDiv == "T" && ocDiv == "REG")
			    			item += "<td>" + obj.statsArea + "</td>";
		    			else
		    				item += "<td>" + obj.regName + "</td>";			    	

	    				if(ocDiv == "SYS" || (ocPointDiv != "T" && ocDiv == "REG"))	//임의지점일때만 측정소 표시 안함			
		    				item += "<td>" + obj.branchName + "</td>";								    					    						   
		    				

	    				if(ocDiv == "SYS" && sys == "T")
						{
	    					item += "<td>" + obj.firstCnt + "</td>";			    				
	    					item += "<td>" + obj.time3Cnt + "</td>";			    				
	    					item += "<td>" + obj.time6Cnt + "</td>";			    				
	    					item += "<td>" + obj.time12Cnt + "</td>";			    				
						}
						else if(ocDiv == "SYS" && sys != "T")
						{
	    					item += "<td>" + obj.atnCnt + "</td>";			    				
	    					item += "<td>" + obj.catCnt + "</td>";			    				
	    					item += "<td>" + obj.alertCnt + "</td>";			    				
	    					item += "<td>" + obj.srsCnt + "</td>";			    												
						}
						else if(ocDiv == "REG")
						{
							item += "<td>" + obj.dmwtrCnt + "</td>";			    				
	    					item += "<td>" + obj.equEltnCnt + "</td>";			    				
	    					item += "<td>" + obj.equRollCnt + "</td>";			    				
	    					item += "<td>" + obj.shipCnt + "</td>";			  
	    					item += "<td>" + obj.shipPntCnt + "</td>";			  
	    					item += "<td>" + obj.tanktrCnt + "</td>";			  
	    					item += "<td>" + obj.fldssnCnt + "</td>";			  
	    					item += "<td>" + obj.ifplntCnt + "</td>";			  
	    					item += "<td>" + obj.oilCnt + "</td>";			  
	    					item += "<td>" + obj.phenolCnt + "</td>";			  
	    					item += "<td>" + obj.toxicCnt + "</td>";			  
	    					item += "<td>" + obj.fshdieCnt + "</td>";			  
	    					item += "<td>" + obj.etcCnt + "</td>";			  
						}	
								
	    				 				
	                    
	    				item += "</tr>"; 

	       				$("#statsBody").append(item);

	       			 	$("#rowIdx"+j+"  td").each(function(){
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
		var sysKind			= $("#system").val();
		var searchDate		= "";
		var gubun			= $(":radio[name=gubun]:checked").val();
		var statsDiv		= "D";
		var ocDiv			= $(":radio[name=ocDiv]:checked").val();
		var ocPointDiv		= $(":radio[name=ocPointDiv]:checked").val();
		var sys				= $("#system").val();
		var year			= $("#year").val();
		var quarter			= $("#quarter").val();
		var month			= $("#month").val();
		var startDate		= $("#startDate").val();
		var endDate			= $("#endDate").val();
		var paramMonth		= "";
		var paramQuarter	= "";
		var paramDay		= "";
		
		if(gubun == 1) {
			searchDate = year;
			statsDiv = "Y";
			paramMonth = "";
			paramQuarter = "";
		} else if(gubun == 2) {
			searchDate = year;
			statsDiv = "Q" + quarter;
			if(quarter != "all")
			{
				paramQuarter = "";
				paramMonth = "";
			}
			else
			{
				statsDiv = "Q";
				paramQuarter = "all";
				paramMonth = "";
			}
		} else if(gubun == 3) {
			searchDate = year + month;
			statsDiv = "M";
			
			if(month != "all")
			{
				paramQuarter = "";
				paramMonth = "";
			}
			else
			{
				searchDate = year;
				paramQuarter = "";
				paramMonth = "all";
			}
		} else if(gubun == 4) {
			startDate = startDate.split('/').join('');
			endDate = endDate.split('/').join('');
			
			statsDiv = "D";
		}
		
		var param = "sysKind=" + sysKind +
					"&searchDate="+searchDate+
					"&startDate="+startDate+
					"&endDate="+endDate+
					"&factCode="+ $("#factCode").val() +
					"&branchNo="+ $("#branchNo").val() +
					"&gubun="+gubun+
					"&statsDiv="+statsDiv+
					"&quarter=" + paramQuarter + 
					"&month=" + paramMonth + 
					"&day=" + paramDay+
					"&ocDiv=" + ocDiv +
					"&ocPointDiv=" + ocPointDiv +
					"&searchYear=" + year + 
					"&searchMonth="  + month +
					"&searchQuarter=" + quarter;
		
		location.href="<c:url value='/stats/getSituOCExcel.do'/>?"+param;
	}
	
	function setChartBtn(change)
	{
		if(change == true)
		{
			$("#chart").hide();
		}
		else
		{
			var gubun = $(":radio[name=gubun]:checked").val();
			
			if((gubun == 3 && $("#month").val() == "all") || ($("#quarter").val() == "all" && gubun == 2)  || ($("#day").val() =="all" && gubun==4))
				$("#chart").show();
			else
				$("#chart").hide();
		}
	}
	
	function chart_popup()
	{
		var sysKind			= $("#system").val();
		var searchDate		= "";
		var gubun			= $(":radio[name=gubun]:checked").val();
		var statsDiv		= "D";
		var ocDiv			= $(":radio[name=ocDiv]:checked").val();
		var ocPointDiv		= $(":radio[name=ocPointDiv]:checked").val();
		var sys				= $("#system").val();
		var year			= $("#year").val();
		var quarter			= $("#quarter").val();
		var month			= $("#month").val();
		var startDate		= $("#startDate").val();
		var endDate			= $("#endDate").val();
		var paramMonth		= "";
		var paramQuarter	= "";
		var paramDay		= "";
		
		if(gubun == 1) {
			searchDate = year;
			statsDiv = "Y";
			paramMonth = "";
			paramQuarter = "";
		} else if(gubun == 2) {
			searchDate = year;
			statsDiv = "Q" + quarter;
			if(quarter != "all")
			{
				paramQuarter = "";
				paramMonth = "";
			}
			else
			{
				statsDiv = "Q";
				paramQuarter = "all";
				paramMonth = "";
			}
		} else if(gubun == 3) {
			searchDate = year + month;
			statsDiv = "M";
			
			if(month != "all")
			{
				paramQuarter = "";
				paramMonth = "";
			}
			else
			{
				searchDate = year;
				paramQuarter = "";
				paramMonth = "all";
			}
		} else if(gubun == 4) {
			startDate = startDate.split('/').join('');
			endDate = endDate.split('/').join('');
			
			statsDiv = "D";
		}
		
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 516;
		var winWidth = 642;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		var param = "sysKind=" + sysKind +
						  "&searchDate="+searchDate+
						  "&startDate="+startDate+
						  "&endDate="+endDate+
						  "&factCode="+ $("#factCode").val() +
						  "&branchNo="+ $("#branchNo").val() +
						  "&gubun="+gubun+
						  "&statsDiv="+statsDiv+
						  "&quarter=" + paramQuarter + 
						  "&month=" + paramMonth +
						  "&ocDiv=" + ocDiv +
						  "&ocPointDiv=" + ocPointDiv +
						  "&statsKind=3" +
						  "&width=" + (winWidth-40) + 
						  "&height=" + (winHeight-40);
		
		window.open("<c:url value='/stats/goStatsGraph.do'/>?"+encodeURI(param), 
				'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
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
	

	function adjustGongku()
	{
		var sugyeCd = $('#sugye').val();
		var sys_kind = 'U';
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		if( sugyeCd == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
			//dropDownSet.emptySelect();
		}else{
			$.getJSON("/waterpolmnt/waterinfo/getGongkuList.do",
					{sugye:sugyeCd, system:sys_kind}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					adjustBranchList();
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
			var url = "/waterpolmnt/waterinfo/getBranchList.do";
			$.getJSON(url, {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//console.log("결과:",data);
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_all(data.branch);
					init();
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
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
										<span class="fieldName">사고구분</span>
										<input type="radio" class="inputRadio" id="" name="ocDiv" value="SYS" checked="checked" /><label for="">시스템 경보</label>
										<input type="radio" class="inputRadio" id="" name="ocDiv" value="REG"/><label for="">사고 접수</label>
									</li>
									<li id="searchSys">
										<span class="fieldName">시스템</span>
										<select class="fixWidth13" id="system" name="system">
												<option value="U" selected="selected">이동형측정기기</option>
												<!-- <option value="T">탁수모니터링</option> -->
												<option value="A">국가수질자동측정망</option>
										</select>
									</li>
									<li id="searchFact">
										<span class="fieldName">측정소 위치</span>
										<select class="fixWidth7" id="sugye" name="sugye">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
										<span id='spanFact'  style="display:none">&gt;</span>
										<select class="fixWidth11" id="factCode" name="factCode"  style="display:none">
											<option value="none">선택</option>
										</select>
										<span  id='spanBranch'>&gt;</span>
										<select class="fixWidth11" id="branchNo" name="branchNo">
											<option value="1">제 1 측정소</option>
										</select>
									</li>
									<li id="searchLocation" style="display:none">
<!--										<span>발생위치</span> -->
										<input type="radio" class="inputRadio" id="" name="ocPointDiv" value="T" checked="checked" /><label for="">임의지점</label>
										<input type="radio" class="inputRadio" id="" name="ocPointDiv" value="P"/><label for="">측정지점</label>
									</li>
									<li>
										<span class="fieldName">조회기간</span>
										<input type="radio" class="inputRadio" id="" name="gubun" value="1" checked="checked" /><label for="">년간</label>
										<input type="radio" class="inputRadio" id="" name="gubun" value="2" /><label for="">분기</label>
										<input type="radio" class="inputRadio" id="" name="gubun" value="3" /><label for="">월간</label>
										<input type="radio" class="inputRadio" id="" name="gubun" value="4" /><label for="">일간</label>
									</li>
									<li id="gubunDd">
										<select id="year" name="year" style="width:80px;"><option>2010년</option></select>
										<select id="quarter" name="quarter" style="width:60px;">
											<option value="all">전체</option>
											<option value="4">4분기</option>
											<option value="3">3분기</option>
											<option value="2">2분기</option>
											<option value="1">1분기</option>
										</select>
										<select id="month" name="month" style="width:60px;"><option>12월</option></select>
										<select id="day" name="day" style="width:60px;display:none"><option>30일</option></select>
									</li>
									<li id="dayDd">
										<input type="text" value="${searchVO.startDate}" id="startDate" name="startDate" size="13" onchange="commonWork()" alt="조회시작일"/>
										<span>~</span>
										<input type="text"value="${searchVO.endDate}" id="endDate" name="endDate" size="13" onchange="commonWork()" alt="조회종료일"/>
									</li>
								</ul>
							</div>
						</form>
						<!-- //유역별 통계 검색 -->
						
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:search_data();" alt="조회하기" style="float:right;"/>
						</div>
						<div id="btArea">
							<span id="statTitle"></span>
							<input type="button" id="chart" name="chart" value="그래프" class="btn btn_basic" onclick="javascript:chart_popup();" alt="그래프" style="display:none"/>
							<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excel_down();" alt="엑셀"/>
						</div>
						<!-- 유역별 통계 현황 -->
						<div class="table_wrapper_slick">
							<div id="overBox" class="overBox" style="overflow:auto; max-height:610px;">
								<table id="dataTable" class="dataTable">
									<colgroup>
										<col/>
										<col width="120"/>
										<col width="85"/>
										<col/>
										<col/>
										<col/>
										<col/>
										<col/>
									</colgroup>
									<thead id="dataHeader">
										<tr>
											<th scope="col" rowspan="2">기간</th>
											<th scope="col" rowspan="2">수계</th>
											<th scope="col" rowspan="2">지역</th>
											<th scope="col" rowspan="2">측정소</th>
											<th scope="col" colspan="4">경보 단계</th>
										</tr>
										<tr>
											<th>관심</th>
											<th>주의</th>
											<th>경계</th>
											<th>심각</th>
										</tr>
									</thead>
									<tbody id="statsBody">
									</tbody>
								</table>
							</div>
						</div>
						<!-- //유역별 통계 현황 -->
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