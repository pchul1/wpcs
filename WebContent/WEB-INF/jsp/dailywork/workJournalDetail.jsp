<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : workJournalDetail.jsp
	 * Description : 업무일지 상세내용
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
		//시간셋팅
		setTime();
	});
	
	function setTime(){
		//============================= 달 력 Start ======================================
		/* shows the loading div every time we have an Ajax call */
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#workDay").datepicker({
			buttonText: '일자'
		});
		
		var today = new Date(); 
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		$("#workDay").val(today);
	}
	
	function goSubmit(){
		var obj = document.dailyWork;

		if(!obj.files.value){
			alert("파일을 첨부하십시오.");
			obj.files.focus();
			return false;
		}
		
		ban = obj.files.value.substring(obj.files.value.lastIndexOf('.'),obj.files.value.length).toLowerCase();    
		/* if(ban != ".hwp"){
			alert(".hwp파일만 첨부 하실수 있습니다.");
			obj.files.focus();
			return false;
		} */
		
		obj.submit();
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
							<form:form commandName="dailyWork" name="dailyWork" method="post">
								<input type="hidden" name="seqNo" value="${param.seqNo }"/>
								<table class="dataTable" style="text-align:left" summary="그룹정보">
									<colgroup>
										<col width="20%" />
										<col />
									</colgroup>
									<tr>
										<th>권한  코드 <span class="red">*</span></th>
										<td>
											<input name="authorCode" id="authorCode" type="text" readonly="readonly" value="<c:out value='${authorManage.authorCode}'/>" size="40" />&nbsp;<form:errors path="authorCode" />
										</td>
									</tr>
									<tr>
										<th>권한 명 <span class="red">*</span></th>
										<td>
											<input name="authorNm" id="authorNm" type="text" value="<c:out value='${authorManage.authorNm}'/>" required="true" fieldtitle="권한 명" maxlength="50" char="s" size="40" />&nbsp;<form:errors path="authorNm" />
										</td>
									</tr>
									<tr>
										<th>설명</th>
										<td><input name="authorDc" id="authorDc" type="text" value="<c:out value="${authorManage.authorDc}"/>" required="true" fieldtitle="설명" maxlength="50" char="s" size="50" /></td>
									</tr>
									<tr>
										<th>등록일자</th>
										<td><input name="authorCreatDe" id="authorCreatDe" type="text" value="<c:out value="${authorManage.authorCreatDe}"/>" required="true" fieldtitle="등록일자" maxlength="50" char="s" size="80" readonly="readonly" /></td>
									</tr>
								</table>
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
</body>
</html>