<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : seminarRegistList.jsp
	 * Description : 교육등록 현황 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    			--------    ---------------------------
	 * 2014.09.19		mypark		최초생성
	 *
	 * author mypark
	 * since 2014.09.19
	 *  
	 * Copyright (C) 2014 by 이용 All right reserved.
	 */  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[

    $(document).ready(function() {
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		$("#searchBgnDe").datepicker({
			buttonText: '시작일'
			
		});
		$("#searchEndDe").datepicker({
			buttonText: '종료일'
		});
	});

	function press(event) {
		if (event.keyCode==13) {
			fn_egov_List('1');
		}
	}
	
	function fn_regist() {
		document.frm.action = "<c:url value='/seminar/SeminarRegist.do'/>";
		document.frm.submit();
	}
	
	function commonWork() {
		var stdt = document.getElementById("searchBgnDe");
		var endt = document.getElementById("searchEndDe");

		if(endt.value != '' && stdt.value > endt.value) {
			alert("교육기간 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
	}
	
	function fn_egov_List(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/seminar/SeminarRegistList.do'/>";
		document.frm.submit();
	}
	
	function fn_egov_View(seminarId) {
		document.frm.seminarId.value = seminarId;
		document.frm.action = "<c:url value='/seminar/SeminarView.do'/>";
		document.frm.submit();
	}
	
	function excelDown() {
		document.frm.action = "<c:url value='/seminar/RegistListExcel.do'/>";
		document.frm.submit();
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
					<div class="tab_container">
						<!-- 버튼 메뉴 -->
						<form name="frm" action ="" method="post">
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
							<input type="hidden" name="seminarId" id="seminarId"/>
							<input type="hidden" name="urlStr" value="SeminarRegistList.do" />
							<!--top Search Start-->
							<div class="searchBox dataSearch">
								<ul>
									<li>
										<span class="fieldName">교육기간&nbsp;&nbsp;</span>
										<input type="text" id="searchBgnDe" name="searchBgnDe" size="13" value="<c:out value="${searchVO.searchBgnDe}"/>" onchange="commonWork()" alt="조회시작일"/>
										<span>~</span>
										<input type="text" id="searchEndDe" name="searchEndDe" size="13" value="<c:out value="${searchVO.searchEndDe}"/>" onchange="commonWork()" alt="조회종료일"/>
									</li>
									<li>
										<span class="fieldName">상태&nbsp;&nbsp;</span>
										<select name="searchStatus" id="searchStatus" class="select">
										<option value="">전체</option>
										<option value="S" <c:if test="${searchVO.searchStatus == 'S'}">selected="selected"</c:if>>대기</option>
										<option value="A" <c:if test="${searchVO.searchStatus == 'A'}">selected="selected"</c:if>>승인</option>
										<option value="D" <c:if test="${searchVO.searchStatus == 'D'}">selected="selected"</c:if>>불허</option>
										</select>
									</li>
									<li>
										<span class="fieldName">검색&nbsp;&nbsp;</span>
										<select name="searchCnd" id="searchCnd" class="select">
											<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >전체</option>
											<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >교육명</option>
											<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >교육내용</option>
										</select>
										<input type="text" name="searchWrd" id="searchWrd" size="50"  class="inputText" value='<c:out value="${searchVO.searchWrd}"/>' onkeypress="press(event);" title="검색어입력" />
									</li>
								</ul>
							</div>
							<div class="btnSearchDiv">
								<input type="button" id="btnSearch" name="btnSearch"  value="조회하기" class="btn btn_search" onclick="javascript:fn_egov_List('1');" alt="조회하기" style="float:right;">
							</div>
							<!--top Search End-->
							<div id="btArea">
								<span id="p_total_cnt">▶ 검색결과 (총 ${resultCnt}건)</span>
 								<input type="button" id="excel" name="excel" class="btn btn_excel"  onclick="javascript:excelDown();" alt="엑셀">
							</div>
							<!-- 글목록 내용 -->
							<div class="table_wrapper">
								<table summary="게시판 리스트. 번호, 교육명, 교육기간, 담당자, 연락처, 작성자, 등록일, 구분, 상태가 담김">
									<colgroup>
										<col width="50" />
										<col />
										<col width="120" />
										<col width="100" />
										<col width="120" />
										<col width="100" />
										<col width="100" />
										<col width="80" />
										<col width="60" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">No.</th>
											<th scope="col">교육명</th>
											<th scope="col">교육기간</th>
											<th scope="col">담당자</th>
											<th scope="col">연락처</th>
											<th scope="col">작성자</th>
											<th scope="col">등록일</th>
											<th scope="col">구분</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="i" value="0" />
										<c:forEach var="result" items="${resultList}" varStatus="status">
											<c:set var="i" value="${i+1}" />
											<c:set var="even" value="" />
											<c:if test="${i%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
										<tr class="<c:out value="${even}"/>">
											<td>
												<c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/>
											</td>
											<td class="con" style="text-align:left; padding:0px 10px;">
												<a href="javascript:fn_egov_View('<c:out value="${result.seminarId}"/>')">
												<u><c:out value="${result.seminarTitle}"/></u></a>
											</td>
											<td><c:out value="${result.seminarDate}"/></td>
											<td><c:out value="${result.seminarLectName}"/></td>
											<td><c:out value="${result.seminarLectTel}"/></td>
											<td><c:out value="${result.writerName}"/></td>
											<td><c:out value="${result.regDate}"/></td>
											<td><c:out value="${result.seminarGubunName}"/></td>
											<td><c:out value="${result.seminarStateName}"/></td>
										</tr>
										</c:forEach>
										
										<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td class="listCenter" colspan="9" ><spring:message code="common.nodata.msg" /></td>
											</tr>
										</c:if>
									</tbody>
								</table>
								<!-- 페이징 -->
								<div class="paging">
									<div id="page_number">
										<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_List" />
									</div>
								</div>
								<!-- //페이징 -->
								<div style="text-align:left;font-weight:bold;">
										대기 상태일 경우에만 수정/삭제가 가능합니다.
								</div>
								<!-- 버튼 메뉴 -->
								<div id="btArea">
								<span id="menuAuth1">
									<input type="button" id="btnRegist" name="btnRegist" value="교육등록" class="btn btn_basic" onclick="javascript:fn_regist();" alt="교육등록" />
								</span>
								</div>
								<!-- //버튼 메뉴 -->
							</div>
							<!-- //글목록 내용 -->
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
	<script language="javascript">
	function menuAuth(auth){
		var iauthC ="";
		var iauthU ="";
		var iauthD ="";
		if(auth == "C"){
			iauthC ="Y";
		}
		if(auth == "U"){
			iauthU ="Y";
		}
		if(auth == "D"){
			iauthD ="Y";
		}
		var menuAuth = ""	;
		$.ajax({	
			type:"post",
			url: "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
			dataType:"json",
			async: false,
			data:{
				userId:$("#userId").val(),
				menuId:$("#naviMenuNo").val(),
				authC:iauthC,
				authU:iauthU,
				authD:iauthD
			},
			success : function(result){
				var tot = 0;
				 tot = result['getUserMenuAuthorCount'];
				 menuAuth = tot;
			}
		});
		return menuAuth;
	}
	if("1" == menuAuth("C")){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	</script>
</body>
</html>