<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/** 
	 * Class Name : EgovAuthorManage.java
	 * Description : 권한관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2009.03.01	Lee.m.j		최초생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author Lee.m.j
	 * since 2009.03.01
	 * 
	 * Copyright (C) 2009 by lee.m.j All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
//<![CDATA[
	$(function () {
		reloadData();
	});
	
	function reloadData(pageNo){
		showLoading();
		
		var searchCondition = "1";
		var searchKeyword = $("#searchKeyword").val();
// 		console.log("searchKeyword : ",searchKeyword);
		
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type: "GET",
			url: "<c:url value='/admin/security/EgovAuthorDetailList.do'/>",
			data: {
					searchCondition:searchCondition,
					searchKeyword:searchKeyword,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
// 				console.log("EgovAuthorDetailList : ",result);
				
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				$("#searchResult").hide();
				
				var dataHtml="";
				
				if( tot <= 0 ){
					$("#searchResult").show();
					$("#dataList").css("height", "25px");
					$("#resultText").html("조회 결과가 없습니다.");
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						
						obj.no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						dataHtml += "<tr>";
						dataHtml += "<td class='noOption'><input type='checkbox' name='delYn' class='check2'><input type='hidden' name='checkId' value="+obj.authorCode+" /></td>";
						dataHtml += "<td><a href=\"javascript:fncSelectAuthor('"+obj.authorCode+"');\">" + obj.no +"</a></td>"
						dataHtml += "<td><a href=\"javascript:fncSelectAuthor('"+obj.authorCode+"');\">" + obj.authorCode +"</a></td>"
						dataHtml += "<td><a href=\"javascript:fncSelectAuthor('"+obj.authorCode+"');\">" + obj.authorNm +"</a></td>"
						dataHtml += "<td><a href=\"javascript:fncSelectAuthor('"+obj.authorCode+"');\">" + obj.authorDc +"</a></td>"
						dataHtml += "<td><a href=\"javascript:fncSelectAuthor('"+obj.authorCode+"');\">" + obj.authorCreatDe +"</a></td>"
						//dataHtml += "<td><a href=\"javascript:fncSelectAuthorRole('"+obj.authorCode+"');\"><img src='/images/admin/security/icon/search.gif' /></a></td>"
						dataHtml += "</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
				
				// 페이징 정보
// 				var pageStr = makePaginationInfo(result['paginationInfo']);
// 				$("#pagination").empty();
// 				$("#pagination").append(pageStr);
				
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
				
				var dataHtml="<tr colspan='5'><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				closeLoading();
			}
		});
	}
	
	function fncCheckAll() {
		var checkField = document.listForm.delYn;
		if(document.listForm.checkAll.checked) {
			if(checkField) {
				if(checkField.length > 1) {
					for(var i=0; i < checkField.length; i++) {
						checkField[i].checked = true;
					}
				} else {
					checkField.checked = true;
				}
			}
		} else {
			if(checkField) {
				if(checkField.length > 1) {
					for(var j=0; j < checkField.length; j++) {
						checkField[j].checked = false;
					}
				} else {
					checkField.checked = false;
				}
			}
		}
	}
	
	function fncManageChecked() {
		var checkField = document.listForm.delYn;
		var checkId = document.listForm.checkId;
		var returnValue = "";
		var returnBoolean = false;
		var checkCount = 0;
		
		if(checkField) {
			if(checkField.length > 1) {
				for(var i=0; i<checkField.length; i++) {
					if(checkField[i].checked) {
						checkField[i].value = checkId[i].value;
						if(returnValue == "")
							returnValue = checkField[i].value;
						else
							returnValue = returnValue + ";" + checkField[i].value;
						checkCount++;
					}
				}
				if(checkCount > 0)
					returnBoolean = true;
				else {
					alert("선택된 권한이 없습니다.");
					returnBoolean = false;
				}
			} else {
				if(document.listForm.delYn.checked == false) {
					alert("선택된 권한이 없습니다.");
					returnBoolean = false;
				}
				else {
					returnValue = checkId.value;
					returnBoolean = true;
				}
			}
		} else {
			alert("조회된 결과가 없습니다.");
		}
		document.listForm.authorCodes.value = returnValue;
		
		return returnBoolean;
	}
	
	function fncSelectAuthor(author) {
		document.listForm.authorCode.value = author;
		document.listForm.action = "<c:url value='/admin/security/EgovAuthor.do'/>";
		document.listForm.submit();
	}
	
	function fncAddAuthorInsert() {
		location.replace("<c:url value='/admin/security/EgovAuthorInsertView.do'/>"); 
	}
	
	function fncAuthorDeleteList() {
	
		if(fncManageChecked()) {
			if(confirm("삭제하시겠습니까?")) {
				document.listForm.action = "<c:url value='/admin/security/EgovAuthorListDelete.do'/>";
				document.listForm.submit();
			} 
		}
	}
	
	function fncAddAuthorView() {
		document.listForm.action = "<c:url value='/admin/security/EgovAuthorUpdate.do'/>";
		document.listForm.submit();
	}
	
	function fncSelectAuthorRole(author) {
		document.listForm.searchKeyword.value = author;
		document.listForm.action = "<c:url value='/admin/security/EgovAuthorRoleList.do?clickMenu=41160'/>";
		document.listForm.submit();
	}
	
// 	function linkPage(pageNo){
// 		document.listForm.searchCondition.value = "1";
// 		document.listForm.pageIndex.value = pageNo;
// 		document.listForm.action = "<c:url value='/admin/security/EgovAuthorList.do'/>";
// 		document.listForm.submit();
// 	}
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
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
						<form name="listForm" method="post">
							<!--top Search Start-->
							<div style="text-align:left;" >
								<span id="p_total_cnt" style="padding:0px; margin-top:8px;">[총 ${totCnt}건]</span>
								<span style="padding-left:690px;">
								권한 명 :
								<input id="searchKeyword" name="searchKeyword" type="text" class="fixWidth13" value="${authorManageVO.searchKeyword}" maxlength="35" onkeydown="if(event.keyCode==13) javascript:reloadData();" />
								<input type="button" id="btnInitlDeptList" name="btnInitlDeptList" value="조회" class="btn btn_search" onclick="javascript:reloadData();" alt="조회" />
								</span>
							</div>
							<!--top Search End-->
<!-- 						<div id="managePage"> -->
							
							<div class="table_wrapper">
								<div style="overflow:auto; max-height:568px;">
									<table summary="권한 관리 조회 결과 리스트">
										<colgroup>
											<col width="30" />
											<col width="45" />
											<col width="235" />
											<col width="130" />
											<col width="313" />
											<col width="165" />
											<col width="70" />
										</colgroup>
										
										<thead>
											<tr>
												<th class="noOption"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" /></th>  
												<th scope="col">No.</th>
												<th scope="col">권한</th>
												<th scope="col">권한</th>
												<th scope="col">설명</th>
												<th scope="col">등록일자</th>
<!-- 												<th scope="col">상세조회</th> -->
											</tr>
										</thead>
										<tbody id="dataList">
										</tbody>
									 </table>
									 <table id="searchResult" style="display:none" summary="이동형측정기기정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
								</div>
							</div>
							<input type="hidden" name="authorCode"/>
							<input type="hidden" name="authorCodes"/>
							<input type="hidden" name="searchCondition"/>
						</form>
						<div style="float:right;">
							<input type="button" id="btnInsertDeptList" name="btnInsertDeptList" value="등록" class="btn btn_basic" onclick="javascript:fncAddAuthorInsert();" alt="등록" />
							<input type="button" id="btnDeleteDeptList" name="btnDeleteDeptList" value="삭제" class="btn btn_basic" onclick="javascript:fncAuthorDeleteList();" alt="삭제" />
						</div>
					</div>
					<!--//tab Contnet Start-->
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