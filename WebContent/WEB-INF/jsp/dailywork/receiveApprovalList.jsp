<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : receiveApprovalList.jsp
	 * Description : 받은결재
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 							최초작성
	 * 2014.10.02	yrkim	
	 * 
	 * author 
	 * since 2014.10.02
	 * 
	 * Copyright (C) 2014 by lkh All right reserved.
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

<%
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
%>

<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
    $(document).ready(function() {
    	// 체크 박스 모두 체크
		$("#checkAll").click(function() {
			if($(this).attr("checked")== "checked"){
				$("input[name=checkNo]").attr("checked", true);
			}else{
				$("input[name=checkNo]").attr("checked", false);
			}
			
		});
    	
		$("input[name=checkNo]").click(function() {
			$("input[name=checkAll]").attr("checked", false);
		});
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		$("#startDate").datepicker({
			buttonText: '시작일'
			
		});
		$("#endDate").datepicker({
			buttonText: '종료일'
		});
	});
    
    function fn_receive_list(){
		document.frm.action = "<c:url value='/dailywork/receiveApprovalList.do'/>";
		document.frm.submit();			
	}
    
    function fn_egov_select_receive_list(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/dailywork/receiveApprovalList.do'/>";
		document.frm.submit();	
	}
    
 	 //상세페이지이동
	function fnGoDetail(dailyWorkId, gubun, seq, state){
		var varForm				= document.all["goDetailForm"];
		var appCheck = "";
		if(state=='B'){
			appCheck = "Y";
		}else{
			appCheck = "N";
		}
		varForm.action			= "<c:url value='/dailywork/receiveApprovalDetail.do'/>";
		varForm.dailyWorkId.value	= dailyWorkId;
		varForm.gubun.value	= gubun;
		varForm.approvalSeq.value	= seq;
		varForm.appCheck.value	= appCheck;
		varForm.submit();
	}
  	

  	function fnApp(appGubun){
		var form = document.frm;
		var msg = "";
		if(appGubun=='return'){
			msg = "반려"; 
		}else{
			msg = "결재"; 
		}
		
		if ( $('input:checkbox[name="checkNo"]:checked').length > 0 ){
			if(confirm(msg+"하시겠습니까?")){
				var chked_val = "";
				$(":checkbox[name='checkNo']:checked").each(function(pi,po){
					chked_val += ","+po.value;
				});
				
				if(chked_val!="")chked_val = chked_val.substring(1);
//  				alert(chked_val);
				form.checkDailyWorkId.value = chked_val;
				if(appGubun=='return'){
					form.action	= "<c:url value='/dailywork/approvalReturnProc.do'/>";
				}else{
					form.action	= "<c:url value='/dailywork/approvalProc.do'/>";
				}
				//form.pageIndex.value  = 1;
				form.submit();
			}
    	}else{
    		alert("일지를 선택해주세요.");
			return false;
    	}
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
					<form id="goDetailForm" name="goDetailForm" method="post">
						<input type="hidden" id="dailyWorkId" name="dailyWorkId"/>
						<input type="hidden" id="gubun" name="gubun"/>
						<input type="hidden" id="approvalSeq" name="approvalSeq"/>
						<input type="hidden" id="appCheck" name="appCheck"/>
						<input type="hidden" id="pageNo" name="pageNo" value="${searchVO.pageIndex }"/>
					</form>	
					<!--tab Contnet Start-->
					<div class="tab_container">
						<form name="frm" action ="" method="post">
							<input type="hidden" name="checkDailyWorkId" id="checkDailyWorkId"/>
							<!-- 일반 게시판 -->
									<!-- 현 페이지 경로 -->
									<!--top Search Start-->
									<div class="searchBox dataSearch">
										<div class="searchImgDiv">
										<ul>
											<li>
												<span class="fieldName">일자</span>
												<input type="text" id="startDate" name="startDate" size="13" value="<c:out value="${searchVO.startDate}"/>" alt="조회시작일"/>
												<span>~</span>
												<input type="text" id="endDate" name="endDate" size="13" value="<c:out value="${searchVO.endDate}"/>" alt="조회종료일"/>
											</li>
											<li>
												<span class="fieldName">구분</span>
												<select name="searchGubun" id="searchGubun" class="select">
												<option value="">전체</option>
												<option value="S" <c:if test="${searchVO.searchGubun == 'S'}">selected="selected"</c:if>>상황실근무일지</option>
												<option value="R" <c:if test="${searchVO.searchGubun == 'R'}">selected="selected"</c:if>>4대강주요수계일지</option>
												<option value="M" <c:if test="${searchVO.searchGubun == 'M'}">selected="selected"</c:if>>조류모니터링</option>
												<option value="C" <c:if test="${searchVO.searchGubun == 'C'}">selected="selected"</c:if>>점검및사용일지</option>
												</select>
											</li>
											<li>
												<span class="fieldName">상태</span>
												<select name="searchState" id="searchState" class="select">
												<option value="">전체</option>
												<option value="B" <c:if test="${searchVO.searchState == 'B'}">selected="selected"</c:if>>결재대기</option>
												<option value="A" <c:if test="${searchVO.searchState == 'A'}">selected="selected"</c:if>>결재진행</option>
												<option value="R" <c:if test="${searchVO.searchState == 'R'}">selected="selected"</c:if>>결재반려</option>
												<option value="F" <c:if test="${searchVO.searchState == 'F'}">selected="selected"</c:if>>결재완료</option>
												</select>
											</li>
										</ul>
										</div>
									</div>
									<div class="btnSearchDiv">
										<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:fn_receive_list();" alt="조회하기" style="float:right;">
									</div>
									<!--top Search End-->
									<div id="btArea">
										<span id="p_total_cnt">[총 <c:out value="${resultCnt}"/>건]</span>
									</div>
									<!-- 글목록 내용 -->
									<div class="table_wrapper">
										<table summary="checkbox, No, 구분, 일자, 결재요청자, 결재요청일, 상태">
											<colgroup>
												<col width="30" />
												<col width="80" />
												<col />
												<col width="150" />
												<col width="150" />
												<col width="150" />
												<col width="150" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><input type="checkbox" id="checkAll" name="checkAll"/></th>
													<th scope="col">No.</th>
													<th scope="col">구분</th>
													<th scope="col">일자</th>
													<th scope="col">결재요청자</th>
													<th scope="col">결재요청일</th>
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
												<tr  class="<c:out value="${even}"/>">
													<td>
														<c:if test="${result.state == 'B' or result.state == 'R'}"><input type="checkbox" id="checkNo" name="checkNo" value="<c:out value='${result.dailyWorkId}'/>;<c:out value='${result.dailyWorkseq}'/>;<c:out value='${result.workDay}'/>" /></c:if>
													</td>
													<td>
														<c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/>
													</td>
													<td onclick='javascript:fnGoDetail("<c:out value="${result.dailyWorkId}"/>", "<c:out value="${result.gubun}"/>", <c:out value='${result.dailyWorkseq}'/>, "<c:out value='${result.state}'/>");' style="cursor: pointer;"><u><c:out value='${result.gubunName}'/></u></td>
													<td onclick='javascript:fnGoDetail("<c:out value="${result.dailyWorkId}"/>", "<c:out value="${result.gubun}"/>", <c:out value='${result.dailyWorkseq}'/>, "<c:out value='${result.state}'/>");' style="cursor: pointer;"><u><c:out value='${result.workDay}'/></u></td>
													<td><c:out value='${result.approvalRequestId}'/></td>
													<td><c:out value='${result.approvalRequestDate}'/></td>
													<td><c:out value='${result.stateName}'/></td>
												</tr>
												</c:forEach>
												<c:if test="${fn:length(resultList) == 0}">
													<tr>
														<td class="listCenter" colspan="7" ><spring:message code="common.nodata.msg" /></td>
													</tr>
												</c:if>
											</tbody>
										</table>
										
									<!-- 페이징 -->
									<div class="paging">
										<div id="page_number">
											<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_receive_list" />
										</div>
									</div>
									<!-- //페이징 -->
									
									<!-- 버튼 메뉴 -->
									<div>
										<input type="button" id="btnApp" value="결재" class="btn btn_basic" style="float:right" alt="결재" onclick="javascript:fnApp('app')"/>
										<input type="button" id="btnReturn" value="반려" class="btn btn_basic" style="float:right" alt="반려" onclick="javascript:fnApp('return')"/>
									</div>
									<!-- //버튼 메뉴 -->
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>	
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
</body>
</html>