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
	
		var sys;
		var river;
		var item;
		
		$(function(){
			dataLoad();
		});
		
		function dataLoad()
		{
			$.ajax({
				type:"post",
				url:"<c:url value='/weather/getWeatherWarning.do'/>",
				dataType:"json",
				success:dataLoad_success,
				error:function(result){
						$("#dataList").html("<tr><td colspan='6'>서버 접속에 실패하였습니다!</td></tr>");
				}
			});
		}
		
		var title='';
		function dataLoad_success(result)
		{
			if(result != null)
			{
				var obj = result['warningData'];
				
				if(obj != null)
				{
					$("#announce_time").text(obj.announce_time.substring(0, 16));
					
					var w = obj.warning_content.split("\n");
					var wc = "";
					
					for(var idx  = 0 ; idx < w.length ; idx++)
					{
						w[idx] = w[idx].replace("o ", " ");
						wc += "<br/><b>" + (idx+1) + ".</b> " + w[idx] + "<br/>&nbsp;";
					}
					
					//obj.warning_content = obj.warning_content.split("\n").join("<br/>&nbsp;");\
					obj.effective_time = obj.effective_time.split("\n").join("<br/>&nbps;");
					obj.content = obj.content.split("\n").join("<br/>&nbsp;");
					obj.remark = obj.remark.split("o").join("☞");
					
					
					$("#warning_content").html(wc);
					$("#effective_time").html(obj.effective_time);
					$("#content").html(obj.content);
					$("#remark").html(obj.remark);
					
					var weatherWarnList = obj.warning_content.split('o ');
					
					var length = weatherWarnList.length;
					
					//idx 1부터 [ 0번째는 비어있음 ]
					for(var idx = 1 ; idx < length ; idx++)
					{
						//1. xx주의보 : [경보지역]에서 경보지역 표시 안함
						if(weatherWarnList[idx] != "")
							weatherWarnList[idx] = weatherWarnList[idx].split(':')[0];
					}
					
					for(var idx = 1 ; idx < weatherWarnList.length ; idx++)
					{
						title += idx + "." + weatherWarnList[idx] + " " ;
					}
					
					var announceDate = obj.announce_time;
					
					// yyyy-MM-dd HH:mm:ss.s  ->>> yyyyMMddHHmm
					announceDate = announceDate.split("-").join("");
					announceDate = announceDate.split(":").join("");
					announceDate = announceDate.split(".").join("");
					announceDate = announceDate.split(" ").join("");
					
					announceDate = announceDate.substring(0, 12);
					
					var station_id = obj.station_id;
					var announce_seq = obj.announce_seq;
					
					var imgParam = announceDate + "_" + station_id + "_" + announce_seq;
					
					var imgSrc = "http://www.kma.go.kr/repositary/image/wrn/img/KTKO50_"+ imgParam +".png";
					
					$("#warnImg").attr("src", imgSrc);
				}
				else
				{
					$("#warnImg").attr("src", "");
				}
			}
		}
		
		function goWeatherWarnList()
		{
			window.open("<c:url value='/waterpolmnt/waterinfo/goWeatherWarn.do'/>?clickMenu=12310");
		}
		
		// SMS 팝업
		function smsPopup() {
			var sw=screen.width;
			var sh=screen.height;
			var winHeight = 390;
			var winWidth = 1000;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;
			var width = winWidth-40;
			var height = winHeight-40;
			
			document.smsPopupForm.msg.value = "기상특보 발령: [  " +  title + "] 사전조치 바랍니다";
			
			window.open('',
					'smsSendPopup','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
			document.smsPopupForm.target = "smsSendPopup";
			document.smsPopupForm.submit();
		}
	</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1>기상특보</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
				<div class="totalmntPop2">
					<div class="content">
						<span id="span_loading" style="position:absolute"></span>
<!-- 						<table class="dataTable" style="cursor:pointer" onclick="goWeatherWarnList()"> -->
<!-- 						2014-10-30 김용세 수정 -->
						<table class="dataTable">
							<tbody>
								<tr>
									<th colspan="2"><b><span id="announce_time"></span>&nbsp;에 발표된 기상특보 입니다.</b></th>
								</tr>
								<tr>
									<td>
										<img id='warnImg' src="<c:url value='/images/common/ajax-loader.gif'/>"/>
									</td>
									<td style="text-align:left;vertical-align:top;padding-left:5px">
											<br/>
											&nbsp;<b>[특보발효 현황]</b><br/><br/>
											&nbsp;<span id="warning_content"></span>
											<br/><br/>
											&nbsp;<b>[참고사항]</b><br/><br/>
											&nbsp;<span id="remark"></span>
									</td>
								</tr>
								<!--
								<tr>
									<td colspan="2" class="btn"><a href="javascript:smsPopup()"><img  src="<c:url value='/images/popup/btn_weather_alert.gif'/>"/></a></td>
								</tr>
								-->
							</tbody>
						</table>
					</div>
				</div>
			</div><!-- 추가 및 수정 -->
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
<form name="smsPopupForm" method="post" action="/cmmn/weatherSmsSend.do">
<input type="hidden" name="msg"/>
</form>
</body>
</html>
