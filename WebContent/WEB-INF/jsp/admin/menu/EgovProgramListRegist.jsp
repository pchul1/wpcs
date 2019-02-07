<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovProgramListRegist.jsp
	 * Description : 프로그램목록등록 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2009.03.10	이용			최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author 공통서비스 개발 및 이용
	 * since 2009.03.10
	 * 
	 * Copyright (C) 2010 by 이용 All right reserved.
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
<script type="text/javascript" src="<c:url value="/validator.do" />"></script>
<script type="text/javascript" src="<c:url value="/js/JQuery/jquery.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/menu/EgovProgrmList.js" />"></script>
<validator:javascript formName="progrmManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
//<![CDATA[
	//입력 처리 함수
	function insertProgramListManage(form) {
		
		if(confirm("<spring:message code="common.save.msg" />")){
			if(!validateProgrmManageVO(form)){
				return;
			}else{
				document.progrmManageVO.cmd.value="insert";
				form.action="<c:url value='/admin/menu/ProgramRegist.do'/>"
				form.submit();
			}
		}
	//	progrmListRegistForm.submit();
	}
	
	//수정처리 함수
	function updateProgramListManage(form) {
		if(confirm("<spring:message code="common.update.msg" />")){
			if(!validateProgrmManageVO(form)){
				return;
			}else{
				form.action="<c:url value='/admin/menu/updateProgramDetailInfo.do'/>";
				form.submit();
			}
		}
	}
	
	//삭제처리함수
	function deleteProgramListManage(form) {
		if(confirm("<spring:message code="common.delete.msg" />")){
			form.action="<c:url value='/admin/menu/ProgramDelete.do'/>";
			form.submit();
		}
	}
	
	//폼 초기화 함수
	function initSet(form) {
		form.SEQ.value= "";
		form.progrmFileNm.value= "";
		form.progrmStrePath.value= "";
		form.progrmKoreanNm.value= "";
		form.URL.value= "";
		form.progrmDc.value= "";
	}
	
	//목록조회 함수
	function selectList(){
		location.href = "<c:url value='/admin/menu/EgovProgramListManageSelect.do'/>";
	}
	
	//프로그램 등록 정보 상세조회 함수
	function choiceNodes(nodeNum) {
		//alert('choiceNodes');
		var nodeValues = treeNodes[nodeNum].split("|");
		
		//프로그램을 등록하기 위한 필수 데이터
		document.progrmManageVO.menuNo.value = nodeValues[0];
		document.progrmManageVO.upperMenuId.value = nodeValues[1];
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/toProgramList.do'/>",
			data: {"menuNo":nodeValues[0]},
			dataType:"json",
			success : function(result) {
				var tot = result['result'].length;
				var lists = "";
				
				if( tot <= 0 ) {
					//lists += "<tr style='cursor:pointer;' onClick=\"javascript:detailView("+obj.menuNo+", "+obj.SEQ+")\">";
					lists += "<tr>";
					lists += "<td>"+nodeValues[2]+"</td>";
					lists += "<td colspan='3' style='text-align:center'>등록된 프로그램이 없습니다.</td>";
					lists += "</tr>";
				}
				else {
					for(var i=0; i < tot; i++){
						var obj = result['result'][i];
						lists += "<tr style='cursor:pointer' onClick='javascript:detailView("+obj.menuNo+", "+obj.SEQ+")'>";
						lists += "<td>"+obj.menuNm+"</td>";
						lists += "<td>"+obj.progrmFileNm+"</td>";
						lists += "<td>"+obj.progrmKoreanNm+"</td>";
						lists += "<td>"+obj.URL+"</td>";
						lists += "</tr>";
					}
				}
				$("#dataList").empty();
				$("#dataList").append(lists);
			}
		});
	}
	
	//프로그램 상세 조회 함수
	function detailView(menuNo, seq) {
		
		$.ajaxSetup({dataType:"json"});
		$.post("<c:url value='/ProgramDetailInfo.do'/>",
				{"menuNo":menuNo, "seq":seq},
				function(result) {
					var datas = result['result'];
					document.progrmManageVO.menuNo.value = datas.menuNo;
					document.progrmManageVO.upperMenuId.value = datas.upperMenuId;
					document.progrmManageVO.SEQ.value = datas.SEQ;
					document.progrmManageVO.progrmFileNm.value = datas.progrmFileNm;
					document.progrmManageVO.progrmStrePath.value = datas.progrmStrePath;
					document.progrmManageVO.progrmKoreanNm.value = datas.progrmKoreanNm;
					document.progrmManageVO.URL.value = datas.URL;
					document.progrmManageVO.progrmDc.value = datas.progrmDc;
		});
	}
	
	//focus 시작점 지정함수
	function fn_FocusStart(){
			var objFocus = document.getElementById('F1');
			objFocus.focus();
		}
	
// 	<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
//]]>
</script>
</head>

<body onfocus="fn_FocusStart()"> 
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
						
						<form name="treeForm"> 
							<input type="hidden" name="req_RetrunPath" value="<c:url value='/admin/menu/EgovProgramListRegist'/>"> 
							<div>
								<c:forEach var="result" items="${list_menulist}" varStatus="status" > 
								<input type="hidden" name="tmp_menuNmVal" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|">
								</c:forEach>
							</div>
						</form> <!-- End Form// -->
						<form:form commandName="progrmManageVO" name="progrmManageVO">
						
							<!--top Search Start-->
							<div class="topBx">
								<input type="button" id="btnMenuList" name="btnMenuList" value="목록" class="btn btn_basic" onclick="javascript:selectList();" alt="목록" />
								<input type="button" id="btnInitMenuList" name="btnInitMenuList" value="초기화" class="btn btn_basic" onclick="javascript:initSet(document.forms[2]);" alt="초기화" />
								<input type="button" id="btnInsertMenuList" name="btnInsertMenuList" value="등록" class="btn btn_basic" onclick="javascript:insertProgramListManage(document.forms[2]);" alt="등록" />
								<input type="button" id="btnUpdateMenuList" name="btnUpdateMenuList" value="수정" class="btn btn_basic" onclick="javascript:updateProgramListManage(document.forms[2]);" alt="수정" />
								<input type="button" id="btnDeleteMenuList" name="btnDeleteMenuList" value="삭제" class="btn btn_basic" onclick="javascript:deleteProgramListManage(document.forms[2]);" alt="삭제" />
							</div>
							<!--top Search End-->
							
							<div class="divisionBx" style="margin-top:0px">
								<div class="div30">
									<div class="table_wrapper">
										<table summary="메뉴박스">
											<tr>
												<td class="txtL boxp" style="height:318px;vertical-align:top;">
													<script type="text/javascript">
														var chk_Object = true;
														var chk_browse = "";
														if (eval(document.treeForm.req_RetrunPath)=="[object]") chk_browse = "IE";
														if (eval(document.treeForm.req_RetrunPath)=="[object NodeList]") chk_browse = "Fox";
														if (eval(document.treeForm.req_RetrunPath)=="[object Collection]") chk_browse = "safai";
														
														var Tree = new Array;
														if(chk_browse=="IE"&&eval(document.treeForm.tmp_menuNmVal)!="[object]"){
															alert("메뉴 목록 데이타가 존재하지 않습니다.");
															chk_Object = false;
														}
														
														if(chk_browse=="Fox"&&eval(document.treeForm.tmp_menuNmVal)!="[object NodeList]"){
															alert("메뉴 목록 데이타가 존재하지 않습니다.");
															chk_Object = false;
														}
														
														if(chk_browse=="safai"&&eval(document.treeForm.tmp_menuNmVal)!="[object Collection]"){
															alert("메뉴 목록 데이타가 존재하지 않습니다.");
															chk_Object = false;
														}
														
														if( chk_Object ){
															for (var j = 0; j < document.treeForm.tmp_menuNmVal.length; j++) {
																Tree[j] = document.treeForm.tmp_menuNmVal[j].value;
															}
															createTree(Tree);
														}else{
															alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.");
														}
													</script>
												</td>
											</tr>
										</table>
									</div>
								</div>
								
								<div class="div70">
									<div class="table_wrapper">
										<table summary="프로그램상세정보" _style="text-align:left">
											<colgroup>
												<col />
												<col />
												<col />
												<col />
											</colgroup>
											<thead>
											<tr>
												<th>메뉴명</th>
												<th>프로그램 파일명</th>
												<th>프로그램명</th>
												<th>URL</th>
											</tr>
											</thead>
											<tbody id="dataList">
											<tr>
												<td colspan="4" style="text-align:center">좌측의 메뉴를 선택해 주세요.</td>
											</tr>
											</tbody>
										</table>
										<br />
										<table summary="프로그램상세정보입력" style="text-align:left">
											<colgroup>
												<col width="15%">
												<col width="45%">
											</colgroup>
											<tr>
												<th>프로그램 파일명 <span class="red">*</span></th>
												<td class="txtL">
													<form:input path="progrmFileNm" size="50" maxlength="50" id="F1"/>
														<form:errors path="progrmFileNm" />
												</td>
											</tr>
											<tr>
												<th>저장경로 <span class="red">*</span></th>
												<td class="txtL">
													<form:input path="progrmStrePath" size="60" maxlength="60" /> 
													<form:errors path="progrmStrePath" />
												</td>
											</tr>
											<tr>
												<th>한글명 <span class="red">*</span></th>
												<td class="txtL">
													<form:input path="progrmKoreanNm" size="60" maxlength="60" /> 
													<form:errors path="progrmKoreanNm"/>
												</td>
											</tr>
											<tr>
												<th>URL <span class="red">*</span></th>
												<td class="txtL">
													<form:input path="URL" size="60" maxlength="60" /> 
													<form:errors path="URL"/>
												</td>
											</tr>
											<tr>
												<th>프로그램 설명</th>
												<td class="txtL" style="padding-top:5px; padding-bottom:5px;">
													<form:textarea path="progrmDc" rows="6" cols="60" cssClass="txaClass"/>
													<form:errors path="progrmDc"/>
												</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
							<input name="menuNo" type="hidden" value="" />
							<input name="upperMenuId" type="hidden" value="" />
							<input name="SEQ" type="hidden" value="" />
							<input name="cmd" type="hidden" value=""/>
						</form:form> <!-- End Form// -->
						
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