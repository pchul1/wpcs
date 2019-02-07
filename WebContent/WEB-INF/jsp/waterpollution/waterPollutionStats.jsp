<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : waterPollutionStats.jsp
	 * Description : 수질오염접수통계 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		 수정내용
	 * -------		--------	---------------------------
	 * 2013.04.30	YIK			최초 생성
	 * 2013.10.31	lkh			리뉴얼
	 * 
	 * author YIK
	 * since 2013.04.30
	 * 
	 * Copyright (C) 2013 by YIK All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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
<!--
	$(function(){
		//============================= 달 력  Start ======================================
		/*shows the loading div every time we have an Ajax call*/
		var startDate = '<%=startDate%>';
		var endDate = '<%=endDate%>';
		
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
		today2 = today2.getFullYear()+"/01/01" ;
		
		//var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
		//yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		//날짜 초기값 Setting
		if(startDate == 'null'){
			$("#startDate").val(today2);
		}
		if(endDate == 'null'){
			$("#endDate").val(today);
		}
		//============================= 달 력  End ======================================
		$('#search').click(function () {
			//dataLoad();
		});
		
		$('#registBtn').click(function () {
			fnRegist();
		});
		
		selectedSugyeInMemberId(user_riverid , "searchRiverDiv");
		dataLoad();
		
	}); 
	
	function dataLoad(){

		showLoading();
		
		var startDate    	= $("#startDate").val().split('/').join('')  ;
		var endDate      	= $("#endDate").val().split('/').join('');
		var searchRiverDiv  = $("#searchRiverDiv").val();
		var searchWpKind    = $("#searchWpKind").val();
		
		$.ajax({
			type:"post",
			url:"/waterpollution/getWaterPollutionStats.do",
			data:{
					startDate:startDate,
					endDate:endDate,
					searchRiverDiv:searchRiverDiv,
					searchWpKind:searchWpKind
			},
			dataType:"json",
			success:function(result){
	        	var tot = result['list'].length;
	            var item = "";
	            
	            $("#dataList").html("");
	
	            if( tot <= "0" ){
	                $("#dataList").html("<tr><td colspan='12'>조회 결과가 없습니다</td></td>");	   
	                closeLoading();  
	            }else{  
	                for(var i=0; i< tot; i++){
	                	var wpKind = '';
	                    var obj    = result['list'][i];                    
	
	                    if(obj.wpKind == 'PA'){
	                    	wpKind = '유류유출';
	                    }else if(obj.wpKind == 'PB'){
	                    	wpKind = '물고기폐사';
	                    }else if(obj.wpKind == 'PC'){
	                    	wpKind = '화학물질';
	                    }else if(obj.wpKind == 'PD'){
	                    	wpKind = '기타';
	                    }else{
	                    	wpKind = '소계';
	                    }
	
	                    if(i == 0){
	                    	item = "<tr>"							     			                   	 
	  			                 + "<td colspan='2' style='text-align: center; background-color: #E6FFFF;'>계</td>"
	               			     + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','','N','')\">"+obj.totalRcv+"</td>"
	               			     + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','','Y','')\">"+obj.totalSpt+"</td>"
	               			  	 + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','R01','N','')\">"+obj.r01Rcv+"</td>"
	            			     + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','R01','Y','')\">"+obj.r01Spt+"</td>"
	            			     + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','R02','N','')\">"+obj.r02Rcv+"</td>"
	            			     + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','R02','Y','')\">"+obj.r02Spt+"</td>"
	            			     + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','R03','N','')\">"+obj.r03Rcv+"</td>"
	            			     + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','R03','Y','')\">"+obj.r03Spt+"</td>"
	            			     + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','R04','N','')\">"+obj.r04Rcv+"</td>"
	            			     + "<td style='text-align: center; background-color: #E6FFFF; cursor:pointer;' onclick=\"fnGoList('total','R04','Y','')\">"+obj.r04Spt+"</td>"
	           		 		     + "</tr>";
	                    }else{
	 						if(obj.wpKind == '' || obj.wpKind == null){
	 							item = "<tr>"
									 + "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.statsYear+"</td>"
		                    		 + "<td style='text-align: center; background-color: #FFEAEA;'>"+wpKind+"</td>"
		              			     + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','','N','')\">"+obj.totalRcv+"</td>"
		              			     + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','','Y','')\">"+obj.totalSpt+"</td>"
		              			  	 + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R01','N','')\">"+obj.r01Rcv+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R01','Y','')\">"+obj.r01Spt+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R02','N','')\">"+obj.r02Rcv+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R02','Y','')\">"+obj.r02Spt+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R03','N','')\">"+obj.r03Rcv+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R03','Y','')\">"+obj.r03Spt+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R04','N','')\">"+obj.r04Rcv+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFEAEA; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R04','Y','')\">"+obj.r04Spt+"</td>"
		          		 		     + "</tr>";
	 						}else{
	 							item = "<tr>"
									 + "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.statsYear+"</td>"
		                    		 + "<td style='text-align: center; background-color: #FFFFFF;'>"+wpKind+"</td>"
		              			     + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','','N','"+obj.wpKind+"')\"> "+obj.totalRcv+"</td>"
		              			     + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','','Y','"+obj.wpKind+"')\">"+obj.totalSpt+"</td>"
		              			  	 + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R01','N','"+obj.wpKind+"')\">"+obj.r01Rcv+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R01','Y','"+obj.wpKind+"')\">"+obj.r01Spt+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R02','N','"+obj.wpKind+"')\">"+obj.r02Rcv+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R02','Y','"+obj.wpKind+"')\">"+obj.r02Spt+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R03','N','"+obj.wpKind+"')\">"+obj.r03Rcv+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R03','Y','"+obj.wpKind+"')\">"+obj.r03Spt+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R04','N','"+obj.wpKind+"')\">"+obj.r04Rcv+"</td>"
			           			     + "<td style='text-align: center; background-color: #FFFFFF; cursor:pointer;' onclick=\"fnGoList('"+obj.statsYear+"','R04','Y','"+obj.wpKind+"')\">"+obj.r04Spt+"</td>"
		          		 		     + "</tr>";
	 						} 	 
	                    }                    	    
	          				
	    				$("#dataList").append(item);
	    				$('#dataList tr:odd').addClass('add');
	                }	
	            }
	            
	            closeLoading();              
	     		setTimeout(chart_river, 100);
	     		setTimeout(chart_year, 200);
	     		setTimeout(chart_wpKind, 400);
			},
	        error:function(result){closeLoading();}
		});
	}
	
	//날짜(달력) 처리 함수
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
	
	function fnGoList(year, riverDiv, supportKind, wpKind){
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		
		$('#year').val(year);
		$('#riverDiv').val(riverDiv);
		$('#supportKind').val(supportKind);
		$('#statsStartDate').val(startDate);
		$('#statsEndDate').val(endDate);

		if(wpKind == '유류유출'){
			wpKind = 'PA';
		}else if(wpKind == '물고기폐사'){
			wpKind = 'PB';
		}else if(wpKind == '화학물질'){
			wpKind = 'PC';
		}else if(wpKind == '기타'){
			wpKind = 'PD';
		}else if(wpKind == '테스트'){
			wpKind = 'PT';
		}else{
			wpKind = '';
		}
		$('#wpKind').val(wpKind);

		
		var param = "?year=" + $("#statsForm input[name='year']").val();
		param += "&riverDiv=" + $("#statsForm input[name='riverDiv']").val();
		param += "&supportKind=" + $("#statsForm input[name='supportKind']").val();
		param += "&wpKind=" + $("#statsForm input[name='wpKind']").val();
		param += "&statsStartDate=" + $("#statsForm input[name='statsStartDate']").val();
		param += "&statsEndDate=" + $("#statsForm input[name='statsEndDate']").val();
		param += "&wpsStep=" + $("#statsForm input[name='wpsStep']").val();
		param += "&fromStats=" + $("#statsForm input[name='fromStats']").val();
		param += "&valueY=" + $("#statsForm input[name='valueY']").val();
		
		
		var windowpopup = window.open("<c:url value='/waterpollution/waterPollutionList.do'/>"+param,"_waterPollutionList","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=100,top=100");
		windowpopup.focus();
	}
	
	//화면 출력
	function fnPrint(btn){
	
		/*
		//btn.style.display = 'none'; 
		var wb = '<O' + 'BJECT ID="WebBrowser" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OB'+'JECT>'; 
		document.body.insertAdjacentHTML('beforeEnd', wb);
		WebBrowser.ExecWB( 7, -1 );
		WebBrowser.outerHTML = '';
		//btn.style.display = 'block';
		*/
		
		//btn.style.display = 'none';
		
		//btn.style.display = 'block';
		//factory.printing.Print(false, window) //바로 프린트
		/*
		factory.printing.header = "";
		factory.printing.footer = "";
		factory.printing.portrait = false; //가로(false) 세로(true)
		factory.printing.topMargin = 0.0;
		factory.printing.leftMargin = 0.0;
		factory.printing.rightMargin = 0.0;
		factory.printing.bottomMargin = 0.0;
		factory.printing.Preview(); //미리보기.
		*/
		
		var startDate		= $("#startDate").val().split('/').join('');
		var endDate			= $("#endDate").val().split('/').join('');
		var searchRiverDiv	= $("#searchRiverDiv").val();
		var searchWpKind	= $("#searchWpKind").val();
		
		window.open("<c:url value='/waterpollution/waterPollutionStatsPrint.do?startDate='/>" + startDate
					+ "&endDate=" + endDate
					+ "&searchRiverDiv=" + searchRiverDiv
					+ "&searchWpKind=" + searchWpKind
				,'Pop_Mvmn'
				,'resizable=yes,scrollbars=yes,width=1100,height=500,left=100,top=100,location=no');
	}
	
	//수계별 차트
	function chart_river(){
		var width = "330";
		var height = "150";
		
		var startDate = $("#startDate").val().split('/').join('');
		var endDate	= $("#endDate").val().split('/').join('');
		var searchRiverDiv  = $("#searchRiverDiv").val();
		var searchWpKind    = $("#searchWpKind").val();
		
		document.chartForm.target = "chartFrame1";
		document.chartForm.hiddenStartDate.value = startDate;
		document.chartForm.hiddenEndDate.value	= endDate;
		document.chartForm.searchRiverDiv.value = searchRiverDiv;
		document.chartForm.searchWpKind.value	= searchWpKind;
		document.chartForm.width.value			= width;
		document.chartForm.height.value		  = height;
		
		document.chartForm.action = "<c:url value='/waterpollution/waterPollutionStatsChartRiver.do'/>";
		document.chartForm.submit();
	}
		
	//년도별 차트
	function chart_year(){
		var width = "300";
		var height = "150";
		
		var startDate = $("#startDate").val().split('/').join('');
		var endDate	= $("#endDate").val().split('/').join('');
		var searchRiverDiv  = $("#searchRiverDiv").val();
		var searchWpKind    = $("#searchWpKind").val();
		
		document.chartForm.target = "chartFrame2";
		document.chartForm.hiddenStartDate.value = startDate;
		document.chartForm.hiddenEndDate.value	= endDate;
		document.chartForm.searchRiverDiv.value = searchRiverDiv;
		document.chartForm.searchWpKind.value	= searchWpKind;
		document.chartForm.width.value			= width;
		document.chartForm.height.value			= height;
		
		document.chartForm.action = "<c:url value='/waterpollution/waterPollutionStatsChartYear.do'/>";
		
		document.chartForm.submit();
	}

	//사고종류별
	function chart_wpKind(){
		var width = "400";
		var height = "150";
		
		var startDate = $("#startDate").val().split('/').join('');
		var endDate	= $("#endDate").val().split('/').join('');	
		var searchRiverDiv  = $("#searchRiverDiv").val();
		var searchWpKind    = $("#searchWpKind").val();
		
		document.chartForm.target = "chartFrame3";
		document.chartForm.hiddenStartDate.value = startDate;
		document.chartForm.hiddenEndDate.value	= endDate;
		document.chartForm.searchRiverDiv.value = searchRiverDiv;
		document.chartForm.searchWpKind.value	= searchWpKind;
		document.chartForm.width.value			= width;
		document.chartForm.height.value		  = height;
		
		document.chartForm.action = "<c:url value='/waterpollution/waterPollutionStatsChartWpKind.do'/>";
		
		document.chartForm.submit();
	}
//-->
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
						<form id="statsForm" name="statsForm" method="post">
							<input type="hidden" id="year"				name="year"/>
							<input type="hidden" id="riverDiv"			name="riverDiv"/>
							<input type="hidden" id="supportKind"		name="supportKind"/>
							<input type="hidden" id="wpKind"			name="wpKind"/>
							<input type="hidden" id="statsStartDate"	name="statsStartDate"/>
							<input type="hidden" id="statsEndDate"		name="statsEndDate"/>
							<input type="hidden" id="wpsStep"			name="wpsStep"/>
							<input type="hidden" id="fromStats"			name="fromStats" value="Y"/>
						</form>	
						<form id="chartForm" name="chartForm"			method="post">
							<input type="hidden" id="width"				name="width"/>
							<input type="hidden" id="height"			name="height"/>
							<input type="hidden" id="hiddenStartDate"	name="hiddenStartDate"/>
							<input type="hidden" id="hiddenEndDate"		name="hiddenEndDate"/>
							<input type="hidden" id="searchWpKind"	name="searchWpKind"/>
							<input type="hidden" id="searchRiverDiv"		name="searchRiverDiv"/>
						</form>
							
							<div class="searchBox dataSearch">
								<ul>
									<li>
										<span class="fieldName">수계</span>
										<select id="searchRiverDiv">
											<option value="">전체</option>
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
									
									</li>
									<li>
										<span class="fieldName">유형</span>
										<select id="searchWpKind">
											<option value="">전체</option>
											<option value="PA">유류유출</option>
											<option value="PB">물고기폐사</option>
											<option value="PC">화학물질</option>
											<option value="PD">기타</option>
										</select>
									</li>
									<li>
										<span class="fieldName">조회기간</span>
										<input type="text" id="startDate" name="startDate" size="13" onchange="commonWork()" alt="조회시작일"/>
										<span>~</span>
										<input type="text" id="endDate" name="endDate" size="13" onchange="commonWork()" alt="조회종료일"/>
									</li>
								</ul>
							</div>
							<!-- //유역별 통계 검색 -->
							
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:dataLoad();" alt="조회하기" style="float:right;"/>
						</div>
						
							<div id="btArea">
								<input type="button" id="btnPrint" name="btnPrint" value="인쇄" class="btn btn_basic" onclick="javascript:fnPrint(this);" alt="인쇄"/>
							</div>
							
							<!-- 수질오염접숱통계 현황 -->
							<div class="table_wrapper" style="margin-top:30px">

							<table class="dataTable">
								<colgroup>
									<col width="5%">
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
								</colgroup>
								<thead>
									<tr>
										<th rowspan="3" style="text-align: center; background-color: #E1E1E1;">연도</th>
										<th rowspan="3" style="text-align: center; background-color: #E1E1E1;">구분</th>
										<th colspan="2" rowspan="2" style="text-align: center; background-color: #E1E1E1;">합계</th>
										<th colspan="8" style="text-align: center; background-color: #E1E1E1;">수계</th>
									</tr>
									<tr>
										<th colspan="2" style="text-align: center; background-color: #E1E1E1;">한강</th>
										<th colspan="2" style="text-align: center; background-color: #E1E1E1;">낙동강</th>
										<th colspan="2" style="text-align: center; background-color: #E1E1E1;">금강</th>
										<th colspan="2" style="text-align: center; background-color: #E1E1E1;">영산강</th>
									</tr>
									<tr>
										<th style="text-align: center;">접수</th>
										<th style="text-align: center;">지원</th>
										<th style="text-align: center;">접수</th>
										<th style="text-align: center;">지원</th>
										<th style="text-align: center;">접수</th>
										<th style="text-align: center;">지원</th>
										<th style="text-align: center;">접수</th>
										<th style="text-align: center;">지원</th>
										<th style="text-align: center;">접수</th>
										<th style="text-align: center;">지원</th>
									</tr>
								</thead>
								<tbody id="dataList">
							</table>
							<br><br><br>
								<table class="borderNoTb" summary="수질오염통계차트정보">
									<colgroup>
										<col width="32%">
										<col width="29%">
										<col width="39%">
									</colgroup>
									<tr>
										<td><b>수계별</b></td>
										<td><b>년도별</b></td>
										<td><b>사고종류별</b></td>
									</tr>
									<tr>
										<td>
											<div>
												<iframe id="chartFrame1" name="chartFrame1" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="200px;"></iframe>
											</div>
										</td>
										<td>
											<div>
												<iframe id="chartFrame2" name="chartFrame2" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="200px;"></iframe>
											</div>
										</td>
										<td>
											<div>
												<iframe id="chartFrame3" name="chartFrame3" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="200px;"></iframe>
											</div>
										</td>
									</tr>
								</table>
								<!-- //수질오염접숱통계 현황 -->	
								
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
<!-- 	<object id="factory" viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="http://his-korea.com/business/smsx.cab#Version=6,4,438,06"> -->
<!-- 		<param name="template" value="MeadCo://IE7" /> -->
<!-- 	</object> -->
</body>
</html>