<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/tab.js"></script>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
	function fnPrint() {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 400;
		var winWidth = 800;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		var param = "memberId=${memberVO.memberId}";
	
		window.open("<c:url value='/acc/accountAppPrint.do'/>?"+encodeURI(param),
		'accountAppPrint','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function fnPdf(){
		location.href= "<c:url value='/acc/accountAppPdfDown.do'/>?memberId=${memberVO.memberId}";
	}
//]]>
</script>
</head>
<body>
<!-- wrap -->

<div id="wrap"> 
  
	<!--header -->
	<div class="header_wrap">
		<c:import url="/WEB-INF/jsp/pub/include/client_header.jsp"/>
	</div>
	<!--header --> 
  
	<!--container -->
	<div class="container_wrap">
		<div id="container"> 
		    
			<!--content wrap -->
			<div class="content_wrap">
				<div id="snb">
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu6.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 계정신청 &gt; <span class="point">계정신청</span></p>
					<h3>계정신청</h3>
					<!-- Navi -->
					<div class="list_type01">
						<img src="/images/new/account_info3.png"alt="신청완료"/>
					</div>
					 <h4>신청완료</h4>
					 <div class="section_table02">
						<div style="text-align:right;"> 
							<a href="javascript:fnPrint();"><img src="/images/new/btn_print.gif"alt="인쇄하기"/></a>
							<a href="javascript:fnPdf()"><img src="/images/new/btn_pdf.gif"alt="pdf"/></a>
						</div>
						<table width="756" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="200" />
								<col />
							</colgroup>
							<tr>
								<th>관련기관</th>
								<td class="text_l">
									${memberVO.deptNoName}
								</td>
							</tr>
							<tr>
								<th>직급(위)</th>
								<td class="text_l">
									${memberVO.gradeName}
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td class="text_l">
									${memberVO.memberName}
								</td>
							</tr>
							<tr>
								<th>아이디</th>
								<td class="text_l">
									${memberVO.memberId}
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td class="text_l">
									${memberVO.email}
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td class="text_l">
									<div style="margin-top:5px">
										사무실: ${memberVO.officeNo}
									</div>
									<div style="margin-top:5px">
										핸드폰:${memberVO.mobileNo}
									</div>
									<div style="margin-top:5px; margin-bottom:5px;">
										<span style="margin-right:12px;">팩</span>스:${memberVO.faxNum}
									</div>
								</td>
							</tr>
							<tr>
								<th>비고</th>
								<td class="text_l">
									${memberVO.bigo}
								</td>
							</tr>
						</table>
						<div>
							<span style="color:red;padding-top:5px;padding-bottom:5px;">※계정 승인을 위해 신청완료 폼을 출력 또는 다운로드 받은 후 전자문서로 보내주시기 바랍니다.</span><br />
							<span>※보내실 곳 : waterkorea@keco.or.kr 또는 032-590-3903, 3904</span>
						</div>
					</div>	
					<div class="list_type01">
						<div style="text-align:right;">
							<a href="/index.do"><img src="/images/new/btn_confirm.gif"alt="확인"/></a>
						</div>
					</div>
				</div>
			</div>
			<!--content wrap --> 
		    
		</div>
	</div>
	<!--container --> 
  
	<!--footer -->
	<div class="footer_wrap">
		<div id="footer">
			<c:import url="/WEB-INF/jsp/pub/include/client_footer.jsp" />
		</div>
	</div>
	<!--footer --> 
  
</div>
<!-- wrap -->

</body>
</html>