<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title></title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
	<script type='text/javascript'>

		var sys = '${searchTaksuVO.sys}';
		var sugye = '${searchTaksuVO.sugye}';
		var gongku = '${searchTaksuVO.gongku}';
		var bangryu = '${searchTaksuVO.bangryu}';
		var dataType = '${searchTaksuVO.dataType}';
		var valid = '${searchTaksuVO.valid}';
		var minor = '${searchTaksuVO.minor}';
		var frTime = '${searchTaksuVO.frTime}';
		var frDate = '${searchTaksuVO.frDate}';
		var toTime = '${searchTaksuVO.toTime}';
		var toDate = '${searchTaksuVO.toDate}';

		var bItem = '${param.item}';
		
		var item;
		
		$(function(){

			getBranchName();
			
		
			$('#item')
			.change(function(){
				chart();
			})		

			chart();
		});

		function chart_load()
		{
			$("#span_loading").css("display", "none");
		}

		function getBranchName()
		{
			
		}
		
		function chart(){
			
			$("#span_loading").show();

			var item = $("#item").val();
			
			var sw=screen.width;
			var sh=screen.height;
			var winHeight = 440;
			var winWidth = 620;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;
			var width = winWidth-20;
			var height = winHeight-20;
			
			var rType = dataType;
			
	        var param = "sugye=" + sugye + "&gongku=" + gongku + "&bangryu=" + bangryu +
			 "&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
	         "&sys=" + sys + 
	         "&valid=" + valid + 
	         "&minor=" + minor +
	         "&item=" + item +
			 "&dataType=" + rType + "&width=" + (winWidth-40) + "&height=" + (winHeight-40);

			 //stats/getAccidentStatsChart.do
			//window.open("<c:url value='/waterpolmnt/waterinfo/getChartDetalViewRIVER.do'/>?"+encodeURI(param), 
			//		'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);

			var src = "<c:url value='/waterpolmnt/waterinfo/getDamChart_popup.do?'/>";
			$('#chart').attr("src", src + encodeURI(param));
		}
	</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'>댐 수위, 방류량 변화 추이</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
			
<div class="totalmntPop2">
	<div class="content" style="padding-top:20px">
	<center>
	</center>
		<div class="graph">
			<span id="span_loading" style="position:absolute">데이터를 불러오는 중 입니다...</span>
			<iframe id="chart" name="chartFrame" onload="chart_load()" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
		</div>
	</div>
</div>
			</div><!-- 추가 및 수정 -->
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</body>
</html>

