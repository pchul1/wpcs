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
	
		$('#memberId').keyup(function () { 
	
				if ($(this).val().length < 4) {
					$('#idMsg').html('4자이상 입력해주세요.');
					return;
				}
				
				$.getJSON("<c:url value='/pub/member/checkIDJSON.do'/>", {checkID:$(this).val()}, function (data, status){
					 if(status == 'success'){
						 if (data.checkID == '1') {
							 $('#idMsg').html('아이디가 중복됩니다.');
						 } else {
							 $('#idMsg').empty();
						 }		 
					 } else { 
						return;
					 }
				}); 
		});
		
		$('#overlapIDCheckBtn').css('display','none');
		
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
	
	function fnIdDuplicate(){
		var memberId = $('#memberId').val();
		if(memberId==''){
			alert("아이디를 입력해주세요.");
			return;
		}else if(memberId.length<4){
			alert("아이디를 4자이상 입력해주세요.");
			return;
		}else{
			$.getJSON("<c:url value='/acc/duplicateIdCheck.do'/>", {memberId:memberId}, function (data, status){
				if(status == 'success'){
					 $('#isIdCheck').val(data.isIdCheck);
					 
					 if(data.isIdCheck=="N"){
						 alert("중복 된 아이디가 존재합니다.");
						 return;
					 }else{
						 alert("사용가능합니다.");
						 return;
					 }
				 } else { 
					return;
				 }
			});
		}
	}
	
	/*비밀번호 체크(비밀번호는 영문 대/소문자, 특수기호, 숫자를 포함한 9~32자리만 가능.)*/
	function fnCheckPass(pw){
// 		var alpha_d = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		var alpha_s = "abcdefghijklmnopqrstuvwxyz";
		var number = "1234567890";
		var sChar = "-_=+\|()*&^%$#@!~`?></;,.:'";
		 
		var sChar_Count = 0;
		var alpha_d_Count = 0;
		var alpha_s_Count = 0;
		var alphaCheck = false;
		var numberCheck = false;
		if(10 <= pw.length && pw.length <= 32){
			for(var i=0; i<pw.length; i++){
				if(sChar.indexOf(pw.charAt(i)) != -1){
					sChar_Count++;
				}
// 				if(alpha_d.indexOf(pw.charAt(i)) != -1){
// 					alpha_d_Count++;
// 				}
				if(alpha_s.indexOf(pw.charAt(i)) != -1){
					alpha_s_Count++;
				}
				if(number.indexOf(pw.charAt(i)) != -1){
					numberCheck = true;
				}
			}//for
		  
			if(sChar_Count < 1 || alpha_s_Count < 1 || numberCheck != true){
				//alert("비밀번호는 10~32자 영문,숫자 1자 이상,특수문자 1자 이상으로 조합해주세요");
				$("#pwCheck").removeClass( 'item_blue' );  // 기존 클래스를 지운다.
				$("#pwCheck").addClass( 'item_red' );      // 클래스 추가
				document.getElementById("pwCheck").innerHTML="사용불가";
				
				document.getElementById("pwCheckYn").value="N";
				
				if($('#password_confirm').val() != ''){
					checkPassConfirm($('#password_confirm').val());
				}
				
				return false;
			}//if
		  
		}else{
			//alert("비밀번호는 9~32자 영문,숫자 1자 이상,특수문자 1자 이상으로 조합해주세요");
			$("#pwCheck").removeClass( 'item_blue' );  // 기존 클래스를 지운다.
			$("#pwCheck").addClass( 'item_red' );      // 클래스 추가
			document.getElementById("pwCheck").innerHTML="사용불가";
			document.getElementById("pwCheckYn").value="N";
			
			if($('#password_confirm').val() != ''){
				checkPassConfirm($('#password_confirm').val());
			}
			
			return false;
		}
		
		$("#pwCheck").removeClass( 'item_red' );  // 기존 클래스를 지운다.
		$("#pwCheck").addClass( 'item_blue' );    // 클래스 추가
		document.getElementById("pwCheck").innerHTML="사용가능";
		document.getElementById("pwCheckYn").value="Y";
		
		if($('#password_confirm').val() != ''){
			checkPassConfirm($('#password_confirm').val());
		}
		
		return true; 
	} 
	
	/*비밀번호 확인*/
	function checkPassConfirm(pw){
		
		var passwd = document.getElementById("password").value;
		if(passwd==pw){
			$("#pwConfirm").removeClass( 'item_red' );  // 기존 클래스를 지운다.
			$("#pwConfirm").addClass( 'item_blue' );    // 클래스 추가
			document.getElementById("pwConfirm").innerHTML="일치";
			document.getElementById("pwConfirmYn").value="Y";
			return false;
		}else{
			$("#pwConfirm").removeClass( 'item_blue' );  // 기존 클래스를 지운다.
			$("#pwConfirm").addClass( 'item_red' );    // 클래스 추가
			document.getElementById("pwConfirm").innerHTML="불일치";
			document.getElementById("pwConfirmYn").value="N";
			return false;
		}
	}
	
	//저장처리화면
	function fnAccountApply(form){
		if($('#deptNoTmp').val() == ''){
			alert('관련기관은 필수 입력값입니다.');
			return;
		}
		
		if($('#gradeName').val() == ''){
			alert('직급은 필수 입력값입니다.');
			return;
		}
		
		if($('#memberName').val() == ''){
			alert('이름은 필수 입력값입니다.');
			return;
		}
		
		if($('#memberId').val() == ''){
			alert('아이디는 필수 입력값입니다.');
			return;
		}
		
		if($('#isIdCheck').val() == 'N'){
			alert('아이디 중복확인을 해주세요.');
			return;
		}
		
		if($('#password').val() == ''){
			alert('비밀번호는 필수 입력값입니다.');
			return;
		}
		
		if($('#password_confirm').val() == ''){
			alert('비밀번호 확인은 필수 입력값입니다.');
			return;
		}
		
		if($('#password_confirm').val() == ''){
			alert('비밀번호 확인은 필수 입력값입니다.');
			return;
		}
		
		if($('#email').val() == '' || $('#email1').val() == ''){
			alert('이메일은 필수 입력값입니다.');
			return;
		}
		
		if($('#officeNo').val() == '' || $('#officeNo1').val() == '' || $('#officeNo2').val() == ''){
			alert('사무실 연락처는 필수 입력값입니다.');
			return;
		}
		
		if($('#mobileNo').val() == '' || $('#mobileNo1').val() == '' || $('#mobileNo2').val() == ''){
			alert('핸드폰번호는 필수 입력값입니다.');
			return;
		}
		
		if($('#bigo').val() == ''){
			alert('관리중인 측정소를 입력하세요.');
			return;
		}
		
		var registOK = true;
		
		if(!fn_check()) {
			registOK = false;
		}
		
		if(registOK) {
			if(confirm("계정신청하시겠습니까?")){
				<c:if test="${fn:indexOf(url,'waterkorea.or.kr') >= 0 }">
				form.action ="https://www.waterkorea.or.kr:443/acc/insertMemberApplyProc.do";
				</c:if>
				<c:if test="${fn:indexOf(url,'waterkorea.or.kr') < 0 }">
				form.action ="/acc/insertMemberApplyProc.do";
				</c:if>
				form.submit();
			}
		}
	}
	
	//비밀번호 입력값 체크 하기
	function fn_check() {
		if ($('#password').val().length < 9) {
			alert("비밀번호에 9자리 이상 입력해주세요");
			return false;
		}
	
		if(!strCheck($('#password').val())){
			alert("비밀번호는 영대․소문자, 숫자, 특수문자 중 2종류 이상으로 구성해 주세요.");
			return false;
		}
	
		if($('#password').val() != $('#password_confirm').val()){
			alert("비밀번호 확인이 일치하지 않습니다.");
			return false;
		}
		return true;
	}
	
	function strCheck(strValue) {
		var num = 0;	
		var regexp = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;  // 숫자,영문,특수문자
		for( var i=0; i<strValue.length; i++){
			if(strValue.charAt(i) != " " && regexp.test(strValue.charAt(i)) == true ){
				num++;
				break;
			}
		}	
			
		var num1 = 0;				
		var regexp1 = /[0-9]/; // 숫자만
			
		for( var i=0; i<strValue.length; i++){
			if(strValue.charAt(i) != " " && regexp1.test(strValue.charAt(i)) == true ){
				num1++;
				break;
			}
		}	
			
		var num2 = 0;				
		var regexp2 = /[a-zA-Z]/; // 영문만
		
		for( var i=0; i<strValue.length; i++){
			if(strValue.charAt(i) != " " && regexp2.test(strValue.charAt(i)) == true ){
				num2++;
				break;
			}
		}
			
		var total = parseInt(num)+parseInt(num1)+parseInt(num2);
			
		if (parseInt(total) >= 2) {
			return true; 
		} else {
			return false;
		}
	}

//]]>
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
					<p class="spot">홈 &gt; 계정신청 &gt; <span class="point">계정신청</span></p>
					<h3>계정신청</h3>
					<!-- Navi -->
					<div class="list_type01">
						<img src="/images/new/account_info2.png"alt="정보입력"/>
					</div>
					<div class="list_type01">
						<h4>정보입력</h4>
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
									<th>관련기관<span>(*)</span></th>
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
									<th>직급(위)<span>(*)</span></th>
									<td class="td_left">
										<input type="text" name="gradeName" id="gradeName" size="24"  class="input_20"/>
									</td>
								</tr>
								<tr>
									<th>이름<span>(*)</span></th>
									<td class="td_left">
										<input type="text" name="memberName" id="memberName" size="24"  class="input_20"/>
									</td>
								</tr>
								<tr>
									<th>아이디<span>(*)</span></th>
									<td class="td_left">
										<div style="margin-top:5px;">
										<input type="text" name="memberId" id="memberId" size="24"  class="input_20"/>
										<input type="hidden" id="isIdCheck" name="isIdCheck"  value="N"/>
										<a href="javascript:fnIdDuplicate();"><img src="/images/new/btn_duplicate.gif"alt="중복확인"/></a>
										</div>
										<div style="margin-top:5px; margin-bottom:5px;">
										<span class="item_tip">*4자리이상 입력해야 합니다.</span>
										</div>
									</td>
								</tr>
								<tr>
									<th>비밀번호<span>(*)</span></th>
									<td class="td_left">
										<div style="margin-top:5px;">
											<input type="password" name="password" id="password" size="24"  class="input_20"/>
										</div>
										<div style="margin-top:5px; margin-bottom:5px;">
											<span class="item_tip">*비밀번호는 9자리 이상 영문/대소문자,숫자,특수문자를 혼합해서 사용하실 수 있습니다.</span>
										</div>
									</td>
								</tr>
								<tr>
									<th>비밀번호 확인<span>(*)</span></th>
									<td class="td_left">
										<div style="margin-top:5px;">
											<input type="password" name="password_confirm" id="password_confirm" size="24" class="input_20"/>
										</div>
										<div style="margin-top:5px; margin-bottom:5px;">
											<span class="item_tip">*재확인을 위해서 입력하신 비밀번호를 다시한번 입력해 주세요.</span>
										</div>
									</td>
								</tr>
								<tr>
									<th>이메일<span>(*)</span></th>
									<td class="td_left">
										<input type="text" name="email" id="email" size="24"  class="input_20"/>
										@
										<input type="text" name="email1" id="email1" size="24"  class="input_20"/>
										<form:select path="email2">
											<form:option value="" label="선택"/>
											<form:option value="hanmail.net" label="hanmail.net"/>
											<form:option value="naver.com" label="naver.com"/>
											<form:option value="nate.com" label="nate.com"/>
											<form:option value="typing" label="직접입력"/>
										</form:select>
									</td>
								</tr>
								<tr>
									<th>연락처<span>(*)</span></th>
									<td class="td_left">
										<div style="margin-top:5px">
											-사무실:
											<input type="text" name="officeNo" id="officeNo" size="5"  class="input_20"/> - 
											<input type="text" name="officeNo1" id="officeNo1" size="5"  class="input_20"/> - 
											<input type="text" name="officeNo2" id="officeNo2" size="5"  class="input_20"/>
										</div>
										<div style="margin-top:5px">
											-핸드폰:
											<input type="text" name="mobileNo" id="mobileNo" size="5"  class="input_20"/> - 
											<input type="text" name="mobileNo1" id="mobileNo1" size="5"  class="input_20"/> - 
											<input type="text" name="mobileNo2" id="mobileNo2" size="5"  class="input_20"/>
										</div>
										<div style="margin-top:5px; margin-bottom:5px;">
											-<span style="margin-right:12px;">팩</span>스:
											<input type="text" name="faxNum" id="faxNum" size="5"  class="input_20"/> - 
											<input type="text" name="faxNum1" id="faxNum1" size="5"  class="input_20"/> - 
											<input type="text" name="faxNum2" id="faxNum2" size="5"  class="input_20"/>
										</div>
									</td>
								</tr>
								<tr>
									<th>비고</th>
									<td class="td_left">
										<textarea rows="4" cols="98" id="bigo" name="bigo"></textarea><br/>
										*관리중인 측정소를 기입해 주시기 바랍니다.
									</td>
								</tr>
								</tbody>
							</table>
							</form:form>
						</div>
						</div>
					</div>
					<div class="list_type01">
						<div style="text-align:right;">
							<a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountAppStep1&menu=6'/>"><img src="/images/new/btn_pre.gif"alt="이전단계"/></a>
							<a href="javascript:fnAccountApply(document.memberVO);"><img src="/images/new/btn_apply.gif"alt="신청하기"/></a>
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