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
<script type="text/javascript">
	function MM_openBrWindow(theURL,winName,features) { //v2.0
		window.open(theURL,winName,features);
	}
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
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu2.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 시스템소개 &gt; <span class="point">대비</span></p>
					<h3>대비</h3>
					<!-- Navi -->
						<h4>방제 물품 관리 기능 및 분포 현황 제공</h4>
						 <div class="section_table03">
							<table width="756" border="0" cellspacing="0" cellpadding="0" summary="구분1,구분2,구분3,메뉴 기능">
								<caption>방제 물품 관리 기능 및 분포 현황</caption>
								<tr>
									<th>구분1</th>
									<th>구분2</th>
									<th>구분3</th>
									<th>메뉴 기능 </th>
								</tr>
								<tr>
									<td rowspan="10">방제정보관리</td>
									<td rowspan="6">기초정보</td>
									<td>방제물품 창고관리 </td>
									<td style="text-align:left;padding-left:5px;">방제 물품 보유 창고 현황 및 관리 담당자 정보 조회 </td>
								</tr>
								<tr>
									<td>신규 방제물품 창고관리 </td>
									<td style="text-align:left;padding-left:5px;">방제 물품 보유 창고 신규 등록 및 관리</td>
								</tr>
								<tr>
									<td>방제물품 분류관리 </td>
									<td style="text-align:left;padding-left:5px;">분류 코드별 방제 장비, 방제 물품 조회 및 관리</td>
								</tr>
								<tr>
									<td>방제물품 물품관리 </td>
									<td style="text-align:left;padding-left:5px;">방제 물품 사고 적용 정보, 사용유무 등 관리 정보 등록 및 조회</td>
								</tr>
								<tr>
									<td>방제물품 입출내역 </td>
									<td style="text-align:left;padding-left:5px;">방제 물품의 입고, 출고 내역 정보를 통한 재고현황 조회</td>
								</tr>
								<tr>
									<td>방제물품 보유현황 </td>
									<td style="text-align:left;padding-left:5px;">수계별, 창고별, 물품별 보유 현황 조회</td>
								</tr>
								<tr>
									<td rowspan="4">방제물품관리</td>
									<td>방제업체관리</td>
									<td style="text-align:left;padding-left:5px;">방제 업체 등록 및 업체 정보, 보유 물품 정보, 위치 정보 조회</td>
								</tr>
								<tr>
									<td>방제물품 현황관리 </td>
									<td style="text-align:left;padding-left:5px;">방제 물품의 상세 정보 제공</td>
								</tr>
								<tr>
									<td>방제물품 정산관리 </td>
									<td style="text-align:left;padding-left:5px;">방제 물품 관련 비용, 청구서 출력 등 정산관련 업무 지원</td>
								</tr>
								<tr>
									<td>방제물품 코드관리 </td>
									<td style="text-align:left;padding-left:5px;">방제 물품 관련 코드 정보 입력 및 조회</td>
								</tr>
								<tr>
									<td colspan="3">방제지원 메뉴얼</td>
									<td style="text-align:left;padding-left:5px;">방제 지원 매뉴얼 제공</td>
								</tr>
							</table>
						</div>
					<div class="list_type01" style="margin-top:40px;">
						<img src="/images/new/preventSupport.png"alt="대비"/>
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