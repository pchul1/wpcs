<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	 /**
	 * Class Name : alertStepList.jsp
	 * Description : Alert Step List 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.11.05	kgb			최초 생성
	 * 
	 * author khany
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by khany All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<script type="text/javascript">
		var step = "${step}";
		
		$(function () {
			if(step == "9")
				step = "1";
			
				//측정기이상(6), 이상데이터(7), 시료분석에서 상황완료시킨경우(10)
				if(step == "6" || step == "7" || step == "10")
				{
					var startIdx = 3;
					
					if(step == "6")
						startIdx = 3;
					else if(step == "7")
						startIdx = 2;
					else
						startIdx = 4;
						
					for(var idx = startIdx ; idx <= 5 ; idx++)
					{
						var img = $("#imgStep" + idx);
						var a = $("#a" + idx);
						img.attr("src","<c:url value='/images/popup/process_menu0" + idx + "_off.gif'/>");
						a.attr("href", "#");
						a.attr("target", "");
						a.attr("onclick", "");
					}
				}
				
				if(step == "6" || step == "7" || step == "8" || step == "10")
					step = "6";
				else
				{
					$("#imgStep7").attr("src", "<c:url value='/images/popup/process_menu07_off.gif'/>");
					var a = $("#a7");
					a.attr("href", "#");
					a.attr("target", "");
					a.attr("onclick", "");
				}
				
				var imgStep = $("#imgStep" + step);
				
				imgStep.attr("src","<c:url value='/images/popup/process_menu0" + step + "_on.gif'/>");
				
				var idx = 0;
				for(idx = eval(step)+1;idx <= 6; idx++)
				{
					var img = $("#imgStep" + idx);
					var a = $("#a" + idx);
					
					img.attr("src", "<c:url value='/images/popup/process_menu0" + idx + "_off.gif'/>");
					a.attr("href", "#");
					a.attr("target", "");
					a.attr("onclick", "");
				}
		});
		
		function btnClick(step, obj)
		{
			
		}
		
		var type = "${param.itemType}";
		
		function report() {
			var sw=screen.width;
			var sh=screen.height;
			var winHeight = 600;
			var winWidth = 900;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;
			var width = winWidth-40;
			var height = winHeight-40;
			
			var mrdFile = "";
			
			if(type == "TYPE1")//육안관찰이면
				mrdFile = "completeRpt_${asData.alertStep}_eye";
			else
				mrdFile = "completeRpt_${asData.alertStep}";
				
			var param = "/rp [${asData.asId}]";
			
			document.report.mrdpath.value = mrdFile;
			document.report.param.value = param;
					
			window.open("", 
					'reportView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
					
			document.report.target = "reportView";
			document.report.submit();
		}
	</script>
</head>
<body class="popup">
	<div id="wrap" class="situationprocessPop">
		<div class="pop_header">
			<div class="bg_header_r">
				<div class="bg_header">
<%-- 					<h1 class="pop_tit"><img src="<c:url value='/images/popup/h1_statProcess.gif'/>" alt="상황 처리 단계" /></h1> --%>
					<h1 class="pop_tit">상황 처리 단계</h1>
				</div>
			</div>
		</div>
		<div class="pop_container">
			<div class="pop_container_r">
				<div id="container">
					<!-- 좌측메뉴 -->
					<div class="sideNavi">
						<ul>
							<!-- * 비활성화 버튼이미지 파일명 : process_menu01_off.gif -->
							<li><a onclick='btnClick(1, this)' id="a1" href="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asData.asId}&step=1'/>" target="process_sub"><img id="imgStep1" src="<c:url value='/images/popup/process_menu01.gif'/>" alt="경보발생" /></a></li>
							<li><a onclick='btnClick(2, this)' id="a2" href="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asData.asId}&step=2'/>" target="process_sub"><img id="imgStep2" src="<c:url value='/images/popup/process_menu02.gif'/>" alt="현장확인" /></a></li>
							<li><a onclick='btnClick(3, this)' id="a3" href="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asData.asId}&step=3'/>" target="process_sub"><img id="imgStep3" src="<c:url value='/images/popup/process_menu03.gif'/>" alt="시료분석" /></a></li>
							<li><a onclick='btnClick(4, this)' id="a4" href="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asData.asId}&step=4'/>" target="process_sub"><img id="imgStep4" src="<c:url value='/images/popup/process_menu04.gif'/>" alt="경보발령" /></a></li>
							<li><a onclick='btnClick(5, this)' id="a5" href="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asData.asId}&step=5'/>" target="process_sub"><img id="imgStep5" src="<c:url value='/images/popup/process_menu05.gif'/>" alt="상황조치" /></a></li>
							<li><a onclick='btnClick(6, this)' id="a6" href="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asData.asId}&step=8'/>" target="process_sub"><img id="imgStep6" src="<c:url value='/images/popup/process_menu06.gif'/>" alt="상황종료" /></a></li>
							<li><a href="javascript:report()" id="a7"><img id="imgStep7" src="<c:url value='/images/popup/process_menu07_on.gif'/>" alt="보고서 출력" /></a></li>
						</ul>
					</div>
					<!--// 좌측메뉴 -->
					
					<!-- 메뉴별내용 -->
					<div class="contents" style="padding-left:10px;">
					<c:if test="${param.cStep != null || param.cStep != ''}">
						<iframe src="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asData.asId}&step=${param.cStep}'/>" name="process_sub" width="830px" height="700px" scrolling="auto" frameborder="0" id="myiframe">	</iframe>
					</c:if>
					<c:if test="${param.cStep == null && param.cStep == ''}">
						<iframe src="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asData.asId}&step=${step}'/>" name="process_sub" width="830px" height="700px" scrolling="auto" frameborder="0" id="myiframe">	</iframe>
					</c:if>
					</div>
					<!--// 메뉴별내용 -->
				</div>
				<!-- //container -->
			</div>
		</div>
		<div class="pop_footer">
			<div class="bg_footer_r">
				<div class="bg_footer">
				</div>
			</div>
		</div>
	</div>
	<form name="report" method="post" action="<c:url value='/common/rdView.do'/>">
		<input type="hidden" name="mrdpath" />
		<input type="hidden" name="param" />
	</form>
</body>
</html>