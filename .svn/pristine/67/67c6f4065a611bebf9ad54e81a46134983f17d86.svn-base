<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css' />" />
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
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_alarmmng">
				<div class="inner_accdntact">
					<h3><img src="/images/waterpolmnt/h3_accdntact.gif" alt="사고 조치 관리" /></h3>
					<!-- 현 페이지 경로 -->
					<p class="location">홈 > 수질 오염 감시 > 경보 관리 > 사고 조치 관리</p>
					<!-- //현 페이지 경로 -->
					<!-- 사고 조치 관리 조회 -->
					<form action="" class="formBox">
						<fieldset>
							<legend class="hidden_phrase"></legend>
							<div class="roundBox">
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
								<div class="con">
									<div class="con_r">
										<!-- 검색 1단 -->
										<div class="lastList">
											<dl>
												<dt class="hidden"><label for="">수계 > 공구 > 측정소</label></dt>
												<dd>
													<select>
														<option value=""></option>
													</select>
													<span class="space">&gt;</span>
													<select id="">
														<option value=""></option>
													</select>
													<span class="space">&gt;</span>
													<select id="">
														<option value=""></option>
													</select>
													<span class="space">측정소</span>
												</dd>
												<dt><label for="">조회일자</label></dt>
												<dd>
													<input type="text" class="inputText" id="" />
													<a href="#"><img src="/images/common/ico_calendar.gif" alt="달력" /></a>
												</dd>
											</dl>
											<p class="btn"><input type="image" src="/images/common/btn_search.gif" alt="조회" /></p>
										</div>
									</div>
								</div>
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
							</div>
						</fieldset>
					</form>
					<!-- //사고 조치 관리 조회 -->
					<!-- 사고 조치 관리 현황 -->
					<div class="data_wrap">
						<div class="overBox">
							<table class="dataTable">
								<colgroup>
									<col width="200px" />
									<col width="150px" />
									<col width="120px" />
									<col width="120px" />
									<col />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">측정 일시</th>
										<th scope="col">공구</th>
										<th scope="col">측정소</th>
										<th scope="col">경보 구분</th>
										<th scope="col">방제 단계</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>2010-01-30 15:30:00</td>
										<td>영산강 6공구</td>
										<td>1측정소</td>
										<td>조류 경보</td>
										<td class="step"><span>상황전파>현장출동</span></td>
									</tr>
									<tr class="add">
										<td>2010-01-30</td>
										<td>한강 1공구</td>
										<td>2측정소</td>
										<td>관심</td>
										<td class="step"><span>상황전파>현장출동>방제조치>상황해제</span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- //사고 조치 관리 현황 -->
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
