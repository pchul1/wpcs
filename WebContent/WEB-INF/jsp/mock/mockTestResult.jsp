<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />		
	<script>	
		$(function(){
			$('#saveBtn').click(function () {		
				save();
			});					
		});

		function validation()
		{
			if($("#mockTitle").val() == "")
			{
				alert("모의제목을 입력해 주세요");
				$("#mockTitle").focus();
				return false;
			}

			return true;
		}
	
		function save() {
			
			if(validation())
			{
				document.mockTestSaveFrm.action = "<c:url value='/mock/mockTestSave.do'/>";			
				document.mockTestSaveFrm.submit(); 						
			}
			else
			{
				return false;
			}

			return true;
		} 
	</script>	
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
		<form name="mockTestSaveFrm" method="post" onsubmit="return false">
		<input type="hidden" name="riverId" value="${riverId}" />
		<div id="content" class="sub_situationmng">
			<div class="content_wrap page_correlation">
				<div class="inner_inCorrelation">
					<h3 class="PointTit">모의 분석 결과</h3>
					<!-- 현 페이지 경로 -->
					<p class="locationSta">홈 > 상황 관리 &gt; 상황 관계 분석 &gt; 모의 분석 결과</p>
					<!-- //현 페이지 경로 -->
					<ul class="inCorrelation_view1">
						<li class="first">			
							<p class="tit">[등속 구간]</p>
							<table class="dataTable">
								<colgroup>
									<col width="50px" />
									<col width="106px" />
									<col width="106px" />
									<col width="106px" />
									<col width="" />
								</colgroup>
								<tr>
									<th scope="col">순서</th>
									<th scope="col">수계</th>
									<th scope="col">등속 구간</th>
									<th scope="col">분석 유량</th>
									<th scope="col">유하 시간</th>
								</tr>
							</table>
							<div class="over_con_dataTable">
								<table class="dataTable">
									<colgroup>
										<col width="50px" />
										<col width="106px" />
										<col width="106px" />
										<col width="106px" />
										<col width="" />
									</colgroup>
									<c:forEach items="${sectionList}" var="section" varStatus="status">
									<tr>
										<td>
											${status.index+1}
											<input type="hidden" name="mockSectionOrder" value="${status.index+1}" />
											<input type="hidden" name="mockSectionId" value="${section.sectionId}" />
											<input type="hidden" name="mockFlow" value="${section.newFlow}" />
											<input type="hidden" name="mockFlowTime" value="${section.newEndTime}" />											
										</td>
										<td>${section.riverName}</td>
										<td>${section.sectionName}</td>
										<td>${section.newFlow}</td>
										<td>${section.newEndTime}</td>
									</tr>									
									</c:forEach>
									<tr>
										<td colspan="4"></td>
										<td>${sectionTot}</td>
									</tr>
								</table>
							</div>
						</li>
						<li>
							<p class="tit">[주요 지점]</p>
							<table class="dataTable">
								<colgroup>
									<col width="50px" />
									<col width="215px" />
									<col width="" />
								</colgroup>
								<tr>
									<th scope="col">순서</th>
									<th scope="col">주요 지점</th>
									<th scope="col">유하 시간</th>
								</tr>
							</table>
							<div class="over_con_dataTable">
								<table class="dataTable">
									<colgroup>
										<col width="50px" />
										<col width="215px" />
										<col width="" />
									</colgroup>
									<c:forEach items="${pointList}" var="point" varStatus="status">
									<tr>
										<td>
											${status.index+1}
											<input type="hidden" name="mockPointOrder" value="${status.index+1}" />
											<input type="hidden" name="mockPointId" value="${point.pointId}" />
											<input type="hidden" name="mockPointFlowTime" value="${point.newEndTime}" />											
										</td>
										<td>${point.pointName}</td>
										<td>${point.newEndTime}</td>
									</tr>									
									</c:forEach>
									<tr>
										<td colspan="2"></td>
										<td>${pointTot}</td>
									</tr>
								</table>
							</div>
						</li>
					</ul>
					<div class="inCorrelation_view2">
						<div>
							<table class="dataTable">
								<colgroup>
									<col width="150px" />
									<col />
								</colgroup>
								<tr>
									<th scope="row">수계</th>
									<td>${riverName}</td>
								</tr>
								<tr>
									<th scope="row">모의 제목</th>
									<td><input type="text" class="inputText" id="mockTitle" name="mockTitle" style="width:500px" /></td>
								</tr>
								<tr>
									<th scope="row">기타</th>
									<td><input type="text" class="inputText" name="mockEtc" style="width:500px" /></td>
								</tr>
							</table>
							<p><input id="saveBtn" type="image" src="<c:url value='/images/common/btn_resultSave.gif'/>" alt="모의 결과 저장" /></p>
						</div>
					</div>
				</div>
			</div>
		</div><!-- //content -->
		</form>

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
