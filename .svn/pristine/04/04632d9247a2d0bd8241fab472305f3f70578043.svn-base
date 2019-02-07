<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /** 
  * @Class Name : PopupMap.jsp
  * @Description : 좌표를 찾는 지도
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2010.08.30  kisspa        최초 생성
  *
  *  @author kisspa
  *  @since 2010.08.30
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<link href="<c:url value='/css/content.css' />" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/popup.css' />" rel="stylesheet" type="text/css">
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<title>좌표지정</title>
<script>
	var ROOT_PATH = '<c:url value="/"/>';
</script>
<script language="javascript1.2">
$(function () {	
	$("#infoRiver").empty();

	setTimeout(initAddress, 1000);
});

function initAddress() {
	var addr = $('#addr', window.opener.document).val();
	var whName = $('#whName', window.opener.document).val();
	var lon = $('#lon', window.opener.document).val();
	var lat = $('#lat', window.opener.document).val();
	if (addr != null && whName != null) {
		mov2addressHtml(addr,'<b>'+whName+'</b><br>'+addr);
	}	
	$("#laty").val(lat);
	$("#lngx").val(lon);
	$("#addressPoint").val(addr);
}

function changeMode() {
	getLatLngFromMap('on');	
}

function applyLonLat() {
	opener.applyLonLat($("#lngx").val(), $("#laty").val(), $("#addressPoint").val());	
	self.close();
}
</script>
</head>

<body class="subPop"><!-- 추가 및 수정 --> 
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'>사고지점선택</h1>
		</div>
	</div>
</div> 
<div class="contentWrap"> 
	<div class="contentBg_r"> 
		<div class="contentBox"> 
			<div class="contentPad">
				<!-- 내용 --> 
				<div id="managePage">
					<ul class="menuList menuSpacing highIndex">
						<li class="spacing">
							<input type="button" value="좌표구하기" onclick="changeMode();"> y=<input id="laty" type="text" value="" style="width:80px;"/>, x=<input id="lngx" type="text" style="width:80px;" value="" />, 주소=<input id="addressPoint" type="text" value="" style="width:250px;"/>
							<input type="button" value="반영" onclick="applyLonLat();">
						</li>
					</ul>
					<c:import url="/WEB-INF/jsp/common/mapview.jsp" />
				</div>
			</div>
		</div> 
	</div> 
</div> 
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 --> 
</body> 
</html> 


