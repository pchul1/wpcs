<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : checkUseList.jsp
	 * Description : 점검및사용일지 목록 조회
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 							최초작성
	 * 2018.01.15	choi heo seop	
	 * 
	 * author 
	 * since 2018.01.15
	 * 
	 * Copyright (C) 2018 by K-eco All right reserved.
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
    
    function fn_check_use_list(){
    	document.frm.action = "<c:url value='/dailywork/checkUseList.do'/>";
		document.frm.submit();			
	}
    
    function fn_egov_select_check_use_list(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/dailywork/checkUseList.do'/>";
		document.frm.submit();	
	}
    
    function fnRegist(){
   		document.frm.action = "<c:url value='/dailywork/checkUseRegist.do'/>";
		document.frm.submit();	
    }
    
 	//상세페이지이동
	function fnGoDetail(dailyWorkId, regId){
		var varForm				= document.all["goDetailForm"];
   		varForm.action			= "<c:url value='/dailywork/checkUseDetail.do'/>";
		varForm.dailyWorkId.value	= dailyWorkId;
		varForm.regId.value	= regId;
		varForm.submit();
	}
 	
	function abspos(e){
	     this.x = e.clientX + (document.documentElement.scrollLeft?document.documentElement.scrollLeft:document.body.scrollLeft);
	    this.y = e.clientY + (document.documentElement.scrollTop?document.documentElement.scrollTop:document.body.scrollTop);
	    return this;
	 }
	
	function fnAuthDetail(e, dailyWorkId) {
		fnAuthDetailClose('authDetail');
		fnApprovalInfoClose('approvalInfo');
		
		$.ajax({
			type:"post",
			url:"<c:url value='/dailywork/getDailyWorkAuthUserList.do'/>",
			data:{dailyWorkId:dailyWorkId
				},
			dataType:"json",
			success:function(result){
				var tot = result['authUserList'].length;
				var item = "";
				if(tot>0){
					for(var i=0; i< tot; i++){
						var obj = result['authUserList'][i];
						
						item += "<tr>"
							+"<td style='text-align:center;width:150px;'>"+obj.writeAuthName+"("+obj.writeAuthId+")</td>"
							+"</tr>";
					}
					$("#authName").html(item);
				}else{
					$("#authName").html("<tr><td style='text-align:center;width:150px;'>권한자가 없습니다.</td></tr>");
				}
			},
	        error:function(result){
					$("#authName").html("<tr><td style='text-align:center;width:150px;'>서버접속 실패</td></tr>");
		        }
		});
		
		 var divTop = e.clientY; //상단 좌표
		 var divLeft = e.clientX - 70; //좌측 좌표

		 var name="authDetail";
			
		var win = $(window);
		var winH = divTop;
		var winW =divLeft;
		$('#'+ name).css('top', winH);
		$('#'+ name).css('left', winW);
		$('#'+ name).show();
		$('#'+ name).focus();
		 
	}
	
	function fnAuthDetailClose() {
		$('#authDetail').hide();
	}
	
	function fnApprovalInfo(e, dailyWorkId) {
		fnApprovalInfoClose('approvalInfo');
		fnAuthDetailClose('authDetail');
		
		$.ajax({
			type:"post",
			url:"<c:url value='/dailywork/getDailyWorkAppovalInfo.do'/>",
			data:{dailyWorkId:dailyWorkId
				},
			dataType:"json",
			success:function(result){
				var tot = result['appovalInfoList'].length;
				var item = "";
				if(tot>0){
					for(var i=0; i< tot; i++){
						var obj = result['appovalInfoList'][i];
						
						item += "<tr>"
							+"<td style='text-align:center;width:150px;'>"+obj.approvalName+"("+obj.state+")<br>"+obj.approvalDate+"</td>"
							+"</tr>";
					}
					$("#approvalInfoName").html(item);
				}else{
					$("#approvalInfoName").html("<tr><td style='text-align:center;width:150px;'>승인 내역이 없습니다.</td></tr>");
				}
			},
	        error:function(result){
					$("#approvalInfoName").html("<tr><td style='text-align:center;width:150px;'>서버접속 실패</td></tr>");
		        }
		});
		
		 var divTop = e.clientY; //상단 좌표
		 var divLeft = e.clientX - 70; //좌측 좌표

		 var name="approvalInfo";
			
		var win = $(window);
		var winH = divTop;
		var winW =divLeft;
		$('#'+ name).css('top', winH);
		$('#'+ name).css('left', winW);
		$('#'+ name).show();
		$('#'+ name).focus();
		 
	}
	
	function fnApprovalInfoClose() {
		$('#approvalInfo').hide();
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
					<form id="goDetailForm" name="goDetailForm" method="post">
						<input type="hidden" id="dailyWorkId" name="dailyWorkId"/>
						<input type="hidden" id="regId" name="regId"/>
						<input type="hidden" id="gubun" name="gubun" value="${param.gubun }"/>
						<input type="hidden" id="pageNo" name="pageNo" value="${searchVO.pageIndex }"/>
					</form>	
					<!--tab Contnet Start-->
					<div class="tab_container">
						<form name="frm" action ="" method="post">
						<input type="hidden" name="gubun" value="<c:out value="${gubun}"/>"/>
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
												<span class="fieldName">상태</span>
												<select name="searchState" id="searchState" class="select">
												<option value="">전체</option>
												<option value="S" <c:if test="${searchVO.searchState == 'S'}">selected="selected"</c:if>>저장</option>
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
										<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:fn_check_use_list();" alt="조회하기" style="float:right;">
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
												<col width="150" />
												<col width="110" />
												<col width="120" />
												<col width="170" />
												<c:if test="${gubun == 'S'}">
												<col width="130" />
												</c:if>
												<col width="100" />
												<c:if test="${gubun == 'S'}">
												<col />
												</c:if>
												<col width="120" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">No.</th>
													<th scope="col">일자</th>
													<th scope="col">최초작성자</th>
													<th scope="col">결재요청자</th>
													<th scope="col">결재요청일</th>
													<c:if test="${gubun == 'M'}">
													<th scope="col">첨부파일</th>
													</c:if>
													<th scope="col">상태</th>
													
													<th scope="col">작성 권한자</th>
													
													<th scope="col">최종작성자</th>
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
														<c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/>
													</td>
													<td onclick='javascript:fnGoDetail("<c:out value='${result.checkUseId}'/>","<c:out value='${result.regId}'/>");' style="cursor: pointer;"><u><c:out value="${result.workDay}"/></u></td>
													<td><c:out value="${result.regName}"/></td>
													<td><c:out value="${result.approvalName}"/></td>
													<td><c:out value="${result.approvalDate}"/></td>
													<c:if test="${gubun == 'M'}">
													<td><c:if test="${result.atchFileYn == 'Y'}"><img src="<c:url value='/images/board/ico_file.gif'/>" alt="파일" /></c:if></td>
													</c:if>
													<c:choose>
											    		<c:when test="${result.state == '결재반려'}">
											    			<td onclick='javascript:fnApprovalInfo(event, "${result.checkUseId}");' style="cursor:pointer;color:#FF0000;"><c:out value="${result.state}"/></td>
											    		</c:when>
											    		<c:otherwise>
											    			<td onclick='javascript:fnApprovalInfo(event, "${result.checkUseId}");' style="cursor:pointer;"><c:out value="${result.state}"/></td>
											    		</c:otherwise>
											    	</c:choose>
													
													<td onclick='javascript:fnAuthDetail(event, "${result.checkUseId}");' style="cursor: pointer;">[보기]</td>
													
													<td><c:out value="${result.modName}"/></td>
												</tr>
												</c:forEach>
												<%
													String cols = "";
													String gubun =  request.getParameter("gubun");
													
													if(gubun.equals("R") || gubun.equals("S")  ){
														cols = "8";
													}else{
														cols = "9";
													}
												%>
												<c:if test="${fn:length(resultList) == 0}">
													<tr>
														<td class="listCenter" colspan="<%=cols %>" >
															<spring:message code="common.nodata.msg" />
														</td>
													</tr>
												</c:if>
											</tbody>
										</table>
										
									<!-- 페이징 -->
									<div class="paging">
										<div id="page_number">
											<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_check_use_list" />
										</div>
									</div>
									<!-- //페이징 -->
									
									<!-- 버튼 메뉴 -->
<%-- 									<sec:authorize ifAnyGranted="ROLE_ADMIN"> --%>
									<div id="menuAuth1">
										<c:if test="${regCnt > 0 }">
										<input type="button" id="btnAdd" value="등록" class="btn btn_basic" style="float:right" alt="등록" onclick="javascript:fnRegist();"/>
										</c:if>
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
		
		<!-- 레이어 팝업 -->
	<div id="authDetail" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroInsXbox" name="btnGroInsXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:fnAuthDetailClose('authDetail');" alt="닫기"/>
		</div>
		<table summary="작성권한자"style="text-align:left;">
				<tr>
					<th scope="col">이름</th>
				</tr>
				<tbody id="authName"></tbody>
			</table>
	</div>
	
		<!-- 레이어 팝업 -->
	<div id="approvalInfo" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroInsXbox" name="btnGroInsXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:fnApprovalInfoClose('approvalInfo');" alt="닫기"/>
		</div>
		<table summary="승인자"style="text-align:left;">
				<tr>
					<th scope="col">승인내역</th>
				</tr>
				<tbody id="approvalInfoName"></tbody>
			</table>
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