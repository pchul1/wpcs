<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : wareHouseManageRegist.jsp
	 * Description : 방제물품 물품관리 수정 화면
	 * Modification Information
	 * 
	 * 수정일				 수정자		수정내용
	 * ----------		--------	---------------------------
	 * 2012.11.12		 윤일권		최초 생성
	 * 2013.10.20		lkh			 리뉴얼
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
	function init(){
		//getCtyCode();
	}
	
	// 지역코드 불러오기
	function getCtyCode()
	{
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/wareHousectyCode.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){
				$('#ctyCode').attr("disabled", true);
			},
			success:function(result){
				var dropDownSet = $('#ctyCode');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
				$('#ctyCode').attr("disabled", false);
			}
		});
	}
	
	//목록 화면 이동
	function fnGoListPage(){	
		location.href = "<c:url value='/warehouse/wareHouseManageList.do'/>";
	}
	
	//저장
	function fnGoSave(){
		
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
						window.open("<c:url value='/warehouse/selectAddrPopupList.do'/>",'Pop_Mvmn','resizable=yes,scrollbars=yes,width=465,height=250,location=no');
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
			var frm = document.registform;
			frm.submit();
		}else{
			return false;
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
	
	//직원 불러오기 
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
		//$("#addr").val(addr.replace('한국 ',''));
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
//]]>
</script>
</head>

<body onload="init();">
<%--	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div> --%>
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
						
							<form name="registform" method="post" action="">
								<input type="hidden" name="mode" value="register"/>
								
								<table summary="창고상세정보" style="text-align:left;">
									<colgroup>
										<col width="15%">
										<col>
									</colgroup>
									<tr>
										<th>창고명<span class="red">*</span></th>
										<td><input style="width:240px;" type="text" id="whName" name="whName"/></td>
									</tr>
									<tr>
										<th>담당(정)<span class="red">*</span></th>
										<td>	
											<input type="text" id="adminDeptName" name="adminDeptName" onclick="javascript:searchDeptList('adminDept');" style="background-color:#D5D5D5;" readonly="readonly"/>
											<input type="hidden" id="adminDept"	 name="adminDept"/>
											<a href="javascript:searchDeptList('adminDept');" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/admin/security/icon/search.gif' />"
													 alt='부서선택 검색)' width="15" height="15" /></a>(부서검색)
											&nbsp;
											<select class="fixWidth20" name="adminName" id="adminName" onchange="javascript:fnGetAdminTelNo();">
												<option value="">선택</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>담당(부)<span class="red">*</span></th>
										<td>
											<input type="text" id="subDeptName" name="subDeptName" onclick="javascript:searchDeptList('subDept');" style="background-color:#D5D5D5;" readonly="readonly"/>
											<input type="hidden" id="subDept" name="subDept"/>
											<a href="javascript:searchDeptList('subDept');" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/admin/security/icon/search.gif' />" alt='부서 검색' width="15" height="15" /></a>(부서검색)
											&nbsp;
											<select class="fixWidth20" name="subName" id="subName">
												<option value="">선택</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>담당(정)연락처</th>
										<td><input style="width:240px;" type="text" name="adminTelno" id="adminTelno"/></td>
									</tr>
									<tr>
										<th>주소<span class="red">*</span></th>
										<td>
										<input type="text" id="zipcode" name="zipcode" style="width:50px; background-color:#D5D5D5;" readonly="readonly" onclick="javascript:searchAddrList();"/>
										<input type="text" id="addr" name="addr" style="width:350px; background-color:#D5D5D5;" onclick="javascript:searchAddrList();" readonly="readonly"/>
										<input type="button" id="btnAddr" name="btnAddr" value="주소찾기" class="btn btn_search" onclick="javascript:searchAddrList();" />
										</td>
									</tr>
									<tr>
										<th>상세주소</th>
										<td><input style="width:240px;" type="text" name="addrDetail" id="addrDetail"/></td>
									</tr>
									<tr>
										<th>좌표<span class="red">*</span></th>
										<td>
											<input style="width:150px;" type="text" name="lon" id="lon"/>&nbsp;
											<input style="width:150px;" type="text" name="lat" id="lat"/>
											<input type="button" id="butLonLat" name="butLonLat" value="좌표" class="btn btn_search" onclick="javascript:lon_lat()();" />
										</td>
									</tr>
									<tr>
										<th>수계<span class="red">*</span></th>
										<td>
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
											<select class="fixWidth20" name="useFlag" id="useFlag">
												<option value="Y">사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
									</tr>
								</table>
							</form>
							<div id="btArea" class="mtop10">
								<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" onclick="javascript:fnGoSave();" />
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
</body>
</html>