<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>

<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp" %>
<%
	/**
	 * Class Name : daminfo.jsp
	 * Description : IP-daminfo 화면
	 * Modification Information
	 * 
	 * 수정일				 수정자		 수정내용
	 * ----------    	--------    ---------------------------
	 * 2013.12.17		lkh         리뉴얼
	 *
	 * author lkh
	 * since 2013.12.17
	 *   
	 * Copyright (C) 2013 by lkh  All right reserved.
	 */
%>

<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_gisCommonjs.jsp" />
	
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

			var src = "<c:url value='/waterpolmnt/waterinfo/getFluxChart_popup.do?'/>";
			$('#chart').attr("src", src + encodeURI(param));
		}
	</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'>수위, 유량 변화 추이</h1>
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

