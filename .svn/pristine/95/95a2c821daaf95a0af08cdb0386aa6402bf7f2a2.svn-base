<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : workJournalList.jsp
	 * Description : 업무일지 목록 조회
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 							최초작성
	 * 2018.01.03	choi hoe seop	
	 * 
	 * author 
	 * since 2018.01.03
	 * 
	 * Copyright (C) 2018 by Naturetech All right reserved.
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
    
    function fn_daily_work_list(){
    	document.frm.action = "<c:url value='/dailywork/workJournalList.do'/>";
		document.frm.submit();			
	}
    
    function fn_egov_select_daily_work_list(pageNo) {
    	
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/dailywork/workJournalList.do'/>";
		document.frm.submit();	
	}
    
    function fnRegist(){
    	document.frm.action = "<c:url value='/dailywork/workJournalRegist.do'/>";
		document.frm.submit();	
    }
    
	function abspos(e){
	     this.x = e.clientX + (document.documentElement.scrollLeft?document.documentElement.scrollLeft:document.body.scrollLeft);
	    this.y = e.clientY + (document.documentElement.scrollTop?document.documentElement.scrollTop:document.body.scrollTop);
	    return this;
	 }

	function fn_egov_downFile(atchFileId, fileSn){
		window.open("<c:url value='/cmmn/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
	}
	
	function fnDetailView(seq){
    	document.frm.action = "<c:url value='/dailywork/workJournalRegist.do'/>";
    	document.frm.seqNo.value = seq;
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
				<%
					//System.out.println("########################################################");
				%>
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
						<form name="frm" action ="" method="post">
							<input type="hidden" name="seqNo"/>
							<!-- 일반 게시판 -->
									<!-- 현 페이지 경로 -->
									<!--top Search Start-->
									<div class="searchBox dataSearch">
										<div class="searchImgDiv">
										<ul>
											<li>
												<span class="fieldName">지역본부</span>
												<select class="fixWidth7" name="deptName">
													<option value="">전체</option>
													<option value="1002"<c:if test="${searchVO.deptName == '1002'}"> selected="selected"</c:if>>수도권동부</option>
													<option value="1003"<c:if test="${searchVO.deptName == '1003'}"> selected="selected"</c:if>>충청권</option>
													<option value="1004"<c:if test="${searchVO.deptName == '1004'}"> selected="selected"</c:if>>대구경북</option>
													<option value="1005"<c:if test="${searchVO.deptName == '1005'}"> selected="selected"</c:if>>호남권</option>
												</select>
											</li>
											<li>
												<span class="fieldName">일자</span>
												<input type="text" id="startDate" name="startDate" size="13" value="<c:out value="${searchVO.startDate}"/>" alt="조회시작일"/>
												<span>~</span>
												<input type="text" id="endDate" name="endDate" size="13" value="<c:out value="${searchVO.endDate}"/>" alt="조회종료일"/>
											</li>
										</ul>
										</div>
									</div>
									<div class="btnSearchDiv">
										<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:fn_daily_work_list();" alt="조회하기" style="float:right;">
									</div>
									<!--top Search End-->
									<div id="btArea">
										<span id="p_total_cnt">[총 <c:out value="${resultCnt}"/>건]</span>
									</div>
									<!-- 글목록 내용 -->
									<div class="table_wrapper">
										<table summary="No, 일자, 상신일, 최초작성자, 결재요청자, 상태, 작성권한자, 첨부파일, 최종작성자 ">
											<colgroup>
												<col width="50" />
												<col width="100" />
												<col />
												<col width="150" />
												<col width="120" />
												<col width="120" />
												<col width="100" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">No.</th>
													<th scope="col">일자</th>
													<th scope="col">제목</th>
													<th scope="col">소속</th>
													<th scope="col">등록자</th>
													<th scope="col">등록일시</th>
													<th scope="col">첨부파일</th>
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
													<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
													<td><c:out value="${result.workDay}"/></td>
													<td style="text-align:left; padding:0px 10px;"><a href="javascript:fnDetailView('${result.seqNo}');"><c:out value="${result.title}"/></a></td>
													<td><c:out value="${result.deptName}"/></td>
													<td><c:out value="${result.regName}"/></td>
													<td><c:out value="${result.regDate}"/></td>
													<%-- <td><a href="javascript:fn_egov_downFile('<c:out value="${result.atchFileId}"/>','0')"><img src="<c:url value='/images/board/ico_file.gif'/>" alt="파일" /></a></td> --%>
													<td><a href="/cmmn/FileDown.do?atchFileId=${result.atchFileId}&fileSn=0"><img src="<c:url value='/images/board/ico_file.gif'/>" alt="파일" /></a></td>
												</tr>
												</c:forEach>
												<c:if test="${fn:length(resultList) == 0}">
													<tr>
														<td class="listCenter" colspan="7" >
															<spring:message code="common.nodata.msg" />
														</td>
													</tr>
												</c:if>
											</tbody>
										</table>
										
									<!-- 페이징 -->
									<div class="paging">
										<div id="page_number">
											<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_daily_work_list" />
										</div>
									</div>
									<!-- //페이징 -->
									
									<!-- 버튼 메뉴 -->
<%-- 									<sec:authorize ifAnyGranted="ROLE_ADMIN"> --%>
									<div id="menuAuth1">
										<input type="button" id="btnAdd" value="등록" class="btn btn_basic" style="float:right" alt="등록" onclick="javascript:fnRegist();"/>
									</div>
<%-- 									</sec:authorize> --%>
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
	/* if("1" == menuAuth("C")){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	} */
	</script>
</body>
</html>