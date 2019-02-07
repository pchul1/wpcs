<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertLaw.jsp
	 * Description : 경보기준설정 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			 수정내용
	 * -------		--------	---------------------------
	 * 2010.05.17	k			최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 *
	 * author k
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by k  All right reserved.
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

						<form id="listFrm" name="listFrm" action="/alert/mergeAlertConfigTime.do" >
							<!-- 수질 기준 설정 추가,삭제, 저장 -->
							<div class="table_wrapper">
								<div class="overBox">
									<table summary="경보기준정보" >
										<colgroup>
											<col width="100px" />
											<col width="120px" />
											<col width="100px" />
											<col width="*" />
											<col width="150px" />
											<col width="180px" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">측정 항목</th>
												<td>시스템</td>
												<th scope="col">구분</th>
												<td>경보발생 알림설정</td>
												<th scope="col">경보지속시간 설정</th>
												<td><select name="alert_delay_time">
												<c:forEach var="i" begin="1" end="24">
													<option value="<c:out value="${i}"/>"
													<c:if test="${View.alert_delay_time eq i}">selected="selected"</c:if>
													><c:out value="${i}"/></option>
												</c:forEach>
												</select>시간</td>
											</tr>
											<tr>
												<th scope="col">세부내용</th>
												<td colspan="3">설정한 시간동안 지속된(동일한) 경보에 대해서 SMS를 발송하지 않습니다.</td>
												<th scope="col">저장일시</th>
												<td><c:out value="${View.reg_date}"/></td>
											</tr>
										</thead>
									</table>
								</div>
							</div>
							<div id="btArea">
								<span id="p_total_cnt">&nbsp;</span>
								<input type="submit" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" alt="저장" />
							</div>
						</form>
						<!-- //수질 기준 설정 추가,삭제, 저장 -->
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