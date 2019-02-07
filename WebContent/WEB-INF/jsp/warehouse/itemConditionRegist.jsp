<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : workJournalRegist.jsp
	 * Description : 업무일지 입력화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2018.01.03	assist5		최초 생성
	 * 
	 * author choi hoe seop
	 * since 2018.01.
	 * 
	 * Copyright (C) 2018 by Naturetech All right reserved.
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

	});
	
	function goSubmit(){
		var obj = document.dailyWork;
		var msg = "";
		if('${param.seqNo}'=='' || '${param.seqNo}' == null) {
			msg = "<spring:message code="common.save.msg" />";
		} else {
			msg = "<spring:message code="common.update.msg" />";
		}
		if(confirm(msg)){
			if(!obj.files.value){
				alert("파일을 첨부하십시오.");
				obj.files.focus();
				return false;
			} else {
				ban = obj.files.value.substring(obj.files.value.lastIndexOf('.'),obj.files.value.length).toLowerCase();    
				if(ban != ".xls" && ban != ".xlsx"){
					alert("엑셀파일만 첨부 하실수 있습니다.");
					obj.files.focus();
					return false;
				}
				
				obj.submit();
			}
		}
		
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
						<div class="table_wrapper">
							<form:form commandName="dailyWork" name="dailyWork" method="post" action="/warehouse/uploadItemConditionData.do" enctype="multipart/form-data" >
								<div>
									<div style="clear:both;">
									<table style="text-align:left" summary="관리자정보">
										<colgroup>
											<col width="25%">
											<col>
										</colgroup>									
										<tr>
											<th>방제장비물품파일 <span class="red">*</span></th>
											<td>
												<input type="file" name="excel" id="files" size="50" class="tbox03">
											</td>
										</tr>
									</table>
									</div>
									</
									<div id="btSmallArea" style="text-align:right;padding-top:10px;">
										<div style="float:right;">
											<!-- <input type="button" id="btnMenuList" name="btnMenuList" value="목록" class="btn btn_basic" onclick="javascript:selectList();" alt="목록" /> -->
											<input type="button" id="btnAddNotice" name="btnAddNotice" value="저장" class="btn btn_basic" onclick="goSubmit();" alt="저장" />
										</div>
									</div>
								</div>
							</form:form>	
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
	
	<script language="javascript">
	function menuAuth(){
		var menuAuth = ""	;
		
		if(id=='${resultList[0].regId}') {
			menuAuth = "1";
		}		
		return menuAuth;
	}
	if("1" == menuAuth()){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	</script>
</body>
</html>