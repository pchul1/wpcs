<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="groupManage" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
//<![CDATA[
	$(function () {
		reloadData();
		
		setDept();		//부서셋팅
		$("#dept").change(function(){
			setPerson(); //직원셋팅
		});
	});
	
	function setDept(){
		var dropDownSet = $("#dept");
		
		$("#sPerson").emptySelect();
		
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
			{
				orderType:"1"
			},
			//, system:sys_kind},
			function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					
					dropDownSet.loadSelect(data.groupList);
					
					setPerson();
					//adjustBranchList();
					
				} else {
					return;
				}
		});
	}
	
	//부서별 직원생성
	function setPerson(){
		var value = $("#dept > option:selected").val();
		var dropDownSet = $("#person");
		
		if(value == undefined)
			return;
		
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
				{
					orderType:"2",
					value:value
				},
				//, system:sys_kind},
				function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					
					dropDownSet.loadSelect(data.groupList);
					//adjustBranchList();
				
				} else {
					return;
				}
		});
	}

	//선택한 SMS그룹에 대한 멤버 불러오기
	function getSmsGroupMember(groupNm, groupDc, groupId){
		$('#registlayerid').css('display','');
		var dropDownSet = $("#sPerson");
		
		$.getJSON("<c:url value='/admin/security/SmsGroupMember.do'/>",
				{
					groupId:groupId
				},
				function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					$('#groupNm').val(groupNm);
					$('#groupDc').val(groupDc);
					dropDownSet.loadSelect(data.groupList);
					//adjustBranchList();
				
				} else {
					return;
				}
		});
	}
	
	//SMS 보낼 직원 추가
	function add(){
		$("#person option:selected").each(function(i){
			var addOpt = document.createElement('option'); // 옵션을 설정한다..
			addOpt.value = $(this).val();
			addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
			
			var flag = false;
			$("#sPerson option").each(function(i){
				if($(this).val() == addOpt.value){
					flag = true;
					return false;//break;
				}
			});
			
			if(!flag){
				$("#sPerson").append(addOpt);
			}
		});
	}
	
	//SMS 보낼 직원 삭제
	function del(){
		$("#sPerson option:selected").each(function(i){
			//$(this).appendTo('#person');
			$(this).remove();
		});
	}
	
	function reloadData(pageNo){
		showLoading();
		
		var searchCondition = "1";
		var searchKeyword = $("#searchKeyword").val();
// 		console.log("searchKeyword : ",searchKeyword);
		
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type: "POST",
			url: "<c:url value='/admin/security/SmsGroupDetailList.do'/>",
			data: {
					searchCondition:searchCondition,
					searchKeyword:searchKeyword,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
// 				console.log("SmsGroupDetailList : ",result);
				
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
						dataHtml += "<td class='noOption'><input type='checkbox' name='delYn' class='check2'><input type='hidden' name='checkId' value="+obj.groupId+" /></td>";
						dataHtml += "<td><a href=\"javascript:getSmsGroupMember('"+obj.groupNm+"','"+obj.groupDc+"','"+obj.groupId+"');\">" + obj.no +"</a></td>"
						dataHtml += "<td><a href=\"javascript:getSmsGroupMember('"+obj.groupNm+"','"+obj.groupDc+"','"+obj.groupId+"');\">" + obj.groupId +"</a></td>"
						dataHtml += "<td><a href=\"javascript:getSmsGroupMember('"+obj.groupNm+"','"+obj.groupDc+"','"+obj.groupId+"');\">" + obj.groupNm +"</a></td>"
						dataHtml += "<td><a href=\"javascript:getSmsGroupMember('"+obj.groupNm+"','"+obj.groupDc+"','"+obj.groupId+"');\">" + obj.groupDc +"</a></td>"
						dataHtml += "<td><a href=\"javascript:getSmsGroupMember('"+obj.groupNm+"','"+obj.groupDc+"','"+obj.groupId+"');\">" + obj.groupCreatDe +"</a></td>"
						//dataHtml += "<td><a href=\"javascript:fncSelectGroup('"+obj.groupId+"');\"><img src='/images/admin/security/icon/search.gif' /></a></td>"
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
					alert("선택된 그룹이 없습니다.");
					returnBoolean = false;
				}
			} else {
				if(document.listForm.delYn.checked == false) {
					alert("선택된 그룹이 없습니다.");
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
		
		document.listForm.groupIds.value = returnValue;
		
		return returnBoolean;
	}
	
	function fncSelectGroup(groupId) {
		$('#registlayerid').css('display','');
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/admin/security/SmsGroup.do'/>",
			data: {
					groupId:groupId
				},
			dataType:"json",
			success : function(result){
				var tot = result['resultList'].length;
				
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
						dataHtml += "<td class='noOption'><input type='checkbox' name='delYn' class='check2'><input type='hidden' name='checkId' value="+obj.groupId+" /></td>";
						dataHtml += "<td><a href=\"javascript:fncSelectGroup('"+obj.groupId+"');\">" + obj.no +"</a></td>"
						dataHtml += "<td><a href=\"javascript:fncSelectGroup('"+obj.groupId+"');\">" + obj.groupId +"</a></td>"
						dataHtml += "<td><a href=\"javascript:fncSelectGroup('"+obj.groupId+"');\">" + obj.groupNm +"</a></td>"
						dataHtml += "<td><a href=\"javascript:fncSelectGroup('"+obj.groupId+"');\">" + obj.groupDc +"</a></td>"
						dataHtml += "<td><a href=\"javascript:fncSelectGroup('"+obj.groupId+"');\">" + obj.groupCreatDe +"</a></td>"
						//dataHtml += "<td><a href=\"javascript:fncSelectGroup('"+obj.groupId+"');\"><img src='/images/admin/security/icon/search.gif' /></a></td>"
						dataHtml += "</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
				
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
		
		/* document.listForm.groupId.value = groupId;
		document.listForm.action = "<c:url value='/admin/security/SmsGroup.do'/>";
		document.listForm.submit(); */
	}
	
	function fncGroupDelete() {
		if(fncManageChecked()) {
			if(confirm("삭제하시겠습니까?")) {
				document.listForm.action = "<c:url value='/admin/security/SmsGroupListDelete.do'/>";
				document.listForm.submit();
			}
		}
	}
	
	function fncGroupInsert() {
		var varFrom = document.getElementById("groupManage");
		varFrom.action = "<c:url value='/admin/security/SmsGroupInsert.do'/>";
	
		if(confirm("저장 하시겠습니까?")){
			if(!validateGroupManage(varFrom)){
				return;
			}else{
				var member = new Array;	
				var cnt = 0;
				
				$("#sPerson option").each(function() {
					member.push($(this).val());
					cnt++;
				});
				$("#member_id").val(member);
				
				if(cnt == 0) {
					alert("대상자를 선택하여 주십시요.");
					return false;
				}
				
				varFrom.submit();
			} 
		}
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
											<!-- <col width="80" /> -->
										</colgroup>
										
										<thead>
											<tr>
												<th class="noOption"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" /></th>  
												<th scope="col">No.</th>
												<th scope="col">그룹 ID</th>
												<th scope="col">그룹 명</th>
												<th scope="col">설명</th>
												<th scope="col">등록일자</th>
												<!-- <th scope="col">상세조회</th> -->
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
						
						<div class="btnSearchDiv" style="clear:both;margin: 10px 0;">
							<div style="float:right;">
								<input type="button" id="btnInsertDeptList" name="btnInsertDeptList" value="등록" class="btn btn_basic" onclick="$('#registlayerid').css('display','');return false;" alt="등록" />
								<input type="button" id="btnDeleteDeptList" name="btnDeleteDeptList" value="삭제" class="btn btn_basic" onclick="javascript:fncGroupDelete();" alt="삭제" />
							</div>
						</div>
						
						<div id="registlayerid" style="margin-top:20px;display:none;">
								<div>
									<div class="tab_container">
										<form:form commandName="groupManage" method="post">
											<input type="hidden" name="member_id" id="member_id"/>
											<div class="table_wrapper">
												<table style="text-align:left" summary="그룹정보" >
													<colgroup>
														<col width="20%">
														<col>
													</colgroup>
													<tr>  
														<th>그룹 명 <span class="red">*</span></th>
														<td class="txtL"><input name="groupNm" id="groupNm" type="text" required="true" fieldTitle="그룹 명" maxLength="50" char="s" size="50" />&nbsp;<form:errors path="groupNm" /></td>
													</tr>
													<tr>   
														<th>설명</th>
														<td class="txtL"><input name="groupDc" id="groupDc" type="text" required="true" fieldTitle="설명" maxLength="50" char="s" size="50" /></td>
													</tr>
												</table>
											</div>
										</form:form>
									</div>
									
									<div class="gBox" style="width:340px">
										<span class="ptit" >
											대상기관
										</span>
										<select multiple="multiple" id="dept" style="padding:7px;width:330px;height:190px"></select>
									</div>
									
									<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
									
									<div class="gBox" style="width:285px">
										<span class="ptit">
											담당자
										</span>
										<select multiple="multiple" id="person" style="padding:7px;width:280px;height:190px"></select>
									</div>
									
									<ul class="arrbx">
										<li style="padding-top:70px;"><a href="javascript:add()"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
										<li><a href="javascript:del()"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
									</ul>
									
									<div class="gBox" style="width:285px">
										<span class="ptit">
											전파대상자
										</span>
										<select multiple="multiple" id="sPerson" style="padding:7px;width:280px;height:190px"></select>
									</div>
								</div>
								
								<div class="btnSearchDiv" style="clear:both;padding-top:10px;">
									<div style="padding-right:10px;float:right;">
										<input type="button" value="취소" class="btn btn_search" onclick="$('#registlayerid').css('display','none');return false;" alt="취소" />
										<input type="button" id="btnEgovRegistMember" name="btnEgovRegistMember" value="저장" class="btn btn_search" onclick="javascript:fncGroupInsert();" alt="저장" />
									</div>
								</div>
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