<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : itemConditionManageList.jsp
	 * Description : 방제물품 현황관리 목록 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2012.11.07	윤일권			최초 생성
	 * 2013.10.30	lkh			리뉴얼
	 * 
	 * author 윤일권
	 * since 2012.11.07
	 * 
	 * Copyright (C) 2012 by 윤일권  All right reserved.
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
	function init(){
		//getUpperGroupCode();
		getItemCode();
		
		<sec:authorize  ifAnyGranted="ROLE_WAREHOUSE">
			//$('#btnItemStor').show();
		</sec:authorize>
	}
	
	//페이징 처리 함수
	function linkPage(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/warehouse/itemConditionManageList.do'/>";
		document.listForm.submit();
	}
	
	//조회 처리 
	function fnSearch(){
		document.listForm.pageIndex.value = 1;
		document.listForm.submit();
	}
	
	//입고 페이지로 이동
	function fnGoItemStor(){
		location.href = "<c:url value='/warehouse/itemConditionStorRegist.do'/>";
	}
	
	//출고 페이지로 이동
	function fnGoRelePage(itemCode,whCode){
		var varForm				= document.all["goDetailForm"];
		varForm.action			= "<c:url value='/warehouse/itemConditionReleRegist.do'/>";
		varForm.itemCode.value	= itemCode;
		varForm.whCode.value	= whCode;
		varForm.submit();
	}
	
	function fnGoActivityPage(itemCode,itemCodeNum,whCode){
		var varForm				= document.all["goDetailForm"];
		varForm.action			= "<c:url value='/warehouse/itemCalculateManageDetail.do'/>";
		varForm.itemCode.value	= itemCode;
		varForm.itemCodeNum.value	= itemCodeNum;
		varForm.whCode.value	= whCode;
		varForm.submit();
	}
	
	/*	대분류 중분류 삭제 2016.12.22 KANG JI NAM
	//대분류 코드 불러오기
	function getUpperGroupCode(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemManageUpperGroupCode.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){
				$('#searchUpperGroupCode').attr("disabled", true);
			},
			success:function(result){
				var dropDownSet = $('#searchUpperGroupCode');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
				$('#searchUpperGroupCode').attr("disabled", false);
				
				if(	$('#search_UpperGroupCode').val() != ''){
					$('#searchUpperGroupCode').val($('#search_UpperGroupCode').val());
					getGroupCode();
					$('#search_UpperGroupCode').val(''); 
				}
			}
		});
	}
	
	//중분류 코드 불러오기
	function getGroupCode(){
		$('#searchItemCode').html("<option value=''>선택</option>");
		
		var upperGroupCode = $('#searchUpperGroupCode').val();
		
		if(upperGroupCode == ''){
			$('#searchGroupCode').html("<option value=''>선택없음</option>");
			$('#searchItemCode').html("<option value=''>선택없음</option>");
		}else{
			$.ajax({
				type:"POST",
				url:"<c:url value='/warehouse/itemManageGroupCode.do'/>",
				data:{
					upperGroupCode : upperGroupCode
					},
				dataType:"json",
				beforeSend:function(){
					$('#searchGroupCode').attr("disabled", true);
				},
				success:function(result){
					var dropDownSet = $('#searchGroupCode');
					dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
					$('#searchGroupCode').attr("disabled", false);
					
					if(	$('#search_GroupCode').val() != ''){
						$('#searchGroupCode').val($('#search_GroupCode').val());
						getItemCode();
						$('#search_GroupCode').val('');
					}
				}
			});
		}
	}
	*/
	
	//물품 코드 불러오기
	function getItemCode(){
		/*	대분류 중분류 삭제 2016.12.22 KANG JI NAM
		var groupCode = $('#searchGroupCode').val();
		
		if(groupCode == ''){
			$('#searchItemCode').html("<option value=''>선택없음</option>");
		}else{}
		*/
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemConditionCode.do'/>",
			data:{
				//groupCode : groupCode
				},
			dataType:"json",
			beforeSend:function(){
				$('#searchItemCode').attr("disabled", true);
			},
			success:function(result){
				var dropDownSet = $('#searchItemCode');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
				$('#searchItemCode').attr("disabled", false);
				
				if( $('#search_ItemCode').val() != ''){
					$('#searchItemCode').val($('#search_ItemCode').val());
					$('#search_ItemCode').val('');
				}
			}
		});
	}
	
	$(function () {
		reloadData();
	});
	
	function reloadData(pageNo){
		showLoading();
		
		var searchUpperGroupCode = $('#searchUpperGroupCode').val();
		var searchGroupCode = $('#searchGroupCode').val();
		
		var searchItemCode = "";
		var searchItemCodeNum = "";
		
		if($('#searchItemCode').val() != null && $('#searchItemCode').val() != ""){
			searchItemCode = $('#searchItemCode').val().split('-')[0];
			searchItemCodeNum = $('#searchItemCode').val().split('-')[1];
		}
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getItemConditionManageList.do'/>",
			data: { searchUpperGroupCode:searchUpperGroupCode,
					searchGroupCode:searchGroupCode,
					searchItemCode:searchItemCode,
					searchItemCodeNum:searchItemCodeNum,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='9'>조회 결과가 없습니다.</td></tr>");
				}else{

					var item = "";
					for(var i=0; i < tot; i++){
						
						var obj = result['resultList'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
	                   	item += "<tr>"			                   	 
								+"<td><span>"+obj.no+"</span></td>"
		                 		+"<td>"+obj.whName+"</td>"
		                 		//+"<td>"+obj.upperGroupName+"</td>"
		                 		//+"<td>"+obj.groupName+"</td>"
		                 		+"<td>"+obj.itemName+"</td>"
		                 		+"<td>"+obj.itemUnit+"</td>"
		                 		+"<td>"+obj.itemStan+"</td>"
		                 		+"<td>"+obj.itemCnt+"</td>"
		                 		+"<td><input type='button' id='btnRecord' name='btnRecord' value='물품별입출고이력' class='btn btn_basic' onclick=javascript:fnGoActivityPage('" +obj.itemCode+ "','" +obj.itemCodeNum+ "','" + obj.whCode+ "') alt='물품별입출고이력' /></td>"
	                 		 	+"</tr>";
	
	              		
					}
              		$("#dataList").html(item);
              		$("#dataList tr:odd").attr("class","even");
					
				}
				
				$("#p_total_cnt").html("총 " + result['totCnt'] + "건");
				
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
				$('#dataList').html("<tr><td colspan='9'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
//]]>
</script>
</head>

<body onload="init();" link="blue" vlink="red" alink="darkgreen">
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
						
						<form name="goDetailForm" method="post">
							<input type="hidden" id="itemCode" name="itemCode"/>
							<input type="hidden" id="itemCodeNum" name="itemCodeNum"/>
							<input type="hidden" id="whCode" name="whCode"/>
						</form>
						
						<form name="listForm" method="post">
							<input type="hidden" id="search_UpperGroupCode" name="search_UpperGroupCode" value="${searchVO.searchUpperGroupCode}">
							<input type="hidden" id="search_GroupCode" name="search_GroupCode" value="${searchVO.searchGroupCode}">
							<input type="hidden" id="search_ItemCode" name="search_ItemCode" value="${searchVO.searchItemCode}">
							
							<div class="searchBox dataSearch">
								<ul>
									
									<li>
										<span class="fieldName">물품명</span>
										<select class="fixWidth20" name="searchItemCode" id="searchItemCode" >
											<option value="">선택</option> 
										</select>
									</li>
								</ul>
							</div>
							
							<div class="btnSearchDiv">
								<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
							</div>
							<div id="btArea">
								<span id="p_total_cnt">[총 ${totCnt}건]</span>
								<input type="button" id="btnItemStor" name="btnItemStor" value="입고" class="btn btn_basic" onclick="javascript:fnGoItemStor();" style="display:none" alt="입고"/>
							</div>
							<div class="table_wrapper">
								<input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 100%; height: 497px;">
									<table>
										<colgroup>
											<col width="60" />
											<col width="120" />
											<col width="120" />
											<col width="120" />
											<col width="120" />
											<col width="100" />
											<col width="80" />
											<col width="80" />
											<col />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">NO</th>
											<th scope="col">창고명</th>
											<th scope="col">물품명</th>
											<th scope="col">규격</th>
											<th scope="col">단위</th>
											<th scope="col">수량</th>
											<th scope="col">선택</th>
										</tr>
										</thead>
										<tbody  id="dataList">
										<tr>
											<td colspan="9">조회 결과가 없습니다.</td>
										</tr>
										</tbody>
									</table>
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