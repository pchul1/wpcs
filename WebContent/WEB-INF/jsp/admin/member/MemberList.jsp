<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : MemberList.jsp
	 * Description : 사용자관리 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * -------		--------	---------------------------
	 * 2010.06.18	kisspa		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author kisspa
	 * since 2010.07.02
	 * 
	 * Copyright (C) 2010 by kisspa All right reserved.
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

<script type="text/javascript">

// 		var dataView = null;
// 		var grid	 = null;
	
	$(function () {
		reloadData();
	});
	
	function reloadData(pageNo){
		
		showLoading();
		
		var searchCondition = $("#searchCondition").val();
		var searchKeyword = $("#searchKeyword").val();
		var searchAppFlag = $("#searchAppFlag").val();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/admin/member/MemberDitailList.do'/>",
			data: {
					searchCondition:searchCondition,
					searchKeyword:searchKeyword,
					searchAppFlag:searchAppFlag,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
// 				console.log("결과 값 확인 : ",result);
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				var dataHtml="";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='12'>조회 결과가 없습니다.</td></tr>";
				}else{
					var onClickAction;
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						if (obj.ctycodename == null) {
							obj.deptnoname = obj.deptnoname;
						} else {
							obj.deptnoname = obj.ctycodename;
						}
						
						if (obj.privacyagree == 'Y') {
							obj.privacyagreenm = obj.privacyagreenm+"<br /> "+obj.privacydt;
						} else {
							obj.privacyagreenm = obj.privacyagreenm;
						}
						
						if(obj.approvalflag == 'N' || obj.approvalflag == 'Y'){
							obj.approvalflagnm = obj.approvalflagnm+"<br /> "+((obj.approvaldt == null) ? "-" : obj.approvaldt);
						}else{
							obj.approvalflagnm = obj.approvalflagnm;
						}
						
						var dispause = parseInt(obj.lastlogin);
						if(dispause >= 0) {
							obj.lastlogin = "<font color='red'>휴면</font>";
						} else {
							obj.lastlogin = "사용";
						}
						onClickAction = "fnDetail('"+obj.memberid+"');"
						
						dataHtml += "<tr>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.no +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.memberid +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.deptnoname +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + ((obj.groupname == null) ? "-" : obj.groupname) +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.gradename +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.membername +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.mobileno +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.email +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.privacyagreenm +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + ((obj.membermgid == null) ? "-" : obj.membermgid) +"</a></td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.approvalflagnm +"</td>";
						dataHtml += "<td><a href='#' onclick=\""+onClickAction+";\">" + obj.lastlogin +"</td>";
						dataHtml += "</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				
				var dataHtml="<tr colspan='9'><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				closeLoading();
			}
		});
	}
	
	//페이지 번호 클릭	
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	// 페이징 처리 함수
	function linkPage(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/admin/member/MemberList.do'/>";
		document.listForm.submit();
	}
	// 조회 처리 
	function fnSearch(){
		document.listForm.pageIndex.value = 1;
		document.listForm.submit();
	}
	//등록 처리 함수 
	function fnRegist(){
		location.href = "<c:url value='/admin/member/MemberRegist.do'/>";
	}
	//수정 처리 함수
	function fnModify(){
		location.href = "";
	}
	//상세회면 처리 함수
	function fnDetail(id){
		var varForm				 = document.all["Form"];
		varForm.action			 = "<c:url value='/admin/member/MemberModify.do'/>";
		varForm.memberId.value	 = id;
		varForm.submit();
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
						<form name="Form" action="" method="post">
							<input type=hidden name="memberId">
						</form>
						<form name="listForm" method="post">
						<!--top Search Start-->
						<div class="topBx">
							검색 :
							<select id="searchCondition" name="searchCondition" class="select">
								<option selected value=''>--선택하세요--</option>
								<option value='id' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>유저ID</option>
								<option value='name' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>유저명</option>
							</select>
							<input id="searchKeyword" name="searchKeyword" type="text" class="fixWidth13" value="${searchVO.searchKeyword}" maxlength="35" onkeydown="if(event.keyCode==13) javascript:reloadData()">
							승인여부 :
							<select id="searchAppFlag" name="searchAppFlag" class="select">
								<option value='All'>전체</option>
								<option value='S' <c:if test="${searchVO.searchAppFlag == 'S'}">selected="selected"</c:if>>승인요청</option>
								<option value='Y' <c:if test="${searchVO.searchAppFlag == 'Y'}">selected="selected"</c:if>>승인</option>
								<option value='N' <c:if test="${searchVO.searchAppFlag == 'N'}">selected="selected"</c:if>>승인거부</option>
							</select>
							<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:reloadData();"/>
						</div>
						<!--top Search End-->
						
						<div class="table_wrapper">
							<div style="overflow:auto; max-height:568px;">
								<table summary="사용자 관리 조회 결과 리스트">
									<colgroup>
										<col width="40" />
										<col width="70" />
										<col width="120"/>
										<col width="80" />
										<col width="70" />
										<col width="70" />
										<col width="100" />
										<col width="110" />
										<col width="80" />
										<col width="60" />
										<col width="80" />
										<col width="80" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">No.</th>
											<th scope="col">유저ID</th>
											<th scope="col">관련기관</th>
											<th scope="col">그룹</th>
											<th scope="col">직급(위)</th>
											<th scope="col">유저명</th>
											<th scope="col">핸드폰</th>
											<th scope="col">이메일</th>
											<th scope="col">개인정보<br/>동의여부</th>
											<th scope="col">관리자ID</th>
											<th scope="col">승인여부</th>
											<th scope="col">휴면여부</th>
										</tr>
									</thead>
									<tbody id="dataList">
									</tbody>
								 </table>
							</div>
							<div style="float:right;margin-top:5px;">
								<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_basic" onclick="javascript:fnRegist();" alt="등록" />
							</div>
						</div>
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