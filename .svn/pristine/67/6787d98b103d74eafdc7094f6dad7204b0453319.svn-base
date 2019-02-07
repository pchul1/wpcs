<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * @Class Name	: waterPollutionStats.jsp
	 * @Description : 수질오염사고 통계
	 * @Modification Information
	 * @
	 * @수정일			 수정자		수정내용
	 * @ -------		--------	---------------------------
	 * @ 2013.04.30	YIK		최초 생성
	 *
	 * @author YIK
	 * @since 2013.04.30
	 * @version 1.0
	 * @see
	 * 
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<sec:authorize ifAnyGranted="ROLE_USER">
		<script type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
			var user_id = '<sec:authentication property="principal.userVO.id"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>
	
<title>수질오염사고 통계</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css' />" />
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />

<script type="text/javaScript" language="javascript">
//<![CDATA[
	$(function(){
		setTimeout(chart_river, 100);
		setTimeout(chart_year, 300);
		setTimeout(chart_wpKind, 500);
		setTimeout(dataLoad, 2000);
	});
	
	var chk = 0;
	
	function dataLoad(){
		
		var wpCode = "${param.wpCode}";
		
		showLoading();
		
		var startDate		= "${param.startDate}";
		var endDate			= "${param.endDate}";
		var searchRiverDiv	= "${param.searchRiverDiv}";
		var searchWpKind	= "${param.searchWpKind}";
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpollution/getWaterPollutionStats.do'/>",
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
				
				if( tot <= 0 ){
					$("#dataList").html("<tr><td colspan='12'>조회 결과가 없습니다</td></td>");
					closeLoading();
				}else{
					for(var i=0; i< tot; i++){
						var wpKind = '';
						var obj = result['list'][i];
						
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
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.totalRcv+"</td>"
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.totalSpt+"</td>"
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.r01Rcv+"</td>"
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.r01Spt+"</td>"
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.r02Rcv+"</td>"
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.r02Spt+"</td>"
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.r03Rcv+"</td>"
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.r03Spt+"</td>"
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.r04Rcv+"</td>"
								+ "<td style='text-align: center; background-color: #E6FFFF;'>"+obj.r04Spt+"</td>"
								+ "</tr>";
						}else{
							if(obj.wpKind == '' || obj.wpKind == null){
								item = "<tr>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.statsYear+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+wpKind+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.totalRcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.totalSpt+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.r01Rcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.r01Spt+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.r02Rcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.r02Spt+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.r03Rcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.r03Spt+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.r04Rcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFEAEA;'>"+obj.r04Spt+"</td>"
									+ "</tr>";
							}else{
								item = "<tr>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.statsYear+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+wpKind+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'> "+obj.totalRcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.totalSpt+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.r01Rcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.r01Spt+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.r02Rcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.r02Spt+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.r03Rcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.r03Spt+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.r04Rcv+"</td>"
									+ "<td style='text-align: center; background-color: #FFFFFF;'>"+obj.r04Spt+"</td>"
									+ "</tr>";
							}
						}
							
						$("#dataList").append(item);
						$('#dataList tr:odd').addClass('add');
					}
				}
// 				fnPrint(startDate, endDate);
				closeLoading();
				selectPrint();
				
			},
			error:function(result){closeLoading();}
		});
	}
	
	//화면 출력
	function fnPrint(startDate, endDate){
		
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
		var tempStartDate = startDate.substring(0,4);
		var tempEndDate	= endDate.substring(0,4);
		var tempStr		= tempStartDate + '년 ~ ' + tempEndDate + '년 의 수질오염사고 접수/지원 통계';
		
		factory.printing.header = tempStr;
		factory.printing.footer = "";
		factory.printing.portrait = false; //가로(false) 세로(true)
		factory.printing.topMargin = 0.0;
		factory.printing.leftMargin = 0.0;
		factory.printing.rightMargin = 0.0;
		factory.printing.bottomMargin = 0.0;
		factory.printing.Print(false, window) //바로 프린트
		//factory.printing.Preview(); //미리보기.
		window.close();
		
	}
	
	function selectPrint() {
		var startDate		= "${param.startDate}";
		var endDate			= "${param.endDate}";
		var tempStr		= startDate.substring(0,4) + '년 ' + startDate.substring(4,6) + '월 ' + startDate.substring(6,8) + '일 ' + ' ~ ' + endDate.substring(0,4) + '년 ' + endDate.substring(4,6) + '월 ' + endDate.substring(6,8) + '일' + '의 수질오염사고 접수/지원 통계';
		$("#headerMsg").html(tempStr);
		window.print();
		window.close();
	}
	
	
	
	//수계별 차트
	function chart_river(){
		var width = "330";
		var height = "150";
		
		var startDate = "${param.startDate}";
		var endDate = "${param.endDate}";
		
		startDate = startDate.split('/').join('');
		endDate = endDate.split('/').join('');
			
		document.chartForm.target = "chartFrame1";
		document.chartForm.hiddenStartDate.value = startDate;
		document.chartForm.hiddenEndDate.value	= endDate;
		document.chartForm.width.value			= width;
		document.chartForm.height.value			= height;
	
		document.chartForm.action = "<c:url value='/waterpollution/waterPollutionStatsChartRiver.do'/>";
		document.chartForm.submit();
	}
	
	//년도별 차트
	function chart_year(){
		var width = "300";
		var height = "150";
		
		var startDate = "${param.startDate}";
		var endDate = "${param.endDate}";
		
		startDate = startDate.split('/').join('');
		endDate = endDate.split('/').join('');
		
		document.chartForm.target = "chartFrame2";
		document.chartForm.hiddenStartDate.value = startDate;
		document.chartForm.hiddenEndDate.value	= endDate;
		document.chartForm.width.value			= width;
		document.chartForm.height.value			= height;
		
		document.chartForm.action = "<c:url value='/waterpollution/waterPollutionStatsChartYear.do'/>";
		document.chartForm.submit();
	}
	
	//사고종류별
	function chart_wpKind(){
		var width = "400";
		var height = "150";
		
		var startDate = "${param.startDate}";
		var endDate = "${param.endDate}";
		
		startDate = startDate.split('/').join('');
		endDate = endDate.split('/').join('');
		
		document.chartForm.target = "chartFrame3";
		document.chartForm.hiddenStartDate.value = startDate;
		document.chartForm.hiddenEndDate.value	= endDate;
		document.chartForm.width.value			= width;
		document.chartForm.height.value			= height;
		
		document.chartForm.action = "<c:url value='/waterpollution/waterPollutionStatsChartWpKind.do'/>";
		document.chartForm.submit();
	}
//]]>
</script>
</head>
<body>
	<div id='loadingDiv' style="visibility:hidden;position:absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
		<div id="container">
			<!-- content -->
			<div id="content">
				<div id="managePage">
					<table>
						<tr>
							<td style="height: 70px;"><h3 id="headerMsg"></h3></td>
						</tr>
					</table>
					<form id="chartForm" name="chartForm" method="post">
						<input type="hidden" id="width"				name="width"/>
						<input type="hidden" id="height"			name="height"/>
						<input type="hidden" id="hiddenStartDate"	name="hiddenStartDate"/>
						<input type="hidden" id="hiddenEndDate"		name="hiddenEndDate"/>
					</form>
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
								<th style="text-align: center; background-color: #E1E1E1;" rowspan="3">연도</th>
								<th style="text-align: center; background-color: #E1E1E1;" rowspan="3">구분</th>
								<th style="text-align: center; background-color: #E1E1E1;" rowspan="2" colspan="2">합계</th>
								<th style="text-align: center; background-color: #E1E1E1;" colspan="8">수계</th>
							</tr>
							<tr>
								<th style="text-align: center; background-color: #E1E1E1;" colspan="2">한강</th>
								<th style="text-align: center; background-color: #E1E1E1;" colspan="2">낙동강</th>
								<th style="text-align: center; background-color: #E1E1E1;" colspan="2">금강</th>
								<th style="text-align: center; background-color: #E1E1E1;" colspan="2">영산강</th>
							</tr>
							<tr>
								<th style="text-align: center;" >접수</th>
								<th style="text-align: center;" >지원</th>
								<th style="text-align: center;" >접수</th>
								<th style="text-align: center;" >지원</th>
								<th style="text-align: center;" >접수</th>
								<th style="text-align: center;" >지원</th>
								<th style="text-align: center;" >접수</th>
								<th style="text-align: center;" >지원</th>
								<th style="text-align: center;" >접수</th>
								<th style="text-align: center;" >지원</th>
							</tr>
						</thead>
						<tbody id="dataList"></tbody>
					</table>
					<br><br><br>
					<table style="width: 100%; padding: 0px;">
						<tr>
							<td style="width: 33%; text-align: center;"><b>수계별</b></td>
							<td style="width: 30%; text-align: center;"><b>년도별</b></td>
							<td style="width: 36%; text-align: center;"><b>사고종류별</b></td>
						</tr>
						<tr>
							<td>
								<div class="graph">
									<iframe id="chart1" name="chartFrame1" src="" scrolling="yes" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="200px;"></iframe>
								</div>
							</td>
							
							<td>
								<div class="graph">
									<iframe id="chart2" name="chartFrame2" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="200px;"></iframe>
								</div>
							</td>
							<td>
								<div class="graph">
									<iframe id="chart3" name="chartFrame3" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="200px;"></iframe>
								</div>
							</td>
						</tr>
					</table>
				</div><!-- //managePage -->
			</div><!-- //content -->
		</div><!-- //container -->
	</div>
<!-- 	<object id="factory" viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="http://his-korea.com/business/smsx.cab#Version=6,4,438,06"> -->
<!-- 	<param name="template" value="MeadCo://IE7" /> -->
<!-- 	</object> -->
</body>
</html>