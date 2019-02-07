<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : itemManageModify.jsp
	 * Description : 방제물품 물품관리 수정 화면
	 * Modification Information
	 * 
	 * 수정일        			수정자                   수정내용
	 * ----------    	--------    ---------------------------
	 * 2012.11.12     	 윤일권      		최초 생성
	 * 2013.10.20		lkh         리뉴얼
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
<!--
	function init(){
	
		<sec:authorize  ifAnyGranted="ROLE_ADMIN">
			$('#goModifyBtn').show();		
		</sec:authorize>
		
		$('#useFlag').val( $('#original_useFlag').val());
		fnCheckBoxDisplay();
	}
	
	//목록
	function fnGoListPage(){	
		location.href = "<c:url value='/warehouse/itemManageList.do'/>";
	}
	
	function fnGoModify(){
		var type1ApplFlag  = changeBoolean($("#type1ApplFlagCheck").attr('checked'));
		var type2ApplFlag  = changeBoolean($("#type2ApplFlagCheck").attr('checked'));
		var type3ApplFlag  = changeBoolean($("#type3ApplFlagCheck").attr('checked'));
		var type4ApplFlag  = changeBoolean($("#type4ApplFlagCheck").attr('checked'));
		var type5ApplFlag  = changeBoolean($("#type5ApplFlagCheck").attr('checked'));
		var type6ApplFlag  = changeBoolean($("#type6ApplFlagCheck").attr('checked'));
		var type7ApplFlag  = changeBoolean($("#type7ApplFlagCheck").attr('checked'));
		var type8ApplFlag  = changeBoolean($("#type8ApplFlagCheck").attr('checked'));
		var type9ApplFlag  = changeBoolean($("#type9ApplFlagCheck").attr('checked'));
		var type10ApplFlag = changeBoolean($("#type10ApplFlagCheck").attr('checked'));
		var type11ApplFlag = changeBoolean($("#type11ApplFlagCheck").attr('checked'));
		var type12ApplFlag = changeBoolean($("#type12ApplFlagCheck").attr('checked'));
	
		$('#type1ApplFlag').val(type1ApplFlag);
		$('#type2ApplFlag').val(type2ApplFlag);
		$('#type3ApplFlag').val(type3ApplFlag);
		$('#type4ApplFlag').val(type4ApplFlag);
		$('#type5ApplFlag').val(type5ApplFlag);
		$('#type6ApplFlag').val(type6ApplFlag);
		$('#type7ApplFlag').val(type7ApplFlag);
		$('#type8ApplFlag').val(type8ApplFlag);
		$('#type9ApplFlag').val(type9ApplFlag);
		$('#type10ApplFlag').val(type10ApplFlag);
		$('#type11ApplFlag').val(type11ApplFlag);
		$('#type12ApplFlag').val(type12ApplFlag);
	
		var returnValue = 'true';
	
		//등록값 체크
		if( $('#itemName').val() == ''){
			alert('물품명칭은 필수입니다');
			$('#itemName').focus();
			returnValue = 'false';
		}else{
			if( $('#useFlag').val() == '' ){
				alert('사용여부는 필수입니다');
				$('#useFlag').focus();
				returnValue = 'false';
			}
		}
	
		if(returnValue == 'true'){
			var frm    = document.modifyForm;
			frm.action = "/warehouse/itemManageModify.do";
			frm.submit();
		}else{
			return false;
		}
	}
	
	//공통 함수
	function changeBoolean(bool)
	{
		var rtnVal = "N";
		if (bool == true) {
			rtnVal = "Y";
		}
		return rtnVal;
	}
	
	//checkBox(사고적용) 초기값 setting
	function fnCheckBoxDisplay(){	
		var type1ApplFlag  = $("#original_type1ApplFlag").val();
		var type2ApplFlag  = $("#original_type2ApplFlag").val();
		var type3ApplFlag  = $("#original_type3ApplFlag").val();
		var type4ApplFlag  = $("#original_type4ApplFlag").val();
		var type5ApplFlag  = $("#original_type5ApplFlag").val();
		var type6ApplFlag  = $("#original_type6ApplFlag").val();
		var type7ApplFlag  = $("#original_type7ApplFlag").val();
		var type8ApplFlag  = $("#original_type8ApplFlag").val();
		var type9ApplFlag  = $("#original_type9ApplFlag").val();
		var type10ApplFlag = $("#original_type10ApplFlag").val();
		var type11ApplFlag = $("#original_type11ApplFlag").val();
		var type12ApplFlag = $("#original_type12ApplFlag").val();
	
		if(type1ApplFlag == 'Y'){
			$("#type1ApplFlagCheck").attr('checked','checked');
		}
		if(type2ApplFlag == 'Y'){
			$("#type2ApplFlagCheck").attr('checked','checked');
		}
		if(type3ApplFlag == 'Y'){
			$("#type3ApplFlagCheck").attr('checked','checked');
		}
		if(type4ApplFlag == 'Y'){
			$("#type4ApplFlagCheck").attr('checked','checked');
		}
		if(type5ApplFlag == 'Y'){
			$("#type5ApplFlagCheck").attr('checked','checked');
		}
		if(type6ApplFlag == 'Y'){
			$("#type6ApplFlagCheck").attr('checked','checked');
		}
		if(type7ApplFlag == 'Y'){
			$("#type7ApplFlagCheck").attr('checked','checked');
		}
		if(type8ApplFlag == 'Y'){
			$("#type8ApplFlagCheck").attr('checked','checked');
		}
		if(type9ApplFlag == 'Y'){
			$("#type9ApplFlagCheck").attr('checked','checked');
		}
		if(type10ApplFlag == 'Y'){
			$("#type10ApplFlagCheck").attr('checked','checked');
		}
		if(type11ApplFlag == 'Y'){
			$("#type11ApplFlagCheck").attr('checked','checked');
		}
		if(type12ApplFlag == 'Y'){
			$("#type12ApplFlagCheck").attr('checked','checked');
		}	
	}
	
	//숫자체크
	function checkNum(inputValue){
		var checkCode = inputValue.value.charCodeAt(inputValue.value.length-1); 
		var str; 
		
		if(checkCode >= 33 && checkCode <= 47 || checkCode >= 58 && checkCode <= 125){
			 alert("숫자만 입력가능합니다.");
			 str = inputValue.value.substring(0,inputValue.value.length-1);
			 inputValue.value = str; 
			 inputValue.focus();
		
		}else if( checkCode >= 48 && checkCode <= 57 )
		 nputValue.focus();
	}
//-->
</script>
</head>
<body onload="init()">
<%-- 	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
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
						
							<form name="modifyForm" method="post" >
								<input type="hidden" name="mode" value="modify"/>					
								<input type="hidden" name="type1ApplFlag"  id="type1ApplFlag"/>
								<input type="hidden" name="type2ApplFlag"  id="type2ApplFlag"/>
								<input type="hidden" name="type3ApplFlag"  id="type3ApplFlag"/>
								<input type="hidden" name="type4ApplFlag"  id="type4ApplFlag"/>
								<input type="hidden" name="type5ApplFlag"  id="type5ApplFlag"/>
								<input type="hidden" name="type6ApplFlag"  id="type6ApplFlag"/>
								<input type="hidden" name="type7ApplFlag"  id="type7ApplFlag"/>
								<input type="hidden" name="type8ApplFlag"  id="type8ApplFlag"/>
								<input type="hidden" name="type9ApplFlag"  id="type9ApplFlag"/>
								<input type="hidden" name="type10ApplFlag" id="type10ApplFlag"/>
								<input type="hidden" name="type11ApplFlag" id="type11ApplFlag"/>
								<input type="hidden" name="type12ApplFlag" id="type12ApplFlag"/>
								
								<table summary="뭎품정보" style="text-align:left;">
									<colgroup>
										<col width="15%">
										<col>
									</colgroup>
									<c:forEach items="${resultDetail}" var="resultDetail" varStatus="status">
									<input type="hidden" id="itemCode" name="itemCode" value="${resultDetail.itemCode}">
									<tr>
										<th>대분류<span class="red">*</span></th>
										<td>
											<input readonly="readonly" style="width:240px; background-color:#D5D5D5;" type="text" name="upperGroupCode" id="upperGroupCode" value="${resultDetail.upperGroupCode}"/>								
										</td>
									</tr>
									<tr>
										<th>중분류</th>
										<td>
											<input readonly="readonly" style="width:240px; background-color:#D5D5D5;" type="text" name="groupCode" id="groupCode" value="${resultDetail.groupCode}"/>								
										</td>
									</tr>
									<tr>
										<th>물품명칭<span class="red">*</span></th>
										<td>
											<input style="width:240px; ime-mode:active;" type="text" name="itemName" id="itemName" value="${resultDetail.itemName}"/>								
										</td>
									</tr>
									<tr>
										<th>규격<span class="red">*</span></th>
										<td>
											<input style="width:240px; ime-mode:active;" type="text" name="itemUnit" id="itemUnit" value="${resultDetail.itemUnit}"/>								
										</td>
									</tr>
									<tr>
										<th>단위<span class="red">*</span></th>
										<td>
											<input style="width:240px; ime-mode:active;" type="text" name="itemStan" id="itemStan" value="${resultDetail.itemStan}"/>								
										</td>
									</tr>
									<tr>
										<th>금액<span class="red">*</span></th>
										<td>
											<input style="width:240px; ime-mode:disabled;" type="text" name="price" id="price" value="${resultDetail.price}" onkeyup="checkNum(this)"/>		
											<font color="red">(숫자만 입력가능)</font>
										</td>
									</tr>
									<tr>
										<th>사고적용<span class="red">*</span></th>
										<td>
											&nbsp;
											<input type="hidden" id="original_type1ApplFlag" name="original_type1ApplFlag" value="${resultDetail.type1ApplFlag}">
											<input type="checkbox" id="type1ApplFlagCheck" style="width:15px;"/>
											<label for="type1ApplFlag">
												<img src="<c:url value='/images/warehouse/type1.png'/>" alt="오탁수 발생" style="vertical-align:middle;"/>
												오탁수 발생
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type2ApplFlag" name="original_type2ApplFlag" value="${resultDetail.type2ApplFlag}">
											<input type="checkbox" id="type2ApplFlagCheck" style="width:15px;"/>
											<label for="type2ApplFlag">
												<img src="<c:url value='/images/warehouse/type2.png'/>" alt="준설저니용출" style="vertical-align:middle;"/>
												준설저니용출
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type3ApplFlag" name="original_type3ApplFlag" value="${resultDetail.type3ApplFlag}">
											<input type="checkbox" id="type3ApplFlagCheck" style="width:15px;"/>
											<label for="type3ApplFlag">
												<img src="<c:url value='/images/warehouse/type3.png'/>" alt="준설장비전복" style="vertical-align:middle;"/>
												준설장비전복
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type4ApplFlag" name="original_type4ApplFlag" value="${resultDetail.type4ApplFlag}">
											<input type="checkbox" id="type4ApplFlagCheck" style="width:15px;"/>
											<label for="type4ApplFlag">
												<img src="<c:url value='/images/warehouse/type4.png'/>" alt="선박사고" style="vertical-align:middle;"/>
												선박사고
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type5ApplFlag" name="original_type5ApplFlag" value="${resultDetail.type5ApplFlag}">
											<input type="checkbox" id="type5ApplFlagCheck" style="width:15px;"/>
											<label for="type5ApplFlag">
												<img src="<c:url value='/images/warehouse/type5.png'/>" alt="선박페인트" style="vertical-align:middle;"/>
												선박페인트
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type6ApplFlag" name="original_type6ApplFlag" value="${resultDetail.type6ApplFlag}">
											<input type="checkbox" id="type6ApplFlagCheck" style="width:15px;"/>
											<label for="type6ApplFlag">
												<img src="<c:url value='/images/warehouse/type6.png'/>" alt="탱크로리" style="vertical-align:middle;"/>
												탱크로리
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type7ApplFlag" name="original_type7ApplFlag" value="${resultDetail.type7ApplFlag}">
											<input type="checkbox" id="type7ApplFlagCheck" style="width:15px;"/>
											<label for="type7ApplFlag">
												<img src="<c:url value='/images/warehouse/type7.png'/>" alt="홍수기" style="vertical-align:middle;"/>
												홍수기
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type8ApplFlag" name="original_type8ApplFlag" value="${resultDetail.type8ApplFlag}">
											<input type="checkbox" id="type8ApplFlagCheck" style="width:15px;"/>
											<label for="type8ApplFlag">
												<img src="<c:url value='/images/warehouse/type8.png'/>" alt="취정수장" style="vertical-align:middle;"/>
												취정수장
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type9ApplFlag" name="original_type9ApplFlag" value="${resultDetail.type9ApplFlag}">
											<input type="checkbox" id="type9ApplFlagCheck" style="width:15px;"/>
											<label for="type9ApplFlag">
												<img src="<c:url value='/images/warehouse/type9.png'/>" alt="유류유출" style="vertical-align:middle;"/>
												유류유출
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type10ApplFlag" name="original_type10ApplFlag" value="${resultDetail.type10ApplFlag}">
											<input type="checkbox" id="type10ApplFlagCheck" style="width:15px;"/>
											<label for="type10ApplFlag">
												<img src="<c:url value='/images/warehouse/type10.png'/>" alt="페놀" style="vertical-align:middle;"/>
												페놀
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type11ApplFlag" name="original_type11ApplFlag" value="${resultDetail.type11ApplFlag}">
											<input type="checkbox" id="type11ApplFlagCheck" style="width:15px;"/>
											<label for="type11ApplFlag">
												<img src="<c:url value='/images/warehouse/type11.png'/>" alt="유해물질" style="vertical-align:middle;"/>
												유해물질
											</label>
											<br/>
											&nbsp;
											<input type="hidden" id="original_type12ApplFlag" name="original_type12ApplFlag" value="${resultDetail.type12ApplFlag}">
											<input type="checkbox" id="type12ApplFlagCheck" style="width:15px;"/>
											<label for="type12ApplFlag">
												<img src="<c:url value='/images/warehouse/type12.png'/>" alt="물고기폐사" style="vertical-align:middle;"/>
												물고기폐사
											</label>
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
</body>
</html>