<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : itemManageModify.jsp
	 * Description : 방제물품 물품관리 수정 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2012.11.12	윤일권			최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author 윤일권
	 * since 2012.11.12
	 * 
	 * Copyright (C) 2012by 윤일권  All right reserved.
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
	dataView = new Slick.Data.DataView();
		
// 		var buttonFormatter = function (row) {
// 			var s = "<input type='button' id='btnModifyW' name='btnModifyW' value='수정' class='btn btn_basic' onclick=javascript:onModifyW('"+row+"') alt='수정' />";
// 			return s;
// 		};
		
		var columns = [
// 						{ id: "nog", name: "NO", field: "no", width: 45, sortable: true, cssClass: "slick-pointer" },
						{ id: "whNameg", name: "우편번호", field: "whName", width: 120, sortable: true, cssClass: "slick-pointer" },
						{ id: "riverNameg", name: "주소", field: "riverName", width: 300, sortable: true, cssClass: "slick-pointer" }
					];
		var options = {
				enableColumnReorder: false,
				enableCellNavigation: true,
				multiColumnSort: false
		};
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		grid.onSelectedRowsChanged.subscribe(function(e,args) {
			grid.resetActiveCell();
			var obj = grid.getDataItem(grid.getSelectedRows());
			setAddress(obj.zipcode,obj.addr);
		});
		
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
			grid.render();
		});
		
		grid.onSort.subscribe(function (e, args) {
			var cols = args.sortCols;
			
			dataView.sort(function (dataRow1, dataRow2) {
				for (var i = 0, l = cols.length; i < l; i++) {
					var field = cols[i].sortCol.field;
					var sign = cols[i].sortAsc ? 1 : -1;
					var value1 = dataRow1[field], value2 = dataRow2[field];
					var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
					if (result != 0) {
						return result;
					}
				}
			return 0;
			});
			grid.invalidate();
			grid.render();
		});
	}
	
	function init(){
		//ADMIN 권한 일때만, 삭제,저장 버튼을 나타냄.
		<sec:authorize ifAnyGranted="ROLE_ADMIN">
			$('#goDeleteBtn').show();
			$('#goModifyBtn').show();
		</sec:authorize>
		
		$('#riverDiv').val( $('#original_riverDiv').val());
		$('#useFlag').val( $('#original_useFlag').val());
		
		if( $('#hidden_adminName').val() != '' ){
			fnSearchWareHouseadminName('adminDept');
		}
		
		if( $('#hidden_subName').val() != '' ){
			fnSearchWareHouseadminName('subDept');
		}
	}
	
	//목록
	function fnGoListPage(){
		location.href = "<c:url value='/warehouse/wareHouseManageList.do'/>";
	}
	
	//저장
	function fnGoModify(){
		var returnValue = 'true';
		
		//등록값 체크
		if( $('#whName').val() == ''){
			alert('창고명은 필수입니다');
			$('#whName').focus();
			returnValue = 'false';
		}else{
			if( $('#adminDept').val() == ''){
				alert('담당부서는 필수입니다');
				$('#adminDept').focus();
				returnValue = 'false';
			}else{
				if( $('#adminName').val() == ''){
					alert('담당자(정)은 필수입니다');
					$('#adminName').focus();
					returnValue = 'false';
				}else{
					if( $('#zipcode').val() == ''){
						alert('주소는 필수입니다');
						window.open("<c:url value='/warehouse/selectAddrPopupList.do'/>",'Pop_Mvmn','resizable=yes,scrollbars=yes,width=550,height=145,location=no');
						returnValue = 'false';
					}else{
						if( $('#lon').val() == '' || $('#lat').val() == ''){
							alert('좌표는 필수입니다');
							$('#lon').focus();
							returnValue = 'false';
						}
					}
				}
			}
		}
		
		if(returnValue == 'true'){
			var frm = document.modifyForm;
			frm.action = "<c:url value='/warehouse/wareHouseManageModify.do'/>";
			frm.submit();
		}else{
			return false;
		}
	}
	
	//삭제
	function fnGoDelete(){
		var idcon = confirm('삭제하시겠습니까?');
		
		if (idcon == true){
			var frm = document.deleteForm;
			frm.action = "<c:url value='/warehouse/wareHouseManageModify.do'/>";
			frm.deleteWhCode.value = $('#whCode').val();
			frm.submit();
		}
	}
	
	// 부서이동 화면 호출 함수
	function searchDeptList(type){
		window.open("<c:url value='/warehouse/selectDeptPopupList.do?type=" + type + "'/>",'Pop_Mvmn','resizable=yes,scrollbars=yes,width=640,height=480,location=no');
	}
	
	//팝업에서 부서선택시, 호출되는 함수
	function searchAdminMember(strCode, strValue, strType){	
		if(strType == 'adminDept'){
			$('#adminDeptName').val(strValue);
			$('#adminDept').val(strCode);
			fnSearchWareHouseadminName(strType);
		}else if(strType == 'subDept'){
			$('#subDeptName').val(strValue);
			$('#subDept').val(strCode);
			fnSearchWareHouseadminName(strType);
		}
	}
	
	//직원 불러 오는 함수
	function fnSearchWareHouseadminName(strType){
		
		var deptCode = '';
		
		if(strType == 'adminDept'){
			deptCode = $('#adminDept').val();
		}else if(strType == 'subDept'){
			deptCode = $('#subDept').val();
		}
		
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/wareHouseManageAdminName.do'/>",
			data:{
				deptNo : deptCode},
			dataType:"json",
			beforeSend:function(){},
			success:function(result){
				
				if(strType == 'adminDept'){
					var dropDownSet = $('#adminName');
				}else if(strType == 'subDept'){
					var dropDownSet = $('#subName');
				}
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
				
				if(strType == 'adminDept'){
					if( $('#hidden_adminName').val() != ''){
						$('#adminName').val($('#hidden_adminName').val());
						 $('#hidden_adminName').val('');
					}
				}else if(strType == 'subDept'){
					if( $('#hidden_subName').val() != ''){
						$('#subName').val($('#hidden_subName').val());
						$('#hidden_subName').val('');
					}
				}
			}
		});
	}
	
	//주소찾기 화면 호출 함수
	function searchAddrList(){
		window.open("<c:url value='/warehouse/selectAddrPopupList.do'/>",'Pop_Mvmn','resizable=yes,scrollbars=yes,width=550,height=145,location=no');
	}
	
	// 좌표 지정 팝업
	function lon_lat(){
		window.open("<c:url value='/addrMap.jsp'/>",'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
	}
	
	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$("#lon").val(lon);
		$("#lat").val(lat);
		$("#addr").val(addr.replace('한국 ',''));
	}
	
	//담당(정) 직원의 전화번호 가져오는 함수
	function fnGetAdminTelNo(){
		var adminCode = $('#adminName').val();
		
		//직원선택
		if(adminCode != ''){
			$.ajax({
				type:"POST",
				url:"<c:url value='/warehouse/getAdminTelNo.do'/>",
				data:{
					memberId : adminCode},
				dataType:"json",
				beforeSend:function(){},
				success:function(result){
					$('#adminTelno').val(result['codes'][0].mobileNo);
				}
			});
		}else if(adminCode == ''){
			$('#adminTelno').val('');
		}
	}
	
	function getSearchList(){
		var dong = $('#scDong').val();
		
		if(dong == null || dong == ""){
			alert("찾고자하는 동이름을 입력하세요.");
			$('#scDong').focus();
			return;
		}
		
		$.ajax({
			type:"post",
			url:"<c:url value='/warehouse/getWarehouseAddrList.do'/>",
			data:{
				dong:dong
			},
			dataType:"json",
			success:function(result){
				var tot = result['getAddressList'].length;
				
				dataView.setItems([]);
				$("#searchResult").hide();
				
				var height = sGridCmn(1,result['getAddressList'],10);
// 				height += 17;	//컬럼의 width사이즈가 화면영역 보다 큰 경우 하단 스크롤을 위해 15를 더해준다.(예.기본 contants width가 900인데 이보다 큰경우)
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				var data = [];
				
				if( tot <= 0 ){
					$("#searchResult").show();
					$("#dataList").css("height", "25px");
					$("#resultText").html("조회 결과가 없습니다.");
				}else{
					
					for(var i=0; i < tot; i++){
						var obj = result['getAddressList'][i];
						
						obj.no = i + 1;
						obj.addr = obj.sido+" "+obj.gugun+" "+obj.dong+" "+obj.bunji;
						
						data.push(obj);
					}
					dataView.beginUpdate();
					dataView.setItems(data, 'no');
					dataView.endUpdate();
				}
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
				$("#searchResult").show();
				$("#dataList").css("height", "25px");
				$("#resultText").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
		});
		$("#zip-code").attr("style","display:block")
		resizeWindowAutomatically();
	}
	
	/** 레이어 주소리스트에서 선택한 주소 팝업창으로 보내기 */
	function setAddress(zipcode,addr){
		$('#zipcode',opener.document).val(zipcode);
		$('#addr',opener.document).val(addr);
		$('#addrDetail',opener.document).focus();
		
		window.close();
	}
	
	function fnClosePopup(){
		window.close();
	}
	
	function clearForm(obj, defaultvalue) {
// 		console.log("value :",obj.value);
// 		console.log("defaultvalue :",defaultvalue);
		if (obj.value == defaultvalue)
			obj.value = "";
	}
	
	function escapeForm(obj, defaultValue) {
		if (obj.value == "")
			obj.value = defaultValue;
	}
//]]>
</script>
</head>

<body onload="init()">
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
						
						<div class="topBx">
							<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:fnGoListPage();" />
						</div>
						
						<div class="table_wrapper">
							
							<form name="deleteForm" method="post">
								<input type="hidden" name="mode" value="delete"/>
								<input type="hidden" name="deleteWhCode" id="deleteWhCode"/>
							</form>
							<form name="modifyForm" method="post" >
								<input type="hidden" name="mode" value="modify"/>
								
								<table summary="창고상세정보" style="text-align:left;">
									<colgroup>
										<col width="15%">
										<col>
									</colgroup>
									<c:forEach items="${resultDetail}" var="resultDetail" varStatus="status">
									<tr>
										<th>창고명<span class="red">*</span></th>
										<td>
											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/>
											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}">
										</td>
									</tr>
									<tr>
										<th>담당(정)<span class="red">*</span></th>
										<td>	
											<input type="text" id="adminDeptName" name="adminDeptName" value="${resultDetail.adminDeptName}" onclick="javascript:searchDeptList('adminDept');" style="background-color:#D5D5D5;" readonly="readonly"/>
											<input type="hidden" id="adminDept" name="adminDept" value="${resultDetail.adminDept}"/>
											<a href="javascript:searchDeptList('adminDept');" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/admin/security/icon/search.gif' />"
												 alt='부서선택 검색)' width="15" height="15" /></a>(부서검색)
											&nbsp;
											<select class="fixWidth20" name="adminName" id="adminName" onchange="javascript:fnGetAdminTelNo();">
												<option value="">선택</option>
											</select>
											<input type="hidden" id="hidden_adminName" name="hidden_adminName" value="${resultDetail.adminName}"/>
										</td>
									</tr>
									<tr>
										<th>담당(부)<span class="red">*</span></th>
										<td>	
											<input type="text" id="subDeptName" name="subDeptName" value="${resultDetail.subDeptName}" onclick="javascript:searchDeptList('subDept');" style="background-color:#D5D5D5;" readonly="readonly"/>
											<input type="hidden" id="subDept" name="subDept" value="${resultDetail.subDept}"/>
											<a href="javascript:searchDeptList('subDept');" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/admin/security/icon/search.gif' />"
												 alt='부서선택 검색)' width="15" height="15" /></a>(부서검색)
											&nbsp;
											<select class="fixWidth20" name="subName" id="subName">
												<option value="">선택</option>
											</select>
											<input type="hidden" id="hidden_subName" name="hidden_subName" value="${resultDetail.subName}"/>
										</td>
									</tr>
									<tr>
										<th>담당(정)연락처<span class="red">*</span></th>
										<td><input style="width:240px;" type="text" name="adminTelno" id="adminTelno" value="${resultDetail.adminTelno}"/></td>
									</tr>
									<tr>
										<th>주소</th>
										<td>
										<input type="text" id="zipcode" name="zipcode" value="${resultDetail.zipcode}" style="width:50px; background-color:#D5D5D5;" readonly="readonly" onclick="javascript:searchAddrList();"/>
										<input type="text" id="addr" name="addr" value="${resultDetail.addr}" style="width:350px; background-color:#D5D5D5;" onclick="javascript:searchAddrList();" readonly="readonly"/>
										<input type="button" id="btnAddr" name="btnAddr" value="주소찾기" class="btn btn_search" onclick="javascript:searchAddrList();" />
										</td>
									</tr>
									<tr>
										<th>상세주소</th>
										<td><input style="width:240px;" type="text" name="addrDetail" id="addrDetail" value="${resultDetail.addrDetail}"/></td>
									</tr>
									<tr>
										<th>좌표<span class="red">*</span></th>
										<td>
											<input style="width:150px;" type="text" name="lon" value="${resultDetail.lon}"/>&nbsp;
											<input style="width:150px;" type="text" name="lat" value="${resultDetail.lat}"/>
										</td>
									</tr>
									<tr>
										<th>수계<span class="red">*</span></th>
										<td>
											<input type="hidden" id="original_riverDiv" name="original_riverDiv" value="${resultDetail.riverDiv}">
											<select class="fixWidth20" name="riverDiv" id="riverDiv">
												<option value="R01">한강</option>
												<option value="R02">낙동강</option>
												<option value="R03">금강</option>
												<option value="R04">영산강</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>사용유무<span class="red">*</span></th>
										<td>
											<input type="hidden" id="original_useFlag" name="original_useFlag" value="${resultDetail.useFlag}">
											<select class="fixWidth20" name="useFlag" id="useFlag">
												<option value="Y">사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
									</tr>
									</c:forEach>
								</table>
							</form>
							<div id="btArea" class="mtop10">
								<input type="button" id="goDeleteBtn" name="goDeleteBtn" value="삭제" class="btn btn_basic" onclick="javascript:fnGoDelete();" style="display:none;" />
								<input type="button" id="goModifyBtn" name="goModifyBtn" value="저장" class="btn btn_basic" onclick="javascript:fnGoModify();" style="display:none;" />
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
	<div class="address">
		<table summary="주소 검색">
			<colgroup>
				<col />
			</colgroup>
			<thead>
			<tr>
				<th scope="col" colspan="2">주소 찾기</th>
			</tr>
			<tr>
				<th>
					동이름 : <input type="text" id="scDong" name="scDong" value="동(읍/면/리)" style="width:200px; ime-mode:active;" onfocus="clearForm(this,'동(읍/면/리)');" onblur="escapeForm(this,'동(읍/면/리)');" onkeydown="javascript:if(event.keyCode==13){getSearchList();return false;}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="btnAddSearch" name="btnAddSearch" value="검색" class="btn btn_search" onclick="javascript:getSearchList();" alt="검색" />
				</th>
			</tr>
			<tr>
				<td scope="col" colspan="2">※찾고자하는 주소를(읍/면/리) 입력하세요.<br/>예)'논현동', '삼천동 1가', '구로3동'</td>
			</tr>
			</thead>
		</table>
		<div id="zip-code" style="display:none">
			<div id="dataList" style="height: 300px;"></div>
			<table id="searchResult" style="display:none" summary="결과정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
<!-- 			<div style="border:0px solid #CCC !important; overflow:auto; width:100%; height: 251px; margin-top:10px"> -->
<!-- 				<table summary="주소정보" style="width:100%;"> -->
<!-- 					<colgroup> -->
<!-- 						<col width="100" /> -->
<!-- 						<col /> -->
<!-- 					</colgroup> -->
<!-- 					<tbody id="addrList"> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->
		</div>
		<div id="btCarea">
			<input type="button" id="btnClose" name="btnClose" value="닫기" class="btn btn_search" onclick="javascript:fnClosePopup();" alt="닫기" />
		</div>
	</div>
</body>
</html>