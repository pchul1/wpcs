<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : seminarRegistView.jsp
	 * Description : 교육상세 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    			--------    ---------------------------
	 * 2014.09.17		mypark		최초생성
	 *
	 * author mypark
	 * since 2014.09.18
	 *  
	 * Copyright (C) 2014 by 이용 All right reserved.
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
// 교육 삭제 처리
function fn_egov_delete() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "<c:url value='/seminar/DeleteSeminarInfo.do'/>";
		document.frm.submit();
	}	
}

//수정 페이지 이동
function fn_Edit() {
	document.frm.urlStr.value = "SeminarRegistEdit.do";
	document.frm.action = "<c:url value='/seminar/SeminarView.do'/>";
	document.frm.submit();
}

function fn_egov_Approval(){
	var form = document.frm;
	if(confirm("선택하신 교육을 승인 하시겠습니까?")){
		var checkState = document.frm.seminarStateName.value;
		if(checkState == '승인') {
			alert("이미 승인 처리된 교육 입니다.");
			return false;
		}
		var fromDate =  document.frm.seminarDateFrom.value;
		var toDate = document.frm.seminarDateTo.value;
		var seminarId = document.frm.seminarId.value;
		$.ajax({
			type: "POST",
			url: "<c:url value='/seminar/selectCheckSeminarDate.do'/>",
			data: {startDt:fromDate, endDt:toDate, seminarId:seminarId},
			dataType:"json",
			success : function(result){
				if(result['msg'] == "duplication") {
					alert("교육 일정이 중복되었습니다. \n\n다시 한번 확인 하시기 바랍니다.");
					return false;
				} else {
					form.seminarState.value = "A";
					form.seminarReason.value = "";
					form.action	= "<c:url value='/seminar/UpdateSeminarState.do'/>";
					form.pageIndex.value  = 1;
					form.submit();
				}
			}
		});
	}
}

function fn_egov_Disapprover(){
	var form = document.frm;
	form.seminarState.value = "D";
	form.seminarReason.value = $('#reason').val();
	form.action	= "<c:url value='/seminar/UpdateSeminarState.do'/>";
	form.pageIndex.value  = 1;
	form.submit();
}

function layerPopCloseAll() {
	$("#seminarReason").val("");
	layerPopClose("layerDisapprover");
}

function openLayerPop() {
	if(confirm("선택하신 교육을 불허 하시겠습니까?")){
		var checkState = document.frm.seminarStateName.value;
		var count = document.frm.entryCnt.value;
		if(checkState == '불허') {
			alert("이미 불허 처리된 교육 입니다.");
			return false;
		}
		if(count > 0) {
			alert("교육 신청 중인 참가자가 존재합니다.");
			return false;
		} else {
			$("#seminarReason").val("");
			layerPopOpen('layerDisapprover');
		}
	}
}

function fn_open_cal() {
	window.open("<c:url value='/seminar/SeminarSchedule.do?urlStr=popupCal'/>",'popupCal','resizable=no,scrollbars=no,width=960,height=750');
}

function fn_egov_list1(){
	document.frm.action = "<c:url value='/seminar/SeminarRegistList.do'/>";
	document.frm.submit();
}

function fn_egov_list2(){
	document.frm.action = "<c:url value='/seminar/SeminarApproval.do'/>";
	document.frm.submit();
}
</script>
</head>
<body>
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
							<form name="frm" method="post" action="">							
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
							<input type="hidden" name="searchBgnDe" value="<c:out value="${searchVO.searchBgnDe}"/>" />
							<input type="hidden" name="searchEndDe" value="<c:out value="${searchVO.searchEndDe}"/>" />
							<input type="hidden" name="searchStatus" value="<c:out value="${searchVO.searchStatus}"/>" />
							<input type="hidden" name="searchGubun" value="<c:out value="${searchVO.searchGubun}"/>" />
							<input type="hidden" name="searchClosingState" value="<c:out value="${searchVO.searchClosingState}"/>" />
							<input type="hidden" name="searchCnd" value="<c:out value="${searchVO.searchCnd}"/>" />
							<input type="hidden" name="searchWrd" value="<c:out value="${searchVO.searchWrd}"/>" />
							<input type="hidden" name="seminarId" value="<c:out value='${result.seminarId}'/>" />
							<input type="hidden" name="seminarState" value="" />
							<input type="hidden" name="seminarReason" value="" />
							<input type="hidden" name="checkSeminarId" value="<c:out value='${result.seminarId}'/>//<c:out value='${result.writerId}'/>" />
							<input type="hidden" name="urlStr" value="<c:out value='${searchVO.urlStr}'/>" />
							<input type="hidden" name="no" value="<c:out value='${no}'/>" />
							<input type="hidden" name="menu" value="<c:out value='${menu}'/>" />
							<input type="hidden" name="seminarDateFrom"  value="<c:out value='${result.seminarDateFrom}'/>"/>
							<input type="hidden" name="seminarDateTo" value="<c:out value='${result.seminarDateTo}'/>"/>					
							<input type="hidden" name="seminarStateName" value="<c:out value='${result.seminarStateName}'/>"/>
							<input type="hidden" name="entryCnt" value="<c:out value='${entryCnt}'/>"/>
							<!-- 글 상세보기 폼 -->
							<div class="table_wrapper">
								<!-- 글 상세보기 -->
								<table summary="교육 정보 상세 보기">
									<colgroup>
										<col width="100px" />
										<col width="100px" />
										<col width="80px" />
										<col width="120px" />
										<col width="100px" />
										<col width="150px" />
										<col width="100px" />
										<col width="100px" />
										<col width="100px" />
										<col width="60px" />
									</colgroup>
									<tr>
										<th><label for="">제목</label></th>
										<td colspan="5" class="txtL"><label for="">[<c:out value='${result.seminarGubunName}'/>]<c:out value='${result.seminarTitle}'/></label></td>
										<th><label for="">참여자수</label></th>
										<td class="txtL" ><label for=""><c:out value='${entryCnt}'/> / <c:out value='${result.seminarCount}'/></label></td>
										<th><label for="">조회수</label></th>
										<td class="txtL" ><label for=""><c:out value='${result.readCnt}'/></label></td>
									</tr>
									<tr>
										<th><label for="">작성자</label></th>
										<td class="txtL" colspan="3"><c:out value='${result.writerName}'/></td>
										<th><label for="">E.mail</label></th>
										<td class="txtL"><label for=""><c:out value='${result.seminarLectEmail}'/></label></td>
										<th><label for="">등록일</label></th>
										<td class="txtL" colspan="3"><label for=""><c:out value='${result.regDate}'/></label></td>
									</tr>
									<tr>
										<th><label for="">교육기간</label></th>
										<td class="txtL" colspan="3"><label for=""><c:out value='${result.seminarDateFrom}'/> ~ <c:out value='${result.seminarDateTo}'/></label>
											<input type="button" id="btnSearch" name="btnSearch" value="일정보기" class="btn btn_search" onclick="javascript:fn_open_cal();" alt="일정보기" />
										</td>
										<th><label for="">교육시간</label></th>
										<td class="txtL">
											<label for=""><c:out value='${result.seminarTimeFrom}'/> : 00 ~ <c:out value='${result.seminarTimeTo}'/> : 00</label>
										</td>
										<th><label for="">신청기간</label></th>
										<td class="txtL" colspan="3"><label for=""><c:out value='${result.seminarEntryDateFrom}'/> ~ <c:out value='${result.seminarEntryDateTo}'/></label></td>
									</tr>
									<tr>
										<th><label for="">담당자</label></th>
										<td class="txtL" ><label for=""><c:out value='${result.seminarLectName}'/></label></td>
										<th><label for="">주최</label></th>
										<td class="txtL" ><label for=""><c:out value='${result.seminarHost}'/></label></td>
										<th><label for="">담당자연락처</label></th>
										<td class="txtL"><label for=""><c:out value='${result.seminarLectTel}'/></label></td>
										<th><label for="">교육장소</label></th>
										<td class="txtL"><label for=""><c:out value='${result.seminarPlace}'/></label></td>
										<th><label for="">상태</label></th>
										<td class="txtL"><label for=""><c:out value='${result.seminarStateName}'/></label></td>
									</tr>
									<tr>
										<th><label for="">내용</label></th>
										<td colspan="9">
											<table width="100%" border="0" cellpadding="0" cellspacing="0" class="noStyle">
										    	<tr>
										    		<td class="txtL" style="width:863px;height:300px;valign:top;">${result.seminarBody}</td>
										      	</tr>
										    </table>
										</td>
									</tr>
									
									<tr class="borderNone">
										<th><label for="">파일</label></th>
										<td colspan="9" style="text-align:left;">
											<c:import url="/cmmn/selectFileInfs.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.atchFileId}" />
											</c:import>
										</td>
									</tr>
								</table>
								<!-- //글 상세보기 내용 -->
								<!-- 버튼 메뉴 -->
								<div id="btArea" style="margin-top:10px">
							<c:if test="${searchVO.urlStr == 'SeminarRegistList.do'}">
								<!-- 교육상태가 '대기 일경우 수정/삭제가 가능하도록' -->
								<c:if test="${result.seminarState == 'S'}">
									<c:if test="${result.writerId == loginUserId}">
										<input type="button" id="btnDelete" name="btnDelete" value="삭제" class="btn btn_basic" onclick="javascript:fn_egov_delete();return false;" alt="삭제"/>
										<input type="button" id="btnMoveUpdt" name="btnMoveUpdt" value="수정" class="btn btn_basic" onclick="javascript:fn_Edit();return false;" alt="수정"/>
										
									</c:if>
								</c:if>
									<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_list1();" alt="목록"/>
							</c:if>
							<c:if test="${searchVO.urlStr != 'SeminarRegistList.do'}">
								<div id="btArea">
									<input type="button" id="btnRegist" name="btnRegist" value="승인" class="btn btn_basic" onclick="javascript:fn_egov_Approval();return false;" alt="승인" />
									<input type="button" id="btnRegist" name="btnRegist" value="불허" class="btn btn_basic" onclick="javascript:openLayerPop();return false;" alt="불허" />					
									<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_list2();" alt="목록"/>
								</div>
							</c:if>
								</div>      	
								<!-- //버튼 메뉴 -->
							</div>
							</form>
							<!-- //글 상세보기 폼 -->

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
	<!-- 블허사유 레이어 -->
	<div id="layerDisapprover" class="divPopup" Style="background-color:#FFFFFF;" >
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnFacSizeModXbox" name="btnFacSizeModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopCloseAll('layerDeptMemList');" alt="닫기" />
		</div>
		<form id="modifySizeForm" name="modifySizeForm" method="post">
			<div id="deptList" style="background-color:#FFFFFF;">
				<div class="gBox" style="width:430px;height:180px;border:0;">
					<textarea id="reason" name="reason" style="width:400px;height:150px;"></textarea>
				</div>
				<div id="btArea">
					<input type="button" id="btnRegist" name="btnRegist" value="확인" class="btn btn_basic" onclick="javascript:fn_egov_Disapprover();" alt="확인" />
				</div>
			</div>
		</form>
	</div>
</body>
</html>