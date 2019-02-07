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
	</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1>그래프 상세정보</h1>
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
			<ul class="selectList">
				<li><span class="buArrow_tit">시스템</span> 
					<select id="sys">
						<option value="all" selected="selected">전체</option>
<!-- 						<option value="T">탁수모니터링</option> -->
						<option value="U">이동형측정기기</option>
						<option value="A">국가수질자동측정망</option>
					</select>
				</li>
				<li><span class="buArrow_tit">수계</span>
					<select id="river">
						<option value="R01">한강</option>
						<option value="R02">낙동강</option>
						<option value="R03">금강</option>
						<option value="R04">영산강</option>
					</select>
				</li>
				<li><span class="buArrow_tit">수계</span>
					<select id="factCode">
						<option value="all">전체</option>
					</select>
				</li>
				<li><span class="buArrow_tit">수계</span>
					<select id="branchNo" name="branchNo" disabled="disabled">
						<option value="all">전체</option>
					</select>
				</li>
			</ul>
		<div class="gis">
		<!-- gis -->
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

