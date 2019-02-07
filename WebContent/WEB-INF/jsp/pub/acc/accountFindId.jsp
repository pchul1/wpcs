<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript" src="/js/common.js"></script>
<c:set var="url" value="<%=request.getRequestURL()%>"/>
<script type="text/javascript">
//<![CDATA[
           
	$(function(){
		<c:if test="${process != 'process'}">
			$('#ctyCode').attr("disabled", true);
			$('#factCode').attr("disabled", true);
			
			$('#deptNo').css('display','none');	
			$('#deptNo').attr("disabled", true);
			
			$('#ctyCode').css('display','none');
			$('#ctyCode').attr("disabled", true);
		</c:if>
		
		$('#deptNoTmp').change(deptNoChange);
		$('#deptNo').change(getCtyCodeWhereDeptNo);
		$('#email2').change(emailChange);
		searchMemberID();
	});
	
	function emailChange() {
		var email2Val = $('#email2').val();
		if (email2Val == 'typing') {
			$('#email1').val('');
		} else {
			$('#email1').val(email2Val);
		}
	}
	
	// 부서정보 선택시...
	function deptNoChange() {
	
		var deptVal = $('#deptNoTmp').val();
	
		$('#ctyCode').attr("disabled", true);
		$('#factCode').attr("disabled", true);
	
		if(deptVal == '7000') {
			// 지자체인 경우..
			$('#ctyCode').attr("disabled", false);
		} else if (deptVal == '8000' || deptVal == '9000'){
			// 시공사 및 방제업체인 경우..
			$('#factCode').attr("disabled", false);
		}
		
		var dropDownSet = $('#deptNo');
		$.getJSON("<c:url value='/pub/member/getDeptCode.do'/>", {upperDeptNo:deptVal}, function (data, status){
			if(status == 'success'){
				
				var len = data.deptCode.length;
				
				dropDownSet.loadSelectDepth2(data.deptCode);
				
				if (len > 0) {
					$('#deptNo').css('display','inline');
					$('#deptNo').attr("disabled", false);
				} else {
					$('#deptNo').css('display','none');
					$('#deptNo').attr("disabled", true);
					
					$('#ctyCode').css('display','none');
					$('#ctyCode').attr("disabled", true);
				}
				
			 } else { 
				return;
			 }
		});
		
	}
	
	// 시/도 정보를 가져온다. where deptCode
	function getCtyCodeWhereDeptNo() {
	
		var deptVal = $('#deptNo').val();
	
		if (deptVal.substr(0,2) == '70') {//지자체일 경우
		
			var dropDownSet = $('#ctyCode');
			$.getJSON("<c:url value='/pub/member/getAreaCtyCodeWhereDeptNo.do'/>", {deptCode:deptVal}, function (data, status){
				 if(status == 'success'){
					 var len = data.ctyCode.length;
					 dropDownSet.loadSelectDepth(data.ctyCode);
					 if (len > 0) {
						 $('#ctyCode').css('display','inline');	
						 $('#ctyCode').attr("disabled", false);
					 } else {
						 $('#ctyCode').css('display','none');	
						 $('#ctyCode').attr("disabled", true);
					 }
					
				 } else { 
					return;
				 }
			});
		} else {
			$('#ctyCode').css('display','none');	
			$('#ctyCode').attr("disabled", true);
		}
	}
	
	function fnAccountFind(){
		var  deptNoTmp = $("#deptNoTmp option:selected").val(); 
		var  deptNo = $("#deptNo option:selected").val();
		var  ctyCode = $("#ctyCode option:selected").val();
		
		var  memberName = $("#memberName").val();
		var  email = $("#email").val();
		var  email1 = $("#email1").val();
		
		if(deptNoTmp == ''){
			alert("관련기관을 선택해주세요.");
			return;
		}
		
		if(memberName == ''){
			alert("이름을 입력 해 주세요.");
			return;
		}
		
		if(email == '' || email1 == '' ){
			alert("이메일을 입력 해 주세요.");
			return;
		}

		<c:if test="${fn:indexOf(url,'waterkorea.or.kr') >= 0 }">
		document.memberVO.action = "https://www.waterkorea.or.kr:443/acc/getAccountFindId.do";
		</c:if>
		<c:if test="${fn:indexOf(url,'waterkorea.or.kr') < 0 }">
		document.memberVO.action = "/acc/getAccountFindId.do";
		</c:if>
		document.memberVO.submit();

	}
function searchMemberID(){
	<c:if test="${!empty findId}">
		$("#divFindResult").show();
		<c:if test="${empty searchId}">
			$("#findId").html("일치하는 정보가 없습니다.");
		</c:if>
		<c:if test="${!empty searchId}">
			$("#findId").html(memberName+"님의 아이디는 "+result.memberId+" 입니다.");
		</c:if>
	</c:if>
}	
</script>
</head>
<body>
<!-- wrap -->

<div id="wrap"> 
  
	<!--header -->
	<div class="header_wrap">
		<c:import url="/WEB-INF/jsp/pub/include/client_header.jsp"/>
	</div>
	<!--header --> 
  
	<!--container -->
	<div class="container_wrap">
		<div id="container"> 
		    
			<!--content wrap -->
			<div class="content_wrap">
				<div id="snb">
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu6.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 계정신청 &gt; <span class="point">ID/PW찾기</span></p>
					<h3>ID/PW찾기</h3>
					<!-- Navi -->
					<div class="list_type01">
						 <div class="section_membership">
						 <div class="section_table03">
							<form:form commandName="memberVO" name="memberVO" method="post">
							<table width="756" border="0" cellspacing="0" cellpadding="0">
								<colgroup>
									<col width="200" />
									<col />
								</colgroup>
								<tbody>
								<tr>
									<th>관련기관</th>
									<td class="td_left">
										<form:select path="deptNoTmp">
											<form:option value="" label="선택"/>
											<c:forEach var="result" items="${deptCode}" varStatus="status">
											<form:option value="${result.deptNo}" label="${result.deptName}"/>
											</c:forEach>
										</form:select>
									
										<form:select path="deptNo">
											<form:option value="" label="선택"/>
											<c:forEach var="result" items="${deptCode}" varStatus="status">
											<form:option value="${result.deptNo}" label="${result.deptName}"/>
											</c:forEach>
										</form:select>
										<form:select path="ctyCode">
											<form:option value="" label="선택"/>
											<c:forEach var="result" items="${areaCtyCodeAll}" varStatus="status">
											<form:option value="${result.code}" label="${result.codeName}"/>
											</c:forEach>
										</form:select>
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td class="td_left">
										<input type="text" name="memberName" id="memberName" size="24"  class="input_20" value="<c:if test="${!empty searchMemverVO }">${searchMemverVO.memberName}</c:if>"/>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td class="td_left">
										<input type="text" name="email" id="email" size="24"  class="input_20" value="<c:if test="${!empty searchMemverVO }">${searchMemverVO.email}</c:if>"/>
										@
										<input type="text" name="email1" id="email1" size="24"  class="input_20" value="<c:if test="${!empty searchMemverVO }">${searchMemverVO.email1}</c:if>"/>
										<form:select path="email2">
											<form:option value="" label="선택"/>
											<form:option value="hanmail.net" label="hanmail.net"/>
											<form:option value="naver.com" label="naver.com"/>
											<form:option value="nate.com" label="nate.com"/>
											<form:option value="typing" label="직접입력"/>
										</form:select>
									</td>
								</tr>
								</tbody>
							</table>
							</form:form>
							<div>
								■ 패스워드는 수질오염 방제정보 시스템 담당자에게 문의 하시기 바랍니다.
							</div>
							<div style="text-align:right;">
								<a href="javascript:fnAccountFind();"><img src="/images/new/btn_find.gif"alt="찾기"/></a>
							</div>
						</div>
						</div>
					</div>
					<div class="list_type01" id="divFindResult" style="display:none;">
						 <div class="section_membership">
						 <div class="section_table03">
							<table width="756" border="0" cellspacing="0" cellpadding="0">
								<colgroup>
									<col width="200" />
									<col />
								</colgroup>
								<tbody>
								<tr>
									<td class="td_left" style="height:50px;text-align:center;font-weight:bold;font-size:16px;">
										<span id="findId" style="font-weight:bold"></span>
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						</div>
					</div>
				</div>
			</div>
			<!--content wrap --> 
		    
		</div>
	</div>
	<!--container --> 
  
	<!--footer -->
	<div class="footer_wrap">
		<div id="footer">
			<c:import url="/WEB-INF/jsp/pub/include/client_footer.jsp" />
		</div>
	</div>
	<!--footer --> 
  
</div>
<!-- wrap -->

</body>
</html>