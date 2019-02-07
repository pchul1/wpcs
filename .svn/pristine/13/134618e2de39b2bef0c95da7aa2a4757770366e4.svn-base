<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : itemGroupList.jsp
	 * Description : 방제물품  분류관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author lkh
	 * since 2013.10.20
	 * 
	 * Copyright (C) 2013 by lkh All right reserved.
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

<script type="text/javascript">
//<![CDATA[
	var options = {
				enableColumnReorder: false,
				multiColumnSort: false,
				enableCellNavigation: true
	}
	
	$(function () {
		//ADMIN 권한 일때만, 삭제,저장 버튼을 나타냄.
		<sec:authorize ifAnyGranted="ROLE_ADMIN">
			$('#registUpperGroupCodeBtn').show();
			$('#registGruopCodeBtn').show();
		</sec:authorize>
		
		getUpperGroupCode();
		itemGroupDataLoad();
		itemUpperGroupDataLoad();
	});
	
	// 데이터 목록 불러오기
	function itemUpperGroupDataLoad(pageNo){
		showLoading();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/itemUpperGroupDataList.do'/>",
			data: {
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
				// 아이템 데이터 세팅
				var tot = result['list'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='4'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						obj.useFlag = (obj.useFlag =="Y")?"사용":"미사용";
						
	                   	item += "<tr style='cursor:pointer;' onclick=\"fnGoDetail('"+obj.groupCode+"','"+obj.groupName+"','"+obj.useFlag+"'"+")\">"			                   	 
								+"<td><span>"+obj.no+"</span></td>"
		                 		+"<td>"+obj.groupCode+"</td>"
		                 		+"<td>"+obj.groupName+"</td>"
		                 		+"<td>"+obj.useFlag+"</td>"
	                 		 	+"</tr>";
	
	              		$("#dataList").html(item);
	              		$("#dataList tr:odd").attr("class","even");
					}
				}
				
//				총건수 표시
				$("#totcnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				
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
				$('#dataList').html("<tr><td colspan='4'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
	
	// 중분류 목록 불러오기
	function itemGroupDataLoad(pageNo){
		showLoading();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/itemGroupDataList.do'/>",
			data: { searchUpperGroupCode:$('#searchUpperGroupCode').val(),
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
				//console.log("itemGroupDataList : ",result);
				var tot = result['list'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList1').html("<tr><td colspan='5'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						obj.useFlag = (obj.useFlag =="Y")?"사용":"미사용";
						
	                   	item += "<tr style='cursor:pointer;' onclick=\"fnGoDetail('"+obj.groupCode+"','"+obj.groupName+"','"+obj.useFlag+"','"+obj.upperGroupCode+"'"+")\">"			                   	 
								+"<td><span>"+obj.no+"</span></td>"
								+"<td>"+obj.upperGroupCode+"</td>"
								+"<td>"+obj.groupCode+"</td>"
		                 		+"<td>"+obj.groupName+"</td>"
		                 		+"<td>"+obj.useFlag+"</td>"
	                 		 	+"</tr>";
	
	              		$("#dataList1").html(item);
	              		$("#dataList1 tr:odd").attr("class","even");
					}
				}
				// 총건수 표시
				$("#totcnt1").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				
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
				$('#dataList1').html("<tr><td colspan='5'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
	
	//대분류 코드 불러오기
	function getUpperGroupCode(){
			
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemManageUpperGroupCode.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){
				//$('#searchUpperGroupCode').attr("disabled", true);
				//$('#popupUpperGroupCode').attr("disabled", true);
			},
			success:function(result){
				var dropDownSet = $('#searchUpperGroupCode');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
				$('#searchUpperGroupCode').attr("disabled", false);
				
				if($('#search_UpperGroupCode').val() != ''){
					$('#searchUpperGroupCode').val($('#search_UpperGroupCode').val());
					$('#search_UpperGroupCode').val(''); 
				}
			}
		});
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		dataLoad(pageNo);
	}
	
	/* 대/중 분류 등록 팝업  */
	function itemGroupRegistPopup(isUpper){
		$('#isUpper').val(isUpper);
		
		window.open("<c:url value='/warehouse/itemGroupRegistPopup.do'/>",'Pop_Mvmn','resizable=yes,scrollbars=yes,width=450,height=200,left='+(screen.width/2-225)+',top='+(screen.height/2-135)+',location=no');
	}
	
	/* 대/중 분류 수정 팝업  */
	function fnGoDetail(groupCode,groupName,useFlag,upperGroupCode){
		//수정popup에 setting해줄 data를 hidden값으로 가지고 있는다. 
		$('#hiddenGroupCode').val(groupCode);
		$('#hiddenGroupName').val(groupName);
		$('#hiddenUseFlag').val(useFlag);
		$('#isUpper').val(upperGroupCode);
		$('#hiddenUpperGroupName001').val(upperGroupCode)
		
		window.open("<c:url value='/warehouse/itemGroupModifyPopup.do'/>",'Pop_Mvmn','resizable=yes,scrollbars=yes,width=450,height=180,left='+(screen.width/2-225)+',top='+(screen.height/2-135)+',location=no');			
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
					
					<!--tab Contnet Start-->
					<div class="tab_container">
						
						<form id="hiddenForm">
							<input type="hidden" id="isUpper" name="isUpper"/>
							<input type="hidden" id="hiddenGroupCode" name="hiddenGroupCode"/>
							<input type="hidden" id="hiddenGroupName" name="hiddenGroupName"/>
							<input type="hidden" id="hiddenUseFlag"	name="hiddenUseFlag"/>	
							<input type="hidden" id="hiddenUpperGroupName001"	name="hiddenUpperGroupName001"/>
						</form>
						
						<div class="divisionBx">
							<div class="div40">
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 380px; height: 460px;">
									<table>
										<colgroup>
											<col width="60" />
											<col width="120" />
											<col />
											<col width="100" />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">NO</th>
											<th scope="col">대분류</th>
											<th scope="col">대분류명칭</th>
											<th scope="col">사용여부</th>
										</tr>
										</thead>
										<tbody  id="dataList">
										<tr>
											<td colspan="4">조회 결과가 없습니다.</td>
										</tr>
										</tbody>
									</table>
								</div>
								<div id="menuAuth1">
								<div style="float:right;margin-top:5px;margin-right:10px;">
									<input type="button" id="btnRegistUpperGroupCode" name="btnRegistUpperGroupCode" value="등록" class="btn btn_basic" onclick="javascript:itemGroupRegistPopup('upperGroupCode');" alt="등록"/>
								</div>
								</div>
							</div>
							
							<div class="div60">
								<!-- 물품중분류 코드목록 -->
								<form id="searchForm" action="" onsubmit="return false;">
									<input type="hidden" id="search_UpperGroupCode" name="search_UpperGroupCode" value="${searchVO.searchUpperGroupCode}"/>
										
									<div class="searchBox" style="width:570px">
										<ul>
											<li>
												<span class="fieldName">대분류코드</span>
												<select id="searchUpperGroupCode" name="searchUpperGroupCode">
													<option value="">선택</option>
												</select>
											</li>
											<li class="last">
												<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:itemGroupDataLoad();" alt="조회"/>
											</li>
										</ul>
									</div>
								</form>
								
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 593px; height: 389px;">
									<form id="groupListForm" action="" onsubmit="return false;">
									<table>
										<colgroup>
											<col width="60" />
											<col />
											<col width="150" />
											<col width="150" />
											<col width="110" />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">NO</th>
											<th scope="col">대분류명칭</th>
											<th scope="col">중분류코드</th>
											<th scope="col">중분류명칭</th>
											<th scope="col">사용여부</th>
										</tr>
										</thead>
										<tbody  id="dataList1">
										<tr>
											<td colspan="5">조회 결과가 없습니다.</td>
										</tr>
										</tbody>
									</table>
									</form>
								</div>
								<div id="menuAuth2">
									<div style="float:right;margin-top:5px;">
										<input type="button" id="btnItemGroupRegist" name="btnItemGroupRegist" value="등록" class="btn btn_basic" onclick="javascript:itemGroupRegistPopup('groupCode');" alt="등록"/>
									</div>
								</div>
							</div>
							</div>
						</div>
						
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
	
	
	<script language="javascript" >
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
		$("#menuAuth2").show();
	}else{
		$("#menuAuth1").hide();
		$("#menuAuth2").hide();
	}
	</script>
</body>
</html>