<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovBoardMstrList.jsp
	 * Description : 게시판속성목록 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    	--------    ---------------------------
	 * 2009.03.12 	이삼섭			 최초 생성
	 * 2013.11.01	lkh			리뉴얼
	 *
	 * author 
	 * since 2009.03.12
	 *  
	 * Copyright (C) 2009 by 이상성 All right reserved.
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

<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />"></script>

<script type="text/javascript">
	$(function () {
		setDate();
	});
	
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_brdMstr('1');
		}
	}
	
	function fn_egov_select_brdMstr(pageNo){
		
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/admin/access/AccessIndiList.do'/>";
		document.frm.submit();	
	}
	
	function setDate(){

		selectedSugyeInMemberId(user_riverid , 'sugye');
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#sdate").datepicker({
			buttonText: '시작일'
			
		});
		$("#edate").datepicker({
			buttonText: '종료일'
		});
		
		var today;
		var yday;
		
		if('' != '<c:out value="${param_s.sdate}"/>'){
			yday = '<c:out value="${param_s.sdate}"/>'; 
		}
		
		if('' != '<c:out value="${param_s.edate}"/>'){
			today = '<c:out value="${param_s.edate}"/>'; 
		}
		
		$("#sdate").val(yday);
		$("#edate").val(today);
	}

	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
	
	function excelDown() {
		document.frm.action = "<c:url value='/admin/access/AccessIndiListExcel.do'/>";
		document.frm.submit();
	}
</script>
</head>

<body>
<%-- 	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div> --%>
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

						<form name="frm" method="post">
							<input type="hidden" name="bbsId">
							<input type="hidden" name="trgetId">
							
							<!--top Search Start-->
							<div class="topBx">
								기간 :
								<input id="sdate" name="sdate" type="text" size="13" >&nbsp;~
								<input id="edate" name="edate" type="text" size="13" >
							   	&nbsp;&nbsp;&nbsp; 아이디 :
								<input name="searchKeyword" type="text" size="35" value="<c:out value="${param_s.searchKeyword}"/>"  maxlength="35" >
								<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:fn_egov_select_brdMstr('1');" alt="조회" />
								<input type="button" id="excel" name="excel" class="btn btn_excel"  onclick="javascript:excelDown();" alt="엑셀">
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
								<table summary="게시판정보">
									<colgroup>
										<col width="5%">
										<col width="20%">
										<col width="20%">
										<col width="15%">
										<col width="20%">
										<col width="20%">
									</colgroup>
									<thead> 
										<tr> 
											<th>순번</th>
											<th>로그인ID</th>
											<th>수행업무</th>
											<th>테이블명</th>
											<th>접속자IP</th>
											<th>접속일</th>
										</tr> 
									</thead>
									<tbody>
										<c:forEach var="result" items="${resultList}" varStatus="status">
											<c:set var="even" value="" />
											<c:if test="${status.count%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
											<tr class="<c:out value="${even}"/>">
												<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td> 
												<td><c:out value="${result.loginId}"/> </td>
												<td><c:out value="${result.type}"/> </td>
												<td><c:out value="${result.tableNm}"/> </td>
												<td><c:out value="${result.connectIp}"/> </td>
												<td><c:out value="${result.regDate}"/> </td>
											</tr> 
										</c:forEach>
										<c:if test="${fn:length(resultList) == 0}">
										<tr>
										   	<td colspan="6"><spring:message code="common.nodata.msg" /></td>  
										</tr>		 
										</c:if>
									</tbody>
								</table>
							</div>
							<div class="paging">
								<div id="page_number">
									<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="fn_egov_select_brdMstr" />
								</div>
							</div>
							<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						</form>
					
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