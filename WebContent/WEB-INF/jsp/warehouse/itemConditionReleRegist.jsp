<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : itemConditionReleRegist.jsp
	 * Description : 방제물품 출고  화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2012.11.12	 윤일권		최초 생성
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
	//목록
	function fnGoListPage(){
		location.href = "<c:url value='/warehouse/itemConditionManageList.do'/>";
	}
	
	//저장
	function fnGoInsert(){
		var returnValue = 'true';
		
		var possibleCnt = 0;
		var itemCnt = 0;
		
		if( $('#possibleCnt').val() != '' ){
			possibleCnt = parseInt($('#possibleCnt').val());
			itemCnt = parseInt($('#itemCnt').val());
			
			if(possibleCnt > itemCnt){
				alert('출고가능 수보다 많습니다');
				$('#possibleCnt').focus();
				returnValue = 'false';
			}
		}else{
			alert('출고수량이 없습니다');
			$('#possibleCnt').focus();
			returnValue = 'false';
		}
		
		//등록값 체크
		if(returnValue == 'true'){
			var frm = document.insertForm;
			frm.action = "<c:url value='/warehouse/itemConditionReleRegist.do'/>";
			frm.submit();
		}else{
			return false;
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
			inputValue.focus();
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
						
						<div class="topBx">
							<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:fnGoListPage();" alt="목록"/>
						</div>
						
						<div class="table_wrapper">
						
						<form name="insertForm" method="post">
							<input type="hidden" name="mode" id="mode" value="insertRele"/>
							
							<table summary="뭎품정보" style="text-align:left;">
								<colgroup>
									<col width="15%">
									<col>
								</colgroup>
								<c:forEach items="${resultDetail}" var="resultDetail" varStatus="status">
								<tr>
									<th>창고<span class="red">*</span></th>
									<td>
										<input type="text" name="whName" id="whName" value="${resultDetail.whName}" style="width:240px; background-color:#D5D5D5;" readonly="readonly"/>
										<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"/>
									</td>
								</tr>
								<tr>
									<th>분류</th>
									<td>
										<input type="text" name="upperGroupName" id="upperGroupName" value="${resultDetail.upperGroupName}" style="width:240px; background-color:#D5D5D5;" readonly="readonly"/>
										<input type="text" name="groupName" id="groupName" value="${resultDetail.groupName}" style="width:240px; background-color:#D5D5D5;" readonly="readonly"/>
										<input type="hidden" name="upperGroupCode" id="upperGroupCode" value="${resultDetail.upperGroupCode}"/>
										<input type="hidden" name="groupCode" id="groupCode" value="${resultDetail.groupCode}"/>
									</td>
								</tr>
								<tr>
									<th>물품<span class="red">*</span></th>
									<td>
										<input type="text" name="itemName" id="itemName" value="${resultDetail.itemName}" style="width:240px; background-color:#D5D5D5;" readonly="readonly"/>
										<input type="hidden" name="itemCode" id="itemCode" value="${resultDetail.itemCode}"/>	
									</td>
								</tr>
								<tr>
									<th>규격</th>
									<td>
										<input type="text" name="itemUnit" id="adminTelno" value="${resultDetail.itemUnit}" style="width:240px; background-color:#D5D5D5;" readonly="readonly"/>
									</td>
								</tr>
								<tr>
									<th>단위</th>
									<td><input type="text" name="itemStan" id="itemStan" value="${resultDetail.itemStan}" style="width:240px; background-color:#D5D5D5;" readonly="readonly"/></td>
								</tr>
								<tr>
									<th>출고가능수량</th>
									<td>
										<input type="text" name="itemCnt" id="itemCnt" value="${resultDetail.itemCnt}" style="width:240px; background-color:#D5D5D5;" readonly="readonly"/>
									</td>
								</tr>
								<tr>
									<th>출고수량<span class="red">*</span></th>
									<td>
										<input style="width:240px; ime-mode:disabled;" type="text" name="possibleCnt" id="possibleCnt" onkeyup="checkNum(this)"/>
										<font color="red">(숫자만 입력가능)</font>
									</td>
								</tr>
								<tr>
									<th>설명</th>	
									<td>
										<textarea name="releDesc" id="releDesc" style="width:830px"></textarea>
									</td>
								</tr>
								</c:forEach>
							</table>
							</form>
							<div id="btArea" class="mtop10">
								<input type="button" id="btnInsert" name="btnInsert" value="저장" class="btn btn_basic" onclick="javascript:fnGoInsert();" />
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