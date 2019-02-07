<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : statsSituSpread.jsp
	 * Description : 상황전파통계 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * ----------	--------	---------------------------
	 * 2013.10.20	lkh			 리뉴얼
	 * 2014.10.28  mypark 	검색 개선
	 * 
	 * author lkh
	 * since 2013.10.31
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
		//=============================	 달 력  End	======================================
		
		$('#search').click(function () {
			//search_data();
		});
		
		$('#chart').click(function () {
			//chart_popup();
		});
		
		$('#excel').click(function () {
			//excel_down();
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
			setChartBtn(true);
			adjustBranchDropDown();
		});
		
// 		$('#branchNo').change(function(){
// 			adjustItemList();
// 		});
		
		$(":radio[name='gubun']")
		.click(function(){
			var gubun = $(":radio[name=gubun]:checked").val();
			if(gubun == 1) {
				$("#gubunDt").show();
				$("#gubunDd").show();
				//$("#dayDt").hide();
				$("#dayDd").hide();
				
				$("#year").show();
				$("#quarter").hide();
				$("#month").hide();
				$("#day").hide();
			} else if(gubun == 2) {
				$("#gubunDt").show();
				$("#gubunDd").show();
				//$("#dayDt").hide();
				$("#dayDd").hide();
				
				$("#year").show();
				$("#quarter").show();
				$("#month").hide();
				$("#day").hide();
			} else if(gubun == 3) {
				$("#gubunDt").show();
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
				$("#gubunDt").hide();
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
	
	var firstFlag = true;
	
	function init() {
		if(firstFlag) {
			search_data();
			firstFlag = false;
		}
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

		setChartBtn();

		var sysKind = $("#system").val();
		var searchDate = "";
		var gubun = $(":radio[name=gubun]:checked").val();				
		var statsDiv     = "";
		var year         = $("#year").val();
		var quarter      = $("#quarter").val();
		var month        = $("#month").val();
		var startDate    = $("#startDate").val();
		var endDate      = $("#endDate").val();
		var paramMonth   = "";
		var paramQuarter = "";
		var paramDay     = "";
		
		
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

		$.ajax({
			type:"post",
			url:"/stats/getSituSpread.do",
			data:{
					sysKind:$("#system").val(), 
					factCode:$("#factCode").val(), 
					branchNo:$("#branchNo").val(), 
					riverDiv:$("#sugye").val(),
					searchDate:searchDate, 
					month:paramMonth,
					quarter:paramQuarter,
					gubun:gubun,
					startDate:startDate,
					endDate:endDate,
					statsDiv:statsDiv},
			dataType:"json",
			success:function(result){
	               var tot = result['data'].length;
	               item = "";

	               $("#statsBody").html("");

	               if( tot <= "0" ){
	               	$("#statsBody").html("<tr><td colspan='6'>조회 결과가 없습니다</td></td>");	   
	                closeLoading();  
	               } else {             
	                for(var j=0; j < tot; j++){
	                    var obj = result['data'][j];

	    				var item = "<tr id='rowIdx"+j+"'>";
	    				
	    				// SMS 발송 상세 페이지 이동을 위한 파라미터
		    			var pSystem = $("#system").val();
		    			var pSugye = obj.riverDiv;
		    			var pFactCode = obj.factCode;
		    			var pBranchNo = obj.branchNo;
		    			var pStartDate = null;
		    			var pEndDate = null;

	    				if(gubun == 1) {
		    			    item += "<td>" + year + "년</td>";
		    			    pStartDate = year + '/01/01';
		    			    pEndDate = year + '/12/31'; 
	    				} else if(gubun == 2) {
	   					 	item += "<td>"+obj.year + "년 " + obj.quarter+"</td>";
	   					 	
	   					 	if($("#quarter").val() == 1) {
	   					 		pStartDate = obj.year + '/01/01';
	   					 		pEndDate = obj.year + '/03/31';
	   					 	} else if($("#quarter").val() == 2) {
	   					 		pStartDate = obj.year + '/04/01';
	   					 		pEndDate = obj.year + '/06/30';
	   					 	} else if($("#quarter").val() == 3) {
	   					 		pStartDate = obj.year + '/07/01';
	   					 		pEndDate = obj.year + '/09/30';
	   					 	} else {
	   					 		pStartDate = obj.year + '/10/01';
	   					 		pEndDate = obj.year + '/12/31';
	   					 	}
	   					 	
	    				} else if(gubun == 3) {
	    					item += "<td>"+obj.year + "년 " + obj.startMonth+"월</td>";
	    					
	    					pStartDate = obj.year + '/' + obj.startMonth + '/01';
	  					 		pEndDate = obj.year + '/' + obj.startMonth 
	  					 			+ '/' + new Date(obj.year, obj.startMonth, '').getDate();
	    				} else {
		    				item += "<td>"+obj.day+"</td>";
		    				
		    				pStartDate = $('#startDate').val();
	  					 	pEndDate   = $('#endDate').val();
	    				}
	    				
	    				//openSmsDetail(pSystem, pSugye, pFactCode, pBranchNo, pStartDate, pEndDate,
	    				
	    				item += "<td>" + obj.riverName + "</td>";			    				
	    				item += "<td>" + obj.regName + "</td>";			    				
	    				item += "<td>" + obj.branchName + "</td>";			    				
	    				item += "<td><a href=\"javascript:openSmsDetail('" + pSystem + "','" + pSugye + "' ,'"  
	    						+ pFactCode + "' ,'" + pBranchNo + "' ,'" + pStartDate + "' ,'" + pEndDate
	    						+ "', 'SMS');\">" + obj.smsCnt + "</td>";			    				
	    				item += "<td><a href=\"javascript:openSmsDetail('" + pSystem + "','" + pSugye + "' ,'"  
	    						+ pFactCode + "' ,'" + pBranchNo + "' ,'" + pStartDate + "' ,'" + pEndDate
	    						+ "', 'ACS');\">" + obj.acsCnt + "</td>";			    				
	                    
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
		var sysKind		= $("#system").val();
		var searchDate	= "";
		var itemCode	= "";
		var gubun		= $(":radio[name=gubun]:checked").val();
		var statsDiv	= "";
		var year		= $("#year").val();
		var quarter		= $("#quarter").val();
		var month		= $("#month").val();
		var startDate	= $("#startDate").val();
		var endDate		= $("#endDate").val();
		var paramMonth	= "";
		var paramQuarter = "";
		var paramDay	 = "";
		
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
			endDate	= endDate.split('/').join('');
			statsDiv = "D";
		}
		
		var param = "sysKind="		 + sysKind +
					"&searchDate="	 + searchDate +
					"&factCode="	 + $("#factCode").val() +
					"&branchNo="	 + $("#branchNo").val() +
					"&riverDiv="	 + $("#sugye").val() +
					"&gubun="		 + gubun +
					"&statsDiv="	 + statsDiv +
					"&quarter="		 + paramQuarter + 
					"&month="		 + paramMonth + 
					"&day="			 + paramDay+
					"&searchYear="	 + year + 
					"&searchMonth="	 + month +
					"&startDate="	 + startDate +
					"&endDate="		 + endDate +
					"&searchQuarter=" + quarter;
	
		location.href="<c:url value='/stats/getSituSpreadExcel.do'/>?"+param;
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
			
			if(($("#factCode").val() != "all") && ((gubun == 3 && $("#month").val() == "all") || ($("#quarter").val() == "all" && gubun == 2) || ($("#day").val() =="all" && gubun==4)))
				$("#chart").show();
			else
				$("#chart").hide();
		}
	}
	
	// 차트는 사용하지 않는듯 보여, parameter 보내주는 부분만 수정하였음.
	// 차트를 사용한다면, 추후, 차트팝업에서 소스 수정해야함
	function chart_popup()
	{
		var sysKind		= $("#system").val();
		var riverDiv	= $("#sugye").val();
		var searchDate	= "";
		var itemCode	 = "";
		var gubun		= $(":radio[name=gubun]:checked").val();
		var statsDiv	 = "";	
		var year		 = $("#year").val();
		var quarter	  = $("#quarter").val();
		var month		= $("#month").val();
		var startDate	= $("#startDate").val();
		var endDate	  = $("#endDate").val();
		var paramMonth	= "";
		var paramQuarter = "";
		var paramDay	 = "";
		
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
			endDate	= endDate.split('/').join('');
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
		
		var param = "sysKind="		+ sysKind +
					"&searchDate="	+ searchDate +
					"&factCode="	+ $("#factCode").val() +
					"&branchNo="	+ $("#branchNo").val() +
					"&riverDiv="	+ riverDiv +
					"&gubun="		+ gubun +
					"&statsDiv="	+ statsDiv +
					"&quarter="		+ paramQuarter +
					"&month="		+ paramMonth +
					//"&day="		+ paramDay +
					"&startDate="	+ startDate +
					"&endDate="		+ endDate +
					"&statsKind=2"	+
					"&width="		+ (winWidth-40) +
					"&height="		+ (winHeight-40);
		
		window.open("<c:url value='/stats/goStatsGraph.do'/>?"+encodeURI(param), 
				'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	/**
	* SMS상세 페이지(alertList.jsp)를 오픈한다.
	*	
	* @param system 시스템구분
	* @param sugye 수계
	* @param factCode 사업소
	* @param branchNo 사업소 지사
	* @param startDate 조회 시작일
	* @param endDate 조회 종료일
	* @param type 전파유형 SMS, ACS 
	*/
	function openSmsDetail(system, sugye, factCode, branchNo, startDate, endDate, type) {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 700;
		var winWidth = 1080;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		var param = "system=" + system +
					"&sugye="+ sugye +
					"&factCode="+ factCode +
					"&branchNo="+ branchNo +
					"&startDate="+ startDate +
					"&endDate="+ endDate +
					"&type="+ type +
					"&isPopup=Y" +
					"&clickMenu=32210";
		
		window.open("<c:url value='/alert/alertPopupList.do'/>?"+encodeURI(param), 
				'SmsDetail','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=auto,resizable=yes,left='+winLeftPost+',top='+winTopPost);
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
										<span class="fieldName">시스템</span>
										<select class="fixWidth13" id="system" name="system">
												<option value="U" selected="selected">이동형측정기기</option>
												<!-- <option value="T">탁수모니터링</option> -->
												<option value="A">국가수질자동측정망</option>
										</select>
									</li>
									<li>
										<span class="fieldName">측정소 위치</span>
										<select class="fixWidth7" id="sugye" name="sugye">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
										<select class="fixWidth11" id="factCode" name="factCode" style="display:none;">
											<option value="all">전체</option>
										</select>
										<span id="spanBranch">&gt;</span>
										<select class="fixWidth11" id="branchNo" name="branchNo">
											<option value="1">제 1 측정소</option>
										</select>
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
										<option value="1">1분기</option>
										<option value="2">2분기</option>
										<option value="3">3분기</option>
										<option value="4">4분기</option>
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
						
						<div class="table_wrapper">
							<!-- 유역별 통계 현황 -->
							<div class="table_wrapper">
								<div class="overBox" style="overflow:auto; max-height:594px;">
									<table class="dataTable">
										<colgroup>
											<col/>
											<col/>
											<col/>
											<col/>
											<col/>
											<col/>
										</colgroup>
										<thead>
											<tr>
												<th rowspan="2" scope="col">기간</th>
												<th rowspan="2" scope="col">수계</th>
												<th rowspan="2" scope="col">지역</th>
												<th rowspan="2" scope="col">측정소</th>
												<th colspan="2" scope="col">상황 전파</th>
											</tr>
											<tr>
												<th scope="col">SMS</th>
												<th scope="col">ACS</th>
											</tr>
										</thead>
										<tbody id="statsBody">
										</tbody>
									</table>
								</div>
							</div>
							<!-- //유역별 통계 현황 -->
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