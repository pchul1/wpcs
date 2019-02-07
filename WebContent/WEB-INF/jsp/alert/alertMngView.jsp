<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<%
	 /**
	 * Class Name : alertMngView.jsp
	 * Description : 상황발생이력 상세 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.20	khany		최초 생성
	 * 2013.11.07	lkh			리뉴얼
	 * 
	 * author khany
	 * since 2010.05.20
	 * 
	 * Copyright (C) 2010 by khany All right reserved.
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

<script type="text/javascript">
//<![CDATA[
	$(function () {
		<sec:authorize ifAnyGranted="ROLE_ADMIN">
			$('#btnDelete').show();
		</sec:authorize>
		
		$('#btnReport').click(function(){
// 			report();
			fnPrint();
		});
		
		$('#btnDelete').click(function(){
			fnDelete();
		});
		
		$('#btnList').click(function(){
			list();
		});
		
		var iFrames = document.getElementsByTagName('iframe');
		
		function iResize(){
		
			for (var i = 0, j = iFrames.length; i < j; i++){
				iFrames[i].style.height = iFrames[i].contentWindow.document.body.offsetHeight + 15 + 'px';
			}
		}
		
		if ($.browser.safari || $.browser.opera){
		
			$('iframe').load(function(){
				setTimeout(iResize, 0);
			});
			
			for (var i = 0, j = iFrames.length; i < j; i++){
				var iSource = iFrames[i].src;
				
				iFrames[i].src = '';
				iFrames[i].src = iSource;
			}
		} else {
			$('iframe').load(function(){
				this.style.height = this.contentWindow.document.body.offsetHeight + 15 + 'px';
			});
		}
	});
	
	function list(){
		document.location.href = "<c:url value='/alert/alertMngList.do'/>?pageIndex=${pageIndex}&startDate=${startDate}&endDate=${endDate}&system=${system}&minOr=${minOr}";
	}
	
	function fnDelete(){
		if(confirm("삭제하시겠습니까?")) {
			document.location.href = "<c:url value='/alert/alertMngHistDelete.do'/>?asId=${asId}";
		}
	}
	
	var type = "${param.itemType}";
	
	function report() {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 600;
		var winWidth = 1000;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		var mrdFile = "";
		
		if(type == "TYPE1")//육안관찰이면
			mrdFile = "completeRpt_${step}_eye";
		else{
			mrdFile = "completeRpt_${step}";
		}
			
		var param = "/rp [${asId}]";
		
		document.report.mrdpath.value = mrdFile;
		document.report.param.value = param;
		
		window.open("",'reportView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
				
		document.report.target = "reportView";
		document.report.submit();
	}
	
	function fnPrint() {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 600;
		var winWidth = 1050;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		var param = "asId=${asId}&step=${step}&mngPrt=Y";
	
		window.open("<c:url value='/alert/goAlertStepSub_popup.do'/>?"+encodeURI(param),
		'alertMngPrintView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,left='+winLeftPost+',top='+winTopPost);
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
					<div class="tab_container" style="text-align:left;">
						
						<div class="table_wrapper" style="display:inline-block;">
							<c:choose>
								<c:when test="${step == 6}">
									<iframe id="iframe" src="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asId}&step=${step}&mngList=N&pageIndex=${param.pageIndex}&itemType=${param.itemType}&system=${param.system}&startDate=${param.startDate}&endDate=${param.endDate}&minOr=${param.minOr}'/>" name="process_sub" width="992px" scrolling="no" frameborder="0" marginheight="0" marginwidth="0"></iframe>
								</c:when>
								<c:otherwise>
									<iframe id="iframe" src="<c:url value='/alert/goAlertStepSub_popup.do?asId=${asId}&step=${step}&mngList=Y&pageIndex=${param.pageIndex}&itemType=${param.itemType}&system=${param.system}&startDate=${param.startDate}&endDate=${param.endDate}&minOr=${param.minOr}'/>" name="process_sub" width="992px" scrolling="no" frameborder="0" marginheight="0" marginwidth="0"></iframe>
								</c:otherwise>
							</c:choose>
							<div id="btRarea">
								<input type="button" id="btnReport" name="btnReport" value="보고서 출력" class="btn btn_basic" alt="보고서 출력" style="display:none;"/>
								<input type="button" id="btnDelete" name="btnDelete" value="삭제" class="btn btn_basic" style="display:none;"  alt="삭제"/>
								<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" alt="목록"/>
							</div>
							
						</div>
						  
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
		
		<form:form commandName="alertMngVO" name="listFrm" method="post">
			<input type="hidden" name="pageIndex" value="${pageIndex}"/>
		</form:form>
		
		<form name="report" method="post" action="<c:url value='/common/rdView.do'/>">
			<input type="hidden" name="mrdpath" />
			<input type="hidden" name="param" />
		</form>
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>