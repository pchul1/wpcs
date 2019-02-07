<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>
<%
	/**
	* Class Name : KeywordList.jsp
	* Description : 비밀번호관리 화면
	* Modification Information
	* 
	* 수정일			수정자					수정내용
	* -------		--------	---------------------------
	* 2013.01.13	~			최초 생성
	* 2013.11.01	lkh			리뉴얼
	* 
	* author
	* since 2013.01.13
	* 
	* Copyright (C) 2013 by ~ All right reserved.
	*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
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
					<div class="tab_container">
						<div class="table_wrapper">
							<table summary="연계현황관리">
								<colgroup>
									<col width="200" />
									<col width="100" />
									<col width="100" />
									<col width="*" />
									<col width="200" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">연계기관</th>
										<th scope="col">연계방식</th>
										<th scope="col">연결상태</th>
										<th scope="col">설명</th>
										<th scope="col">최종 수신 일자</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>수질자동 측정망</td>
										<td>SOAP</td>
										<td style="font-size: 30px;<c:if test='${Water.time >= pj:getDayofString("yyyy/MM/dd HH:mm","-2")}'>color:green;</c:if><c:if test='${!(Water.time >= pj:getDayofString("yyyy/MM/dd HH:mm","-2"))}'>color:red;</c:if>">●</td>
										<td>4 대강 유역의 주요 하천과 호수에 대한 수질, 수위 등 측정지점 데이터 수집</td>
										<td><c:out value="${Water.time}"/></td>
									</tr>
									<tr class="even">
										<td>국립환경과학원</td>
										<td>SOAP</td>
										<td style="font-size: 30px;<c:if test='${Nier.time >= pj:getDayofString("yyyy/MM/dd HH:mm","-2")}'>color:green;</c:if><c:if test='${!(Nier.time >= pj:getDayofString("yyyy/MM/dd HH:mm","-2"))}'>color:red;</c:if>">●</td>
										<td>WINS 정보 연계 및 유량,수위 정보 
										<td><c:out value="${Nier.time}"/></td>
									</tr>
									<tr>
										<td>기상청</td>
										<td>SOAP</td>
										<td style="font-size: 30px;<c:if test='${Weather.time >= pj:getDayofString("yyyy/MM/dd HH:mm","-2")}'>color:green;</c:if><c:if test='${!(Weather.time >= pj:getDayofString("yyyy/MM/dd HH:mm","-2"))}'>color:red;</c:if>">●</td>
										<td>4대강 유역의 기상정보 데이터를 수집 (기상특보, 기상예보, 강우량 정보)</td>
										<td><c:out value="${Weather.time}"/></td>
									</tr>
									<tr class="even">
										<td>TMS</td>
										<td>DB LINK</td>
										<td style="font-size: 30px;<c:if test='${TMS.time >= pj:getDayofString("yyyy/MM/dd HH:mm","-2")}'>color:green;</c:if><c:if test='${!(TMS.time >= pj:getDayofString("yyyy/MM/dd HH:mm","-2"))}'>color:red;</c:if>">●</td>
										<td>사업장의 수질 오염 물질 배출 정보수집  (CCD,SS,pH 등)</td>
										<td><c:out value="${TMS.time}"/></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->

		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>