<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : seminarRegist.jsp
	 * Description : 교육등록 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    			--------    ---------------------------
	 * 2014.09.17		mypark		최초생성
	 *
	 * author mypark
	 * since 2014.09.18
	 *  
	 * Copyright (C) 2014 by 이용 All right reserved.
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
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/seminar.js'/>" ></script>
<script type="text/javascript">
//<![CDATA[
    $(document).ready(function() {
    	setTime(); //시간 세팅
	});        	
	//]]>
</script>
<script type="text/javascript">
	function fn_regist() {
		//document.educationInput.onsubmit();
		//입력값 체크
		if(fnInputCheck()) {
			if (confirm('<spring:message code="common.regist.msg" />')) {
				document.educationInput.action = "<c:url value='/seminar/insertSeminar.do'/>";
				document.educationInput.submit();					
			}
		}
	}
	
	function fn_List() {
		location.href = "/seminar/SeminarScheduleList.do";
	}	
	
	function setTime() {
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		$("#eduDateFrom").datepicker({
			buttonText: '교육시작'
		});
		$("#eduDateTo").datepicker({
			buttonText: '교육종료'
		});
	}
	
	function commonWork1() {
		var stdt = document.getElementById("eduDateFrom");
		var endt = document.getElementById("eduDateTo");
		var seminarId = "";
		if(endt.value != '' && stdt.value > endt.value) {
			alert("교육신청 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
		
		if(stdt.value != '' && endt.value != '') {
			$.ajax({
				type: "POST",
				url: "<c:url value='/seminar/selectCheckSeminarDate.do'/>",
				data: {startDt:stdt.value, endDt:endt.value, seminarId:seminarId.value},
				dataType:"json",
				success : function(result){
					if(result['msg'] == "duplication") {
						alert("교육 일정이 중복되었습니다. \n\n다시 확인 하시기 바랍니다.");
						stdt.focus();
					}
				}
			});
		}
	}
	
</script>
</head>
<body>
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

						<form:form commandName="educationInput" name="educationInput"  method="post">
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
							<input type="hidden" name="writerId" id="writerId" value="<%=((LoginVO)TmsUserDetailsHelper.getAuthenticatedUser()).getId() %>" />
							<!-- 글등록 폼 -->
								<div class="table_wrapper">
									<!-- 글작성 내용 -->
									<table summary="교육 등록 폼. 교육기관, 교육명, 구분, 교육기간, 지역, 교육장소, 강의시간, 교육주관, 완료여부를 입력">
										<colgroup>
										<col width="100px" />
										<col/>
										<col width="100px" />
										<col/>
										<col width="100px" />
										<col/>
										</colgroup>
										<tr>
											<th><label for="">교육기관</label></th>
											<td class="txtL">
												<select name="eduCode">
													<option value="" label="선택"/>
													<c:forEach var="result" items="${eduCode}" varStatus="status">
													<option value="${result.code}" label="${result.codeName}"/>
													</c:forEach>
												</select>
											</td>
											<th><label for="">교육명</label></th>
											<td class="txtL"><input name="eduName" type="text" id="eduName" size="30" maxlength="30" /></td>
											<th><label for="">구분</label></th>
											<td class="txtL"><input name="gubun" type="text" id="gubun" size="30" maxlength="30" /></td>
										</tr>
										<tr>
											<th><label for="">교육기간</label></th>
											<td class="txtL">
												<input type="text" id="eduDateFrom" name="eduDateFrom" size="13" value="" onchange="commonWork1()" alt="교육기간From"/>
												<span>~</span>
												<input type="text" id="eduDateTo" name="eduDateTo" size="13" value="" onchange="commonWork1()" alt="교육기간To"/>
											</td>
											<th><label for="">지역</label></th>
											<td class="txtL"><input name="eduArea" type="text" id="eduArea" size="30" maxlength="30" /></td>
											<th><label for="">교육장소</label></th>
											<td class="txtL"><input name="eduPlace" type="text" id="eduPlace" size="30" maxlength="30" /></td>
										</tr>
										<tr>
											<th><label for="">강의시간</label></th>
											<td class="txtL"><input name="lectureTime" type="text" id="lectureTime" size="30" maxlength="30" /></td>
											<th><label for="">교육주관</label></th>
											<td class="txtL"><input name="eduSuper" type="text" id="eduSuper" size="30" maxlength="30" /></td>
											<th><label for="">완료여부</label></th>
											<td class="txtL">
												<select name="finishYn">
													<option value="N">미완료</option>
													<option value="Y">완료</option>
												</select>
											</td>
										</tr>
									</table>
									<!-- //글수정 내용 -->
									<!-- 버튼 메뉴 -->
									<div id="btArea" style="margin-top:10px">
										<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_basic" onclick="javascript:fn_regist();return false;" alt="등록"/>
										<input type="button" id="btnNoticeList" name="btnNoticeList" value="목록" class="btn btn_basic" onclick="javascript:fn_List();" alt="목록"/>
									</div>      	
									<!-- //버튼 메뉴 -->
								</div>
							
							<!-- //글쓰기 폼 -->
						</form:form>

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