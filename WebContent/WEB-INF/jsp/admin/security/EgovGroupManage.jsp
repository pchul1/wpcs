<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovGroupManage.jsp
	 * Description : 그룹관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.06.11	kisspa		최초 생성
	 * 2013.11.01	lkh			리뉴얼
	 *
	 * author kisspa
	 * since 2010.06.11
	 *  
	 * Copyright (C) 2010 by kisspa  All right reserved.
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
			type: "POST",
			url: "<c:url value='/admin/security/EgovGroupDetailList.do'/>",
			data: {
					searchCondition:searchCondition,
					searchKeyword:searchKeyword,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
// 				console.log("EgovGroupDetailList : ",result);
				
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
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						dataHtml += "<tr>";
						dataHtml += "<td class='noOption'><input type='checkbox' name='delYn' class='check2'><input type='hidden' name='checkId' value="+obj.authorCode+" /></td>";
						dataHtml += "<td>" + obj.no +"</td>"
						dataHtml += "<td>" + obj.groupId +"</td>"
						dataHtml += "<td>" + obj.groupNm +"</td>"
						dataHtml += "<td>" + obj.groupDc +"</td>"
						dataHtml += "<td>" + obj.groupCreatDe +"</td>"
						dataHtml += "<td><a href=\"javascript:fncSelectGroup('"+obj.groupId+"');\"><img src='/images/admin/security/icon/search.gif' /></a></td>"
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
				
				var dataHtml="<tr colspan='6'><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
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
		
		if(grid.getDataLength() > 0) {
			if(grid.getSelectedRows().length > 0) {
				for(var i=0; i<grid.getSelectedRows().length; i++) {
					var obj = grid.getDataItem(grid.getSelectedRows()[i]);
					obj.groupId
					
					checkCount++;
					
					if(returnValue == "") {
						returnValue = obj.groupId;
					} else {
						returnValue = returnValue + ";" + obj.groupId;
					}
				}
				if(checkCount > 0) 
					returnBoolean = true;
				else {
					alert("선택된  그룹이 없습니다.");
					returnBoolean = false;
				}
			} else {
				alert("선택된 그룹이 없습니다.");
				returnBoolean = false;
			}
		} else {
			alert("조회된 결과가 없습니다.");
		}
		document.listForm.groupIds.value = returnValue;
		
		return returnBoolean;
	}
	
	function fncSelectGroup(groupId) {
		document.listForm.groupId.value = groupId;
		document.listForm.action = "<c:url value='/admin/security/EgovGroup.do'/>";
		document.listForm.submit();
	}
	
	function fncGroupInsert() {
		location.replace("<c:url value='/admin/security/EgovGroupInsertView.do'/>");
	}
	
	function fncGroupDelete() {
		if(fncManageChecked()) {
			if(confirm("삭제하시겠습니까?")) {
				document.listForm.action = "<c:url value='/admin/security/EgovGroupListDelete.do'/>";
				document.listForm.submit();
			}
		}
	}
	
// 	function linkPage(pageNo){
// 		document.listForm.searchCondition.value = "1";
// 		document.listForm.pageIndex.value = pageNo;
// 		document.listForm.action = "<c:url value='/admin/security/EgovGroupList.do'/>";
// 		document.listForm.submit();
// 	}
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
						
						<form name="listForm" method="post"> 
						
							<!--top Search Start-->
							<div style="text-align:left;">
								<span id="p_total_cnt" style="padding:0px; margin-top:8px;">[총 ${totCnt}건]</span>
								<span style="padding-left:710px;">
								그룹 명 :
								<input id="searchKeyword" name="searchKeyword" type="text" class="fixWidth13" value="${groupManageVO.searchKeyword}" maxlength="35" onkeydown="if(event.keyCode==13) javascript:reloadData()" />
								<input type="button" id="btnInitlDeptList" name="btnInitlDeptList" value="조회" class="btn btn_search" onclick="javascript:reloadData();" alt="조회" />
								</span>
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
								<div style="overflow:auto; max-height:568px;">
									<table summary="그룹 관리 조회 결과 리스트">
										<colgroup>
											<col width="30" />
											<col width="45" />
											<col width="201" />
											<col width="200" />
											<col width="273" />
											<col width="160" />
											<col width="80" />
										</colgroup>
										
										<thead>
											<tr>
												<th class="noOption"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" /></th>  
												<th scope="col">No.</th>
												<th scope="col">그룹 ID</th>
												<th scope="col">그룹 명</th>
												<th scope="col">설명</th>
												<th scope="col">등록일자</th>
												<th scope="col">상세조회</th>
											</tr>
										</thead>
										<tbody id="dataList">
										</tbody>
									 </table>
									<table id="searchResult" style="display:none" summary="이동형측정기기정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
								</div>
							</div>
							
							<input type="hidden" name="groupId"/>
							<input type="hidden" name="groupIds"/>
<%--							<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/> --%>
							<input type="hidden" name="searchCondition"/>
						</form>
						<div style="float:right;">
							<input type="button" id="btnInsertDeptList" name="btnInsertDeptList" value="등록" class="btn btn_basic" onclick="javascript:fncGroupInsert();" alt="등록" />
							<input type="button" id="btnDeleteDeptList" name="btnDeleteDeptList" value="삭제" class="btn btn_basic" onclick="javascript:fncGroupDelete();" alt="삭제" />
						</div>
					</div>
					<!--//tab Contnet End-->
				</div>
				<!-- //Content End-->
			</div>
		</div>
		<!-- //Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- //Footer End-->
	</div>
</body>
</html>