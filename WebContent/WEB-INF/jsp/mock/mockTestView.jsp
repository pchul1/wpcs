<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />			
</head>
<body>
<div id="wrap">
	<div id="header">
		<c:import url="/common/menu/header.do" />
	</div><!-- //header -->
	<div id="container">
		<!-- 사이드 리스트 -->
		<div id="snb" class="snb">
			<c:import url="/common/menu/left.do" />
		</div>
		<!-- //사이드 리스트 -->
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
		
		<!-- content -->
		<div id="content" class="sub_situationmng">
			<div class="content_wrap page_correlation">
				<div class="inner_careerMng">
					<h3 class="PointTit">모의 폐수 방출 모의 결과</h3>
					<!-- 현 페이지 경로 -->
					<p class="locationSta">홈 > 상황 관리 &gt; 상황 관계 분석 &gt; 이력관리 &gt; 결과 보기</p>
					<!-- //현 페이지 경로 -->
					<div class="view_result_box1">
						<table class="dataTable">
							<tr>
								<th scope="row">수계</th>
								<td>${mockTest.riverName}</td>
								<th scope="row">등록일</th>
								<td>${mockTest.regDate}</td>
							</tr>
							<tr>
								<th scope="row">제목</th>
								<td colspan="3">${mockTest.mockTitle}</td>
							</tr>							
							<tr>
								<th scope="row">기타</th>
								<td colspan="3">${mockTest.mockEtc}</td>
							</tr>
						</table>
					</div>
					<ul class="view_result_box2">
						<li class="first">
							<p>등속구간</p>
							<table class="dataTable titleTable">
								<colgroup>
									<col width="60px" />
									<col width="104px" />
									<col width="104px" />
									<col width="104px" />
									<col width="" />
								</colgroup>
								<tr>
									<th scope="col">순서</th>
									<th scope="col">수계</th>
									<th scope="col">등속구간</th>
									<th scope="col">분석 유량</th>									
									<th scope="col">유하시간</th>
								</tr>
							</table>
							<div class="over_con_table">
								<table class="dataTable conTable">
									<colgroup>
										<col width="60px" />
									<col width="104px" />
									<col width="104px" />
									<col width="104px" />
										<col width="" />
									</colgroup>
									<c:forEach items="${mockSectionList}"  var="mockSection"  varStatus="status">
									<tr>
										<td>${mockSection.order}</td>
										<td>${mockSection.riverName}</td>
										<td>${mockSection.sectionName}</td>
										<td>${mockSection.flow}</td>
										<td>${mockSection.flowTime}</td>										
									</tr>								
									</c:forEach>	
								</table>
							</div>
						</li>
						<li>
							<p>주요 지점</p>
							<table class="dataTable">
								<colgroup>
									<col width="60px" />
									<col width="200px" />
									<col width="" />
								</colgroup>
								<tr>
									<th scope="col">순서</th>
									<th scope="col">주요 지점</th>
									<th scope="col">유하시간</th>
								</tr>
							</table>
							<div class="over_con_table">
								<table class="dataTable conTable">
									<colgroup>
										<col width="60px" />
										<col width="200px" />
										<col width="" />
									</colgroup>
									<c:forEach items="${mockPointList}"  var="mockPoint"  varStatus="status">
									<tr>
										<td>${mockPoint.order}</td>
										<td>${mockPoint.pointName}</td>
										<td>${mockPoint.flowTime}</td>									
									</tr>								
									</c:forEach>	
								</table>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div><!-- //content -->

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
