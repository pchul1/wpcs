<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * @Class Name  : MemberModify.jsp
	 * @Description : 개인정보수정 화면
	 * @Modification Information
	 * @
	 * @  수정일		수정자			수정내용
	 * @ -------	--------	---------------------------
	 * @ 2010.07.09	kisspa		최초 생성
	 * @ 2014.06.13	lkh			리뉴얼
	 * 
	 * @author kisspa
	 * @since 2010.07.09
	 * @version 1.0
	 * @see
	 * 
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
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="memberVO" staticJavascript="false" xhtml="true" cdata="false"/>
<c:set var="url" value="<%=request.getRequestURL()%>"/>
<script type="text/javaScript" language="javascript">

<c:if test="${param.fase eq 'ok'}">alert('비밀번호를 다시 입력해 주세요');</c:if>

/* ********************************************************
 * 수정 저장처리화면
 ******************************************************** */
 function fn_egov_regist_Member(form){
	var registOK = true;
	
	if($('#password').val().length < 1){
		alert("비밀번호를 입력해 주세요.");
		$('#password').focus();
		registOK = false;
	}
	
	if(registOK){
		form.action = "./MemberAccessAction.do"; //운영에서 사용할 것
		<c:if test="${fn:indexOf(url,'waterkorea.or.kr') >= 0 }">
		form.action ="https://www.waterkorea.or.kr/common/member/MemberAccessAction.do";
		</c:if>
		form.submit();
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
						<div class="table_wrapper" style="clear:both;">
							<div id="btArea">
								<span id="p_total_cnt">※ 비밀번호 확인</span>
							</div>
							<form:form commandName="memberVO" name="memberVO" method="post" enctype="multipart/form-data">
								<input type="hidden" name="mode" value="Modify"/>
								<form:hidden path="memberId"/>
								<table class="dataTable">
									<colgroup>
										<col width="20%">
										<col>
									</colgroup>
									<tr>
										<th>아이디 <span class="asterisk">*</span></th>
										<td style="text-align:left;padding:10px;">
											${memberVO.memberId}
										</td>
									</tr>
									<tr>
										<th>비밀번호 <span class="asterisk">*</span></th>
										<td style="text-align:left;padding:10px;">
											<input type="password" name="password" id="password" size="26" style="height:18px;"/>
											<!--<form:input path="password"/> -->
										</td>
									</tr>
								</table>
								<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
								<div id="btSmallArea" style="text-align:right;margin-top:5px;">
									<input type="submit" id="btnAddNotice" name="btnAddNotice" value="확인" class="btn btn_basic" onclick="JavaScript:fn_egov_regist_Member(document.memberVO);" alt="확인" />
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
</body>