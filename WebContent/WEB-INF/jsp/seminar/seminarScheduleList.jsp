<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : seminarScheduleList.jsp
	 * Description : 교육일정 목록 화면
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
//]]>

</script>

<script type="text/javascript">
	//교육 기간 검색 날짜 선택 체크
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
	
	//교육 등록 페이지 이동
	function fn_regist() {
		goMenu('/seminar/SeminarRegist.do','34200');
	}
	
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_List('1');
		}
	}
	
	//목록 페이지 이동
	function fn_egov_List(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/seminar/SeminarScheduleList.do'/>";
		document.frm.submit();
	}
	
	//상세페이지 보기 이동
	function fn_egov_View(seminarId) {
		document.frm.eduSeq.value = seminarId;
		document.frm.action = "<c:url value='/seminar/SeminarApplicationView.do'/>";
		document.frm.urlStr.value = "SeminarScheduleList.do";
		document.frm.submit();
	}
	
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
							<input type="hidden" name="urlStr" value="" />
							<input type="hidden" name="eduSeq" value="" />
							<!--top Search Start-->
							<div class="searchBox dataSearch">
								<ul>
									<li>
										<span class="fieldName">교육기관&nbsp;&nbsp;</span>
										<select name="searchGubun" id="searchGubun" class="select">
										<option value="">전체</option>
										<option value="EDU01" <c:if test="${searchVO.searchGubun == 'EDU01'}">selected="selected"</c:if>>환경보전협회</option>
										<option value="EDU02" <c:if test="${searchVO.searchGubun == 'EDU02'}">selected="selected"</c:if>>국립환경인력개발원</option>
										</select>
									</li>
									<li>
										<span class="fieldName">교육기간&nbsp;&nbsp;</span>
										<input type="text" id="searchBgnDe" name="searchBgnDe" size="13" value="<c:out value="${searchVO.searchBgnDe}"/>" onchange="commonWork()" alt="조회시작일"/>
										<span>~</span>
										<input type="text" id="searchEndDe" name="searchEndDe" size="13" value="<c:out value="${searchVO.searchEndDe}"/>" onchange="commonWork()" alt="조회종료일"/>
									</li>
									<li>
										<span class="fieldName">완료여부&nbsp;&nbsp;</span>
										<select name="searchClosingState" id="searchClosingState" class="select">
										<option value="">전체</option>
										<option value="Y" <c:if test="${searchVO.searchClosingState == 'Y'}">selected="selected"</c:if>>완료</option>
										<option value="N" <c:if test="${searchVO.searchClosingState == 'N'}">selected="selected"</c:if>>미완료</option>
										</select>
									</li>
									<%-- <li>
										<span class="fieldName">검색&nbsp;&nbsp;</span>
										<select name="searchCnd" id="searchCnd" class="select">
											<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >전체</option>
											<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >교육명</option>
											<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >교육내용</option>
										</select>
										<input type="text" name="searchWrd" id="searchWrd"  size="50" class="inputText" value='<c:out value="${searchVO.searchWrd}"/>' onkeypress="press(event);" title="검색어입력" />
									</li> --%>
								</ul>
							</div>
							<div class="btnSearchDiv">
								<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:fn_egov_List('1');" alt="조회하기" style="float:right;">
							</div>
							<!-- 총카운트 조회 -->
							<%-- <div class="table_wrapper">
								<table summary="게시판 리스트. 번호, 교육명, 교육기간, 교육시간, 담당자, 연락처, 교육장소, 참여인원, 구분, 마감여부가 담김">
									<colgroup>
										<col width="120" />
										<col width="120" />
										<col width="120" />
										<col width="120" />
										<col width="120" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">접수된 교육</th>
											<th scope="col">실시완료 교육</th>
											<th scope="col">실시예정 교육</th>
											<th scope="col">교육신청</th>
											<th scope="col">강사신청</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>${totACnt}</td>
											<td>${totCCnt}</td>
											<td>${totPCnt}</td>
											<td>${totSCnt}</td>
											<td>${totLCnt}</td>
										</tr>	
									</tbody>
								</table>
							</div> --%>
							<!-- 총카운트 조회 -->
							<!--top Search End-->
							<div id="btArea">
								<span id="p_total_cnt">▶ 검색결과 (총 ${resultCnt}건)</span>
 								<!-- <input type="button" id="excel" name="excel" class="btn btn_excel"  onclick="javascript:excelDown();" alt="엑셀"> -->
							</div>
							<!-- 글목록 내용 -->
							<div class="table_wrapper">
								<table summary="게시판 리스트. 번호, 교육명, 교육기간, 교육시간, 담당자, 연락처, 교육장소, 참여인원, 구분, 마감여부가 담김">
									<colgroup>
										<!-- <col width="30" />
										<col width="40" /> -->
										<col width="140" />
										<col />
										<!-- <col width="70" /> -->
										<col width="170" />
										<col width="70" />
										<col width="150" />
										<col width="150" />
										<col width="100" />
										<col width="70" />
										<!-- <col width="70" />
										<col width="70" /> -->
									</colgroup>
									<thead>
										<tr>
											<!-- <th scope="col"></th>
											<th scope="col">No.</th> -->
											<th scope="col">교육기관</th>
											<th scope="col">교육명</th>
											<!-- <th scope="col">구분</th> -->
											<th scope="col">교육기간</th>
											<th scope="col">지역</th>
											<th scope="col">교육장소</th>
											<th scope="col">강의시간</th>
											<th scope="col">교육주관</th>
											<th scope="col">완료여부</th>
											<!-- <th scope="col">구분</th>
											<th scope="col">마감여부</th> -->
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
											<%-- <td>
												<c:if test="${result.seminarClosingStateName == '신청가능'}">
													<input type="radio" name="checkSeminarId" value="${result.seminarId}">
												</c:if>
												<c:if test="${result.seminarClosingStateName != '신청가능'}">
													<input type="radio" name="checkSeminarId" value="${result.seminarId}" disabled="disabled">
												</c:if>
											</td>
											<td>
												<c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/>
											</td> --%>
											<td class="con" style="padding:0px 10px;">
												<a href="javascript:fn_egov_View('<c:out value="${result.eduSeq}"/>')">
												<u><c:out value="${result.eduOrgName}"/></u></a>
											</td>
											<td style="padding-top:5px; padding-bottom:5px;"><c:out value="${result.eduName}"/></td>
											<td><c:out value="${result.eduDateFrom}"/>&nbsp;~&nbsp;<c:out value="${result.eduDateTo}"/></td>
											<td><c:out value="${result.eduArea}"/></td>
											<td><c:out value="${result.eduPlace}"/></td>
											<td><c:out value="${result.lectureTime}"/></td>
											<td><c:out value="${result.eduSuper}"/></td>
											<td><c:out value="${result.finishYn}"/></td>
										</tr>
										</c:forEach>
										
										<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td class="listCenter" colspan="8" ><spring:message code="common.nodata.msg" /></td>
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
								<!-- 버튼 메뉴 -->
								<div id="btArea">
								<span id="menuAuth1">
									<!-- <input type="button" id="btnEntry" name="btnEntry" value="교육신청" class="btn btn_basic" onclick="javascript:fn_egov_Entry();" alt="교육신청" /> -->
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