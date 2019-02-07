<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
function showLoading()
{
// 	$("#loadingDiv").dialog({
// 		modal:true,
// 		open:function() 
// 		{
// 			$("#loadingDiv").css("visibility","visible");
// 			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").hide();
// 			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").hide();
// 			$(this).parents(".ui-dialog:first").find(".ui-dialog-resizing").hide();
// 			$(this).parents(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();
// 			$(this).parents(".ui-dialog:first").find(".ui-dialog-dragging").hide();
// 			$(this).parents(".ui-dialog:first").css("width", "85px");
// 			$(this).parents(".ui-dialog:first").css("height", "75px");
// 			$(this).parents(".ui-dialog:first").css("overflow", "hidden");
// 			$("#loadingDiv").css("float", "left");
// 		},
// 		width:120,
// 		height:120,
// 		showCaption:false,
// 		resizable:false
// 	});
// 	$("#wrap").css({display:"block",opacity:0.5}); 
// 	$("#loadingDiv").dialog("open");
}

function closeLoading()
{
// 	$("#loadingDiv").dialog("close");
// 	$("#wrap").css({display:"block",opacity:1});
}
</script>
<div id='loadingDiv' style="visibility: hidden; position: absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
</div>
<div class="toolbar">
	<table style="width:100%">
		<c:if test="${param.notlogin eq 'Y'}">
		<tr>
			<td align="left" width="33%"><a href="tel:1666-0128"><span style="top:1px;position:relative;"><img src="/images/mobile/main/phone.png" border="0"/></span> 신고전화</a></td>
			<td align="center" width="33%"><a href="/mobile"><img src="/images/mobile/main/header_logo.png" border="0"/></a></td>
			<td align="right" width="33%"><a href="/mobile/login.do"><span style="top:0px;position:relative;"><img src="/images/mobile/main/login_icon.png" border="0"/></span> <span style="top:-1px;position:relative;color:white;">로그인</span></a></td>
		</tr>
		</c:if>
		<c:if test="${param.notlogin ne 'Y'}">
		<tr>
			<td align="left" width="10%"><a id="menu_open" href="javascript:history.back();"><img src="/images/mobile/prev.png" border="0"/></a></td>
			<td align="center" width="80%"><a href="<c:url value='${param.link}'/>" style="font-size:15px;color:#fff;"><c:out value='${param.title}'/></a></td>
			<td align="right" width="10%"><a href="/mobile/main/main.do"><img src="/images/mobile/home.png" border="0"/></a></td>
		</tr>
		</c:if>
	</table>
</div> 
